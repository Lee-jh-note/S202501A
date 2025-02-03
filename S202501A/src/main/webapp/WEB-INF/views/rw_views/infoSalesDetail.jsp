<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../header.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>출고예정리스트 상세 조회</title>
</head>
<body>
	<h1>출고예정리스트 상세 조회</h1>
	<form method="post" action="/updateSalesDetail">
		<input type="hidden" name="sales_Date" value="${salesDetail.sales_date}">
		<input type="hidden" name="client_No" value="${salesDetail.client_no}">

		<table>
			<tr>
				<th>요청배송일</th>
				<td>${salesDetail.req_delivery_date}</td>
			</tr>
			<tr>
				<th>거래처명</th>
				<td>${salesDetail.client_name}</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td>${salesDetail.product_name}</td>
			</tr>
			<tr>
				<th>수량</th>
				<td>${salesDetail.quantity}</td>
			</tr>
			<tr>
				<th>총금액</th>
				<td><fmt:formatNumber value="${salesDetail.total_price}" type="currency"/></td>
			</tr>
			<tr>
				<th>처리 상태</th>
				<td>
					<input type="radio" name="status" value="출고완료"> 출고
					<input type="radio" name="status" value="미출고"> 미출고
				</td>
			</tr>
		</table>
		<button type="submit">처리상태 수정</button>
		<button type="button" onclick="history.back()">목록으로</button>
	</form>
</body>
</html>
