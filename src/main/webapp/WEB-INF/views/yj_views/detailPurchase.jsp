<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
<%@ include file="../menu.jsp" %>
    
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
    function handleDelete() {
        openModal("정말 삭제하시겠습니까?", () => {
            // 삭제 로직 실행
            location.href = "deletePurchase?purchase_date=${purchase.purchase_date}&client_no=${purchase.client_no}&status=${purchase.status}";
        });
    }
</script>
<link rel="stylesheet" href="<c:url value='/css/board.css' />">
</head>
<body>
    <div class="bb">
    </div>
	<div class="center-container">
	<h2>발주 상세</h2>
	<table>
		<tr><th>제목</th><td>${purchase.title }</td></tr>
		<tr><th>매입일자</th><td>${purchase.purchase_date}</td></tr>
		<tr><th>요청배송일</th><td>${purchase.req_delivery_date.substring(0,10) }</td></tr>
		<tr><th>담당자</th><td>${purchase.emp_name }</td></tr>
		<tr><th>거래처명</th><td>${purchase.client_name }</td></tr>
		<tr><th>비고</th><td>${purchase.remarks }</td></tr>
		
		<table>
			<tr><th>품목명</th><th>단가</th><th>수량</th><th>총금액</th></tr>
				<c:forEach var="purchase_detail" items="${purchase_detail}">
					<tr>
						<td>${purchase_detail.product_name}</td>
						<td>${purchase_detail.price}</td>
						<td>${purchase_detail.quantity}</td>
						<td><fmt:formatNumber value="${purchase_detail.price * purchase_detail.quantity}" type="number" pattern="#,###" /></td>
					</tr>
					<c:set var="num" value="${num - 1 }"></c:set>
				</c:forEach>
		</table>
		
		<tr><td colspan="2">
		    <input type="button" value="목록" onclick="history.back()">
		    
		    <c:if test="${purchase.status == 0}">
		        <input type="button" value="수정" 
		            onclick="location.href='updateFormPurchase?purchase_date=${purchase.purchase_date}&client_no=${purchase.client_no}&status=${purchase.status}'">
		        <input type="button" value="삭제" onclick="handleDelete()">
		    </c:if>
		</td></tr>
	</table>
	</div>
	
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