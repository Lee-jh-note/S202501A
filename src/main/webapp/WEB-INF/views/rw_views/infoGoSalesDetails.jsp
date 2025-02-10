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
<title>출고 상세조회</title>
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
</style>
</head>
<body>
	<div class="bb"></div>
	<div>
		<h1>출고 상세조회</h1>
		<table>
			<tr><th>매출일자</th><td>${infoGoSalesDetails.sales_date}</td></tr>
			<tr><th>담당자</th><td>${infoGoSalesDetails.emp_name}</td></tr>
			<tr><th>거래처명</th><td>${infoGoSalesDetails.client_name}</td></tr>
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
				<c:forEach var="salesProduct" items="${infoGoSalesDetailsList}">
					<tr>
						<td>${salesProduct.product_name}</td>
						<td>${salesProduct.price}</td>
						<td>${salesProduct.quantity}</td>
						<td><fmt:formatNumber value="${salesProduct.totalPrice}" type="number" pattern="#,###" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 버튼 -->
		<div>
			<button type="button" onclick="history.back()">목록</button>
		</div>
	</div>
</body>
</html>
