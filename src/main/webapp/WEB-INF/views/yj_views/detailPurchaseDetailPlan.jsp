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
<title>입고 예정 리스트 상세</title>
<style type="text/css">
.select {
    padding: 15px 10px;
}
.select input[type=radio]{
    display: none;
}
.select input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
    height: 24px;
    width: 90px;
    border: 1px solid #333;
    line-height: 24px;
    text-align: center;
    font-weight:bold;
    font-size:13px;
}
.select input[type=radio]+label{
    background-color: #fff;
    color: #333;
}
.select input[type=radio]:checked+label{
    background-color: #333;
    color: #fff;
}
</style>
<link rel="stylesheet" href="<c:url value='/css/board.css' />">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="bb">
    </div>
	<div>
	<!-- 다른점: 2. h1 태그 -->
	<h2>입고 예정 리스트 상세</h2>
		<form action="purchaseDetailStore" method="post">
		    <table>
		        <tr><th>매입일자</th><td>${purchase_details.purchase_date}</td></tr>
		        <tr><th>발주 담당자</th><td>${purchase_details.emp_name }</td></tr> <!-- 구매 테이블에서 가져온 담당자 이름 -->
		        <tr><th>입고 담당자</th><td>${emp_name}<!-- 화면에 이름 표시 -->
		        					<input type="hidden" name="emp_no" value="${emp_no}"><!-- emp_no 값을 숨겨서 전송 --></td></tr> <!-- 세션에서 가져온 담당자 이름 - 현재 로그인 되어있는 사원 -->
		        <tr><th>거래처명</th><td>${purchase_details.client_name }</td></tr>
		
		        <table>
		            <tr><th>선택</th><th>품목명</th><th>단가</th><th>수량</th><th>총금액</th></tr>
		            <c:forEach var="purchase_detail" items="${purchase_details_list}" varStatus="status">
		                <tr>
		                    <td>
		                        <input type="checkbox" name="checked" value="${status.index}">
		                        <input type="hidden" name="purchase_date" value="${purchase_detail.purchase_date}">
		                        <input type="hidden" name="client_no" value="${purchase_detail.client_no}">
		                        <input type="hidden" name="product_no" value="${purchase_detail.product_no}">
		                    </td>
		                    <td>${purchase_detail.product_name}</td>
		                    <td>${purchase_detail.price}</td>
		                    <td>${purchase_detail.quantity}</td>
		                    <td><fmt:formatNumber value="${purchase_detail.price * purchase_detail.quantity}" type="number" pattern="#,###" /></td>
		                </tr>
		            </c:forEach>
		        </table>
		
		        <tr><td colspan="2">
		            <input type="button" value="목록" onclick="history.back()">
		            <input type="submit" class="btn" value="입고">
		        </td></tr>
		    </table>
		</form>
	</div>

</body>
</html>