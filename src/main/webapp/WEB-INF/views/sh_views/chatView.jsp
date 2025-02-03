<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../footer.jsp" %>
<%@ include file="../menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
	* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

/* 메인 컨테이너 */
.container {
    width: 80%;
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
}

/* 제목 */
.container h1 {
    text-align: center;
    color: #FFBB00;
    margin-bottom: 15px;
    font-size: 24px;
    font-weight: bold;
}

/* 채팅창 */
.chating {
    width: 100%;
    height: 450px;
    overflow-y: auto;
    border-radius: 8px;
    padding: 15px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    background: #f4f4f4;
    border: 1px solid #ddd;
}

/* 메시지 스타일 */
.chating p {
    max-width: 70%;
    padding: 12px 16px;
    border-radius: 20px;
    font-size: 14px;
    line-height: 1.5;
}

/* 내 메시지 */
.chating .me {
    align-self: flex-end;
    background-color: #007bff;
    color: white;
    text-align: right;
}

/* 상대방 메시지 */
.chating .others {
    align-self: flex-start;
    background-color: #e0e0e0;
    color: #333;
    text-align: left;
}

/* 메시지 입력 영역 */
#yourMsg {
    display: flex;
    width: 100%;
    align-items: center;
    margin-top: 15px;
}

#sendMsg {
    flex: 1;
    height: 50px;
    padding: 15px;
    font-size: 16px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background: #fff;
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 90%;
}

/* 버튼 스타일 */
button {
    padding: 12px 20px;
    border: none;
    border-radius: 8px;
    background: #007bff;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
    margin-left: 10px;
}

button:hover {
    background: #0056b3;
}
	
	</style>
</head>
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
                    $("#chating").append("<p class='me'>나: " + jsonMsg.msg + "</p>");
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
</script>
<body>
	<div id="container" class="container">
		<h1>채팅</h1>
		<input type="hidden" id="sessionId" value="">
		<div id="meName"></div>
		<div id="chating" class="chating">
		</div>
		<div id="member" class="member">
		</div>
		
		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
				</tr>
			</table>
		</div>
		<div id="yourNameDel">
			<table class="deleteTable">
				<tr>
					<th>사용자명 삭제</th>
					<!-- <th><input type="text" name="userName" id="userName"></th> -->
					<th><button onclick="sendUser('Delete')" id="startBtn">이름 삭제</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="sendMsg" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>