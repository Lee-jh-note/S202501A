<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../header.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>출고 완료 조회</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}
th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}
th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<h1>출고 완료 리스트</h1>
	<form method="get" action="/listShippedSalesDetail">
		<label>요청배송일: </label>
		<input type="date" name="startDate">
		~
		<input type="date" name="endDate">
		<label>거래처: </label>
		<input type="text" name="clientName">
		<button type="submit">조회</button>
	</form>

	<table>
		<thead>
			<tr>
				<th>NO</th>
				<th>요청배송일</th>
				<th>거래처명</th>
				<th>상품명</th>
				<th>수량</th>
				<th>총금액</th>
				<th>상세보기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="salesDetail" items="${shippedSalesDetailList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${salesDetail.req_delivery_date}</td>
					<td>${salesDetail.client_name}</td>
		
