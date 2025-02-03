<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
	<div class="bb"></div>
	<div>
		<h1>수주 상세 조회</h1>
		<!-- 수주 -->
		<table>
			<tr><th>제목</th><td>${infoSales.title}</td></tr>
			<tr><th>매출일자</th><td>${infoSales.sales_Date}</td></tr>
			<tr><th>요청배송일</th><td>${infoSales.req_Delivery_Date}</td></tr>
			<tr><th>담당자</th><td>${infoSales.emp_Name}</td></tr>
			<tr><th>거래처명</th><td>${infoSales.client_Name}</td></tr>
			<tr><th>비고</th><td>${infoSales.remarks}</td></tr>
		</table>
		
		<!-- 품목 -->
			<table>
				<thead>
					<tr>
						<th>품목명</th>
						<th>단가</th>
						<th>수량</th>
						<th>총금액</th>
					</tr>
				</thead>
			<tbody>
				<c:forEach var="product" items="${salesProductList}">
					<tr>
						<td>${product.product_Name}</td>
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
			<button type="button" onclick="location.href='/updateSales?sales_Date=${infoSales.sales_Date}&client_No=${infoSales.client_No}'">수정</button>			
			<button type="button" onclick="submitForm('/sales/infoSales')">삭제</button>
		</div>
	</div>
</body>
</html>
