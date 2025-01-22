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
<!-- 다른점: 1. 타이틀 이름 -->
<title>미입고 조회 상세</title>
<link rel="stylesheet" href="./css/board.css">
</head>
<body>
    <div class="bb">
    </div>
	<div>
	<!-- 다른점: 2. h1 태그 -->
	<h2>미입고 조회 상세</h2>
	<table>
		<tr><th>매입일자</th><td>${purchase_details.purchase_date}</td></tr>
		<tr><th>담당자</th><td>${purchase_details.emp_name }</td></tr>
		<tr><th>거래처명</th><td>${purchase_details.client_name }</td></tr>
		
		<table>
			<tr><th>품목명</th><th>단가</th><th>수량</th><th>총금액</th></tr>
				<c:forEach var="purchase_details" items="${purchase_details_list}">
					<tr>
						<td>${purchase_details.product_name}</td>
						<td>${purchase_details.price}</td>
						<td>${purchase_details.quantity}</td>
						<td><fmt:formatNumber value="${purchase_details.price * purchase_details.quantity}" type="number" pattern="#,###" /></td>
					</tr>
					<c:set var="num" value="${num - 1 }"></c:set>
				</c:forEach>
					
		</table>
		
		<tr><td colspan="2">
			<!-- 다른점: 3. 페이지 이동 -->
		    <input type="button" value="목록" 
				onclick="history.back()"></td>
		</tr>
	</table>
	</div>

</body>
</html>