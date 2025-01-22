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
<link rel="stylesheet" href="./css/board.css">
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
		    <input type="button" value="목록" 
				onclick="history.back()">
			<input type="button" value="수정" 
				onclick="location.href='updateFormPurchase?purchase_date=${purchase.purchase_date}&client_no=${purchase.client_no}&status=${purchase.status}'">
			<input type="button" value="삭제" 
				onclick="location.href='deletePurchase?purchase_date=${purchase.purchase_date}&client_no=${purchase.client_no}&status=${purchase.status}'"></td>
		</tr>
	</table>
	</div>

</body>
</html>