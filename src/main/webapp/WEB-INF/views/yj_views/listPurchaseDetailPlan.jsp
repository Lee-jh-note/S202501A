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
<title>입고 예정 리스트</title>
<link rel="stylesheet" href="./css/board.css">
</head>
<body>
    <div class="bb">
    </div>
	<div>
	<!-- 다른점: 2. h1 태그 -->
	<h1> 입고 예정 리스트 </h1>
	
	<!-- 다른점: 3. 액션 이동 -->
    <form action="searchPurchaseDetailPlan">
    
	    <!-- 조회 기간 -->
	    <label for="startDate">매입일자</label>
	    <input type="date" id="startDate" name="startDate" />
	
	    <label for="endDate">~</label>
	    <input type="date" id="endDate" name="endDate" />
	
	    <!-- 거래처 -->
	    <label for="client_name">거래처</label>
	    <input type="text" id="client_name" name="client_name" placeholder="거래처 입력" />
	    
	    <!-- 요청 배송일 검색 추가 -->
	    <label for="req_delivery_date">요청배송일</label>
	    <input type="date" id="req_delivery_date" name="req_delivery_date" />

	    <button type="submit">조회</button>
	</form>
    


	<c:set var="num" value="${page.start}"></c:set>
	
	<table>
		<tr><th >NO</th><th>매입일자</th><th>요청배송일</th><th>거래처명</th><th>발주 담당자</th><th>상품수</th><th>총수량</th><th>총금액</th><th>처리상태</th></tr>
		<!-- 다른점: 5. items에 들어가는게 다름 -->
		<c:forEach var="purchase_details" items="${listPurchaseDetailPlan}">
			<tr>
				<td>${num}</td><td>${purchase_details.purchase_date}</td><td>${purchase_details.req_delivery_date.substring(0,10)}</td>
						<!-- 다른점: 6. 페이지 이동 -->
				<td><a href="detailPurchaseDetailPlan?purchase_date=${purchase_details.purchase_date}&client_no=${purchase_details.client_no}">${purchase_details.client_name}</a></td>
				<td>${purchase_details.emp_name}</td>
				<td>${purchase_details.product_count}</td>
				<td>${purchase_details.total_quantity}</td>
				<td><fmt:formatNumber value="${purchase_details.total_price}" type="number" pattern="#,###" /></td>
				<td>${purchase_details.status}</td>
			</tr>
			<c:set var="num" value="${num + 1}"></c:set>
		</c:forEach>
	</table>	
	
	<c:if test="${page.startPage > page.pageBlock }">
				<!-- 다른점: 7. 페이지 이동 -->
		<a href="listPurchaseDetailPlan?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<!-- 다른점: 7. 페이지 이동 -->
		<a href="listPurchaseDetailPlan?currentPage=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${page.endPage < page.totalPage }">
				<!-- 다른점: 7. 페이지 이동 -->
		<a href="listPurchaseDetailPlan?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
	</c:if>	
	</div>





</body>
</html>