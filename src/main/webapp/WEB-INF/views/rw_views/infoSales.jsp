<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>수주 상세 조회</title>
<style type="text/css">
.bb { width: 180px; }
table {
   width: 100%;
   border-collapse: collapse;
   margin: 0 auto;
   margin-bottom: 20px;
}
th, td {
   border: 1px solid #ddd;
   padding: 8px;
   text-align: left;
   vertical-align: middle;
}
th { background-color: #f2f2f2; }
thead th { text-align: center; }
.modal {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    padding: 20px;
    border: 1px solid #ddd;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    max-width: 300px;
    width: 90%;
    z-index: 1000; 
}
.modal-content { text-align: center; }
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); 
    z-index: 999;
    display: none;
}
.modal-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 15px;
}
.button {
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
}
/* 취소 버튼 (회색) */
.cancel-button {
    background-color: #6c757d;
    color: white;
}
/* 삭제 버튼 (파란색) */
.delete-button {
    background-color: #007bff;
    color: white;
}
.cancel-button:hover {
    background-color: #5a6268;
}
.delete-button:hover {
    background-color: #0056b3;
}
.delete-success {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #4CAF50; 
    color: white;
    padding: 15px 25px;
    border-radius: 8px;
    font-size: 16px;
    text-align: center;
    z-index: 1100;
    display: none;
}
</style>
</head>
<body>
	<div class="bb"></div>
	<div>
		<h1>수주 상세 조회</h1>
		<!-- 수주 -->
		<table>
			<tr><th>제목</th><td>${infoSales.title}</td></tr>
			<tr><th>매출일자</th><td>${infoSales.sales_date}</td></tr>
			<tr><th>요청배송일</th><td>${infoSales.req_delivery_date}</td></tr>
			<tr><th>담당자</th><td>${infoSales.emp_name}</td></tr>
			<tr><th>거래처명</th><td>${infoSales.client_name}</td></tr>
			<tr><th>비고</th><td>${infoSales.remarks}</td></tr>
		</table>

		<!-- 품목정보 -->
			<table>
				<thead>
					<tr>
						<th>제품명</th>
						<th>단가</th>
						<th>수량</th>
						<th>총금액</th>
					</tr>
				</thead>
			<tbody>
				<c:forEach var="product" items="${infoSalesDetails}">
					<tr>
						<td>${product.product_name}</td>
						<td>${product.price}</td>
						<td>${product.quantity}</td>
						<td><fmt:formatNumber value="${product.totalPrice}" type="number" pattern="#,###" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 버튼 -->
		<div>
			<button type="button" onclick="history.back()">목록</button>
			
			<!-- 상태가 '0'(대기)일 때만 수정/삭제 버튼 표시 -->
		    <c:if test="${infoSales.status == '0'}">
		        <button type="button" onclick="location.href='/sales/updateSales?sales_date=${infoSales.sales_date}&client_no=${infoSales.client_no}'">수정</button>
		        <button type="button" onclick="openDeleteSalesModal()">삭제</button>
 			<!-- alert 방식 <button type="button" onclick="confirmDeleteSales()">삭제</button> -->
		    </c:if> 
		    
		<!-- 모달 배경(어두운 효과) -->
		<div id="modalOverlay" class="modal-overlay" style="display: none;"></div>
		
		<!-- 삭제 확인 모달 -->
		<div id="deleteSalesModal" class="modal" style="display: none;">
		    <div class="modal-content">
		        <p>정말 삭제하시겠습니까?</p>
		        <div class="modal-buttons">
		        	<button type="button" class="button delete-button" onclick="deleteSales()">삭제하기</button>
		            <button type="button" class="button cancel-button" onclick="closeDeleteSalesModal()">취소하기</button>
		        </div>
		    </div>
		</div>     
		</div>
	</div>
	
<!-- 삭제 기능 -->	
<script>
/* 수주 삭제할지 여부 확인 - alert 방식(모달로 변경) */
/* function confirmDeleteSales() {
    if (confirm('정말 삭제하시겠습니까?')) {
        deleteSales();
    }
} */
 
/* 모달 열기 */
function openDeleteSalesModal() {
    document.getElementById('deleteSalesModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block'; // 배경 어두워지는 스타일 적용
}

/* 모달 닫기 */
function closeDeleteSalesModal() {
    document.getElementById('deleteSalesModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none'; // 배경 숨김
}

/* 모달 외부 클릭 시에도 닫기 */
document.getElementById('modalOverlay').addEventListener('click', closeDeleteSalesModal);
 
/* 수주 삭제 요청 - POST 방식으로 /deleteSales 경로에 삭제요청 보냄 */
function deleteSales() {
	closeDeleteSalesModal();
	
	// 현재 페이지에서 삭제할 데이터값 가져옴
    const salesDate = '${infoSales.sales_date}';
    const clientNo = '${infoSales.client_no}';
    const status = '${infoSales.status}';
    
    // 값이 하나라도 없으면 삭제 요청 안보냄
    if (!salesDate || !clientNo || !status) {
        alert("삭제할 데이터가 올바르지 않습니다.");
        return;
    }
    
    // 서버로 보낼 데이터전송 폼 동적 생성
    const form = document.createElement('form');
    form.method = 'POST'; // POST 전송방식
    form.action = '/sales/deleteSales';
    
    // sales_date 값 넣은 input1 생성
    const inputSalesDate = document.createElement('input');
    inputSalesDate.type = 'hidden';
    inputSalesDate.name = 'sales_date';
    inputSalesDate.value = '${infoSales.sales_date}';

    // client_no 값 넣은 input2 생성
    const inputClientNo = document.createElement('input');
    inputClientNo.type = 'hidden';
    inputClientNo.name = 'client_no';
    inputClientNo.value = '${infoSales.client_no}';

    // status 값 넣은 input2 생성
    const inputStatus = document.createElement('input');
    inputStatus.type = 'hidden';
    inputStatus.name = 'status';
    inputStatus.value = status;

    // 폼에 input 요소 추가
    form.appendChild(inputSalesDate);
    form.appendChild(inputClientNo);
    form.appendChild(inputStatus);

    // 바디에 폼 추가한 후 서버로 전송
    setTimeout(() => {
        document.body.appendChild(form);
        form.submit();
    }, 1000); // 1초 후에 이동
}
</script>
</body>
</html>
