<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>발주 상세</title>
    <style>
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
 <script>   
    document.addEventListener("DOMContentLoaded", function() {
        function formatPhoneNumber(phoneNumber) {
            return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
        }
        
        function formatBusinessNumber(businessNumber) {
            return businessNumber.replace(/(\d{3})(\d{2})(\d{5})/, "$1-$2-$3");
        }

        document.querySelectorAll(".format-phone").forEach(el => {
            el.innerText = formatPhoneNumber(el.innerText);
        });

        document.querySelectorAll(".format-business").forEach(el => {
            el.innerText = formatBusinessNumber(el.innerText);
        });
    });
	 // 모달 열기
	    function openModal(message, onConfirm) {
	        document.querySelector(".modal-message").innerHTML = message;
	        document.querySelector(".modal-overlay").style.display = "block";
	
	        // 확인 버튼 이벤트 핸들러 설정
	        const confirmButton = document.querySelector(".confirm");
	        confirmButton.onclick = () => {
	            document.querySelector(".modal-overlay").style.display = "none";
	            if (typeof onConfirm === "function") {
	                onConfirm(); // 확인 콜백 호출
	            }
	        };
	
	        // 취소 버튼 클릭 시 모달 닫기
	        document.querySelector(".cancel").onclick = () => {
	            document.querySelector(".modal-overlay").style.display = "none";
	        };
	    }
	
	    // 삭제 버튼 클릭 시 모달 열기
	    function handleDelete(clientNo) {
	        openModal("정말 삭제하시겠습니까?", () => {
	            // 삭제 로직 실행
	            location.href = 'deleteClient?client_No=' + clientNo;
	        });
	    }
</script>
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/insert.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <div class="insert-wrapper">
                
                    <!-- 서브메뉴랑 버튼 들어있는 헤더 -->
                    <div class="insert-header">
                        <div>
                            <div class="insert-submenu">거래처 관리 > 거래처 상세</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>거래처 상세</h1>
                            </div>
                        </div>
				        <div class="insert-buttons">
				        	<button class="insert-empty-button" onclick="location.href='listClient'">목록</button>
				            <button class="insert-full-button" onclick="location.href='updateFormClient?client_No=${client.client_No}'">수정</button>
				            <button class="insert-full-button" onclick="handleDelete('${client.client_No}')">삭제</button>
					       </div>
					     </div>
                        </div>
                        <div class="insert-header-content">
				        <table class="insert-table">
				            <tr>
				            <th>거래처 코드</th><td>${client.client_No}</td>
				            <th>회사명</th><td>${client.client_Name}</td>
				            </tr>
				            
				            <tr>
				            <th>구분</th>
				                <td>
				                    <c:choose>
				                        <c:when test="${client.client_Type == 1}">매출처</c:when>
				                        <c:when test="${client.client_Type == 0}">매입처</c:when>
				                        <c:otherwise>기타</c:otherwise>
				                    </c:choose>
				                </td>
				            
				            <th>대표자</th><td>${client.client_Ceo}</td>
				            </tr>
				            <tr>
				            <th>사업자 번호</th><td class="format-business">${client.business_No}</td>
				            <th>이메일</th><td>${client.client_Email}</td>
				            </tr>
				            <tr>
				            <th>기업 전화번호</th><td class="format-phone">${client.client_Tel}</td>
				            <th>대표자 전화번호</th><td class="format-phone">${client.ceo_Tel}</td>
				            </tr>
				            <tr>
				            <th>등록일</th><td>${client.reg_Date}</td>
				            <th>담당자</th><td>${client.emp_Name}</td>
				            </tr>
				            
				        </table>
				
					    
 			       	</div>
	            <!-- End of Main Content -->
				 <div class="modal-overlay">
				        <div class="modal-confirm">
				            <p class="modal-message">정말 삭제하시겠습니까?</p>
				            <div class="modal-actions">
				                <button class="confirm">확인</button>
				                <button class="cancel">취소</button>
				            </div>
				        </div>
    				</div>

		</div>
        <%@ include file="../footer1.jsp" %>
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
