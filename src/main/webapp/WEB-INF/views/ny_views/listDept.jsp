<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부서 조회</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="/css/list.css" rel="stylesheet">


<style>
    .list-empty-button{
    	padding: 8px 12px;
    	font-size: 12px;
    	border-radius: 4px;
    	cursor: pointer;
   		background-color: white;
   		color: #4e73df;
    	border: 1px solid #4e73df;
	}

	
	.detail-full-button{
    padding: 8px 12px;
    font-size: 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    background-color: #4e73df;
    color: white;
}

.detail-empty-button{
    padding: 8px 12px;
    font-size: 12px;
    border-radius: 4px;
    cursor: pointer;
    background-color: white;
    color: #4e73df;
    border: 1px solid #4e73df;
}
    /* 모달 스타일 */
    .modal-overlay {
        display: none; /* 기본적으로 숨김 */
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .modal-confirm {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        width: 300px;
        text-align: center;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    .modal-confirm p {
        margin: 20px 0;
    }

    .modal-actions {
        display: flex;
        justify-content: center;
        gap: 10px;
    }

    .modal-actions button {
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .modal-actions .confirm {
        background-color: #ff5e57;
        color: #fff;
    }

    .modal-actions .cancel {
        background-color: #ccc;
        color: #000;
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

//삭제할 부서 정보를 저장할 변수
let deleteDeptNo = null; 
let deleteDeptName = null; 

function confirmDelete(dept_No, dept_Name) {
    $.ajax({
        url: '/HR/countEmpInDept',
        type: 'GET',
        data: { dept_No: dept_No },
        success: function(empCount) {
            deleteDeptNo = dept_No;   // 전역 변수에 저장
            deleteDeptName = dept_Name;  

            let confirmMessage = dept_Name + " 부서는 " + empCount + "명의 직원을 포함하고 있습니다.<br>삭제를 진행하겠습니까?";
            
            openModal(confirmMessage, executeDelete); // 모달 열기
        },
        error: function() {
            alert('직원 수 조회 오류');
        }
    });
}

// 실제 삭제 실행 함수
function executeDelete() {
    if (deleteDeptNo !== null) {
        window.location.href = '/HR/deleteDept?dept_No=' + deleteDeptNo;
    }
}

function editRow(button) {
    // 현재 행(row)을 찾아온다
    var row = $(button).closest('tr');
    
    // 부서 이름과 전화번호 셀(td)을 찾는다
    var deptNameCell = row.find('td:eq(1)');
    var deptTelCell = row.find('td:eq(2)');
    var deleteButton = row.find('td:eq(3)').find("button"); // 삭제 버튼 찾기

    // 현재 텍스트를 input으로 변경
    var deptName = deptNameCell.text().trim();
    var deptTel = deptTelCell.text().trim();

    deptNameCell.html('<input type="text" name="dept_Name" value="' + deptName + '">');
    deptTelCell.html('<input type="text" name="dept_Tel" value="' + deptTel + '">');

    // "삭제" 버튼 숨기기
    deleteButton.hide();

    // "수정" 버튼을 "저장" 버튼으로 변경
    $(button).replaceWith('<button class="btn detail-full-button" onclick="saveRow(this)">저장</button>');
}

function saveRow(button) {
    var row = $(button).closest('tr');

    var deptNo = row.find('td:eq(0)').text().trim();
    var deptName = row.find('td:eq(1)').find('input').val();
    var deptTel = row.find('td:eq(2)').find('input').val();
    var deleteButton = row.find('td:eq(3)').find("button"); // 삭제 버튼 찾기

    $.ajax({
        url: '/HR/updateDept',
        type: 'POST',
        data: {
            dept_No: deptNo,
            dept_Name: deptName,
            dept_Tel: deptTel
        },
        success: function(response) {
            row.find('td:eq(1)').text(deptName);
            row.find('td:eq(2)').text(deptTel);

            // "저장" 버튼을 다시 "수정" 버튼으로 변경
            $(button).replaceWith('<input type="button" class="btn detail-full-button" value="수정" onclick="editRow(this)">');

            // "삭제" 버튼 다시 보이기
            deleteButton.show();
        },
        error: function() {
            alert('수정 중 오류가 발생했습니다.');
        }
    });
}



//모달 열기
function openModal(message, onConfirm) {
    document.querySelector(".modal-message").innerHTML = message;
    document.querySelector(".modal-overlay").style.display = "block";

    document.querySelector(".confirm").onclick = () => {
        document.querySelector(".modal-overlay").style.display = "none";
        if (typeof onConfirm === "function") {
            onConfirm();
        }
    };

    document.querySelector(".cancel").onclick = () => {
        document.querySelector(".modal-overlay").style.display = "none";
    };
}

</script>
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>

            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">인사관리 > 부서 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>부서 조회</h1>
                        </div>
                    </div>
                    <div class="list-buttons">
                   <input type="button" value="직원목록" class="btn list-empty-button" onclick="location.href='/All/HR/listEmp'">
                    </div>
                </div>
                <div class="list-header2">
                 
 
                </div>

               

                <table class="list-table">
                    <thead>
                    <tr>
                        <th>부서번호</th>
                        <th>부서이름</th>
                        <th>부서전화번호</th>
                        <th>조치</th>
                      
                    </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach var="dept" items="${listDept}">
                        		<tr>
                            	<td>${dept.dept_No}</td>
                				<td>${dept.dept_Name}</td>
                				<td>${dept.dept_Tel}</td>
								<td> 
								<input type="button" class="btn detail-full-button" value="수정" onclick="editRow(this)">
								<button onclick="confirmDelete(${dept.dept_No} , 
								'${dept.dept_Name}')" class="btn detail-full-button" >삭제</button>
                    			</td>
                       			</tr>
                
                    </c:forEach>
                    </tbody>
                </table>

    


            </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="../footer1.jsp" %>
    </div>
</div>

<!-- jQuery (항상 가장 먼저 로드) -->
<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
<script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin (jQuery Easing 등) -->
<script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Custom scripts -->
<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>


	    <!-- 모달 HTML -->
    <div class="modal-overlay">
        <div class="modal-confirm">
            <p class="modal-message">정말 삭제하시겠습니까?</p>
            <div class="modal-actions">
                <button class="confirm">확인</button>
                <button class="cancel">취소</button>
            </div>
        </div>
    </div>


</body>

</html>
