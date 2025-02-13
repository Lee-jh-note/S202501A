<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Arial', sans-serif;
    }

    body {
        background-color: #f4f4f4;
    }

    .container {
        width: 90%;
        max-width: 600px;
        margin: 30px auto;
        padding: 15px;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
    }

    .container h1 {
        text-align: center;
        color: #3d3d3d;
        font-size: 24px;
        font-weight: bold;
    }

    .chating {
        width: 100%;
        height: 450px;
        overflow-y: auto;
        border-radius: 10px;
        padding: 15px;
        display: flex;
        flex-direction: column;
        gap: 10px;
        background: #fff;
        border: 1px solid #ddd;
    }

    .chating p {
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 15px;
        font-size: 14px;
        line-height: 1.5;
    }

    .chating .me {
        align-self: flex-end;
        background-color: #fae100;
        color: #000;
        text-align: right;
    }

    .chating .others {
        align-self: flex-start;
        background-color: #ececec;
        color: #333;
        text-align: left;
    }

    #yourMsg {
        display: flex;
        flex-direction: column;
        width: 100%;
        align-items: center;
        margin-top: 15px;
        gap: 10px;
    }

    #sendMsg, #userName {
        width: 100%;
        height: 45px;
        padding: 12px;
        font-size: 15px;
        border-radius: 20px;
        border: 1px solid #0056b3;
        background: #fff;
        box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .send-btn, .start-btn {
        width: 100%;
        padding: 12px 18px;
        border: none;
        border-radius: 20px;
        background: #0056b3;
        color: white;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    .send-btn:hover, .start-btn:hover {
        background: #f1d600;
    }

    #yourName {
        margin-top: 15px;
        text-align: center;
        width: 100%;
    }

    .inputTable {
        width: 100%;
        margin: 0 auto;
    }

    .inputTable th, .inputTable td {
        padding: 10px;
        text-align: center;
    }

</style>
<script type="text/javascript">
    var ws;

    function wsOpen() {
        console.log("wsOpen  location.host: " + location.host);
        var wsUri = "ws://" + location.host + "${pageContext.request.contextPath}/chating";
        ws = new WebSocket(wsUri);
        wsEvt();
    }

    function wsEvt() {
        console.log("WebSocket event setup started.");

        // 소켓이 열리면 동작
        ws.onopen = function () {
            console.log("WebSocket connection established.");
        };

        // 메시지를 받으면 동작
        ws.onmessage = function (data) {
            var msg = data.data;
            var memberSave = false;
            console.log("Message received: ", msg);

            if (msg && msg.trim() !== '') {
                memberSave = false;
                var jsonMsg = JSON.parse(msg);

                if (Array.isArray(jsonMsg) && Object.keys(jsonMsg).length > 1) {
                    memberSave = true;
                    console.log("User list updated. Count: " + Object.keys(jsonMsg).length);
                }
            }

            if (jsonMsg.type === "getId") {
                console.log("Received session ID.");
                var sid = jsonMsg.sessionId || "";
                if (sid) {
                    $("#sessionId").val(sid);
                    sendUser('Create');
                }
            } else if (jsonMsg.type === "message") {
                if (jsonMsg.sessionId === $("#sessionId").val()) {
                    $("#chating").append("<p class='me'> " + jsonMsg.msg + "</p>");
                } else {
                    $("#chating").append("<p class='others'>" + jsonMsg.userName + ": " + jsonMsg.msg + "</p>");
                }
            }

            if (memberSave) {
                $('#member_sub').remove();
                var str = "<select name='member' id='member_sub' class='member_sub'><option value='ALL'>전체</option>";
                $(jsonMsg).each(function () {
                    if (this.sessionId !== $("#sessionId").val()) {
                        str += "<option value='" + this.sessionId + "'>" + this.userName + "</option>";
                    }
                });
                str += "</select>";
                $('#member').append(str);
                memberSave = false;
            } else {
                console.warn("Unknown message type!");
            }
        };

        document.addEventListener("keypress", function (e) {
            if (e.keyCode === 13) { // Enter key press
                send();
            }
        });
    }

    function sendUser(saveStatus) {
        var userOption = {
            type: "userSave",
            sessionId: $("#sessionId").val(),
            userName: $("#userName").val(),
            saveStatus: saveStatus
        };
        console.log("Sending user data: ", userOption);
        ws.send(JSON.stringify(userOption));

        if (saveStatus === "Delete") {
            console.log("User deleted.");
            window.open(location.href, "_self", "");
            window.close();
        }
    }

    $(document).ready(function() {
        chatName();
    });

    function chatName() {
        var userName = $("#userName").val();
        console.log("ChatName function called with username: ", userName);
        if (!userName || userName.trim() === "") {
            console.log("Please enter a valid username.");
            $("#userName").focus();
        } else {
            wsOpen();
            $("#meName").append('나의 이름: ' + userName);
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() {
        var option = {
            type: "message",
            sessionId: $("#sessionId").val(),
            userName: $("#userName").val(),
            yourName: $("#member_sub").val(),
            msg: $("#sendMsg").val()
        };
        console.log("Sending message: ", option);
        ws.send(JSON.stringify(option));
        $('#sendMsg').val("");
    }

    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("sendMsg").addEventListener("keydown", function(event) {
            if (event.key === "Enter" && !event.repeat) {
                event.preventDefault();
                send();
            }
        });
    });

</script>
</head>
<body id ="pagetop">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>
    
    <div id="content-wrapper" class="d-flex flex-column">
    	<div id="content">
    	  <%@ include file="../header1.jsp" %>
    	  <div class="list-wrapper">
    <div class="container">
        <h1>채팅</h1>
        <input type="hidden" id="sessionId" value="">
        <div id="meName"></div>

        <div id="chating" class="chating"></div>

        <div id="member" class="member"></div>

        <div id="yourName">
            <table class="inputTable">
                <tr>
                    <td><input type="text" name="userName" id="userName" value="${empName}"></td>
                    <td><button onclick="chatName()" class="start-btn">이름 등록</button></td>
                </tr>
            </table>
        </div>

        <div id="yourMsg">
            <table class="inputTable">
                <tr>
                    <td><input id="sendMsg" placeholder="메시지를 입력하세요."></td>
                    <td><button onclick="send()" class="send-btn">내용 전송</button></td>
                </tr>
            </table>
        </div>
    </div>
    </div>
    </div>
</div>
</div>
</div>
<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="../js1/sb-admin-2.min.js"></script>
</body>
</html>
