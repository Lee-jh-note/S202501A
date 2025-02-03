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
<title>발주 조회</title>
<link rel="stylesheet" href="<c:url value='/css/board.css' />">
</head>
<body>
    <div class="bb">
    </div>
	<div class="center-container">
	<h1> 발주 </h1>
	
     <!-- 다운로드 및 인쇄 버튼 -->
     <div style="margin-top: 10px; margin-right: 20px">
     	<a href="/excel/purchaseExcel" class="btn btn-success">엑셀 다운로드</a>
        <button id="printSelection" class="btn-print">인쇄</button>
     </div>
     
    <form action="searchPurchase">
    
	    <!-- 조회 기간 -->
	    <label for="startDate">매입일자</label>
	    <input type="date" id="startDate" name="startDate" value="${sysdate}"/>
	
	    <label for="endDate">~</label>
	    <input type="date" id="endDate" name="endDate" value="${sysdate}"/>
	
	    <!-- 거래처 -->
	    <label for="client_name">거래처</label>
	    <input type="text" id="client_name" name="client_name" placeholder="거래처 입력" />
	    
	    <!-- 상태 조회 추가 -->
	    <!-- 상태(status) 필터 적용 -->
	    <label for="status">상태</label>
		<select name="status">
			<option value="">전체</option>
			<option value="0">대기</option>
			<option value="1">부분입고</option>
			<option value="2">완료</option>
		</select> 
	
	    <!-- 검색 버튼 -->
	    <button type="submit">조회</button>
	</form>
    


	<%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>
	<c:set var="num" value="${page.start}" />
	
	<table>
		<tr><th>선택</th><th>발주번호</th><th>매입일자</th><th>제목</th><th>거래처명</th><th>담당자</th><th>상품수</th><th>총수량</th><th>총금액</th><th>처리상태</th><th>요청배송일</th></tr>
		<c:forEach var="purchase" items="${listPurchase}">
			<tr>
				<td><input type="checkbox" id="checkAll" /></td>
				<td>${num}</td><td>${purchase.purchase_date}</td>
				<td><a href="detailPurchase?purchase_date=${purchase.purchase_date}&client_no=${purchase.client_no}">${purchase.title}</a></td>
				<td>${purchase.client_name}</td>
				<td>${purchase.emp_name}</td>
				<td>${purchase.product_count}</td>
				<td>${purchase.total_quantity}</td>
				<td><fmt:formatNumber value="${purchase.total_price}" type="number" pattern="#,###" /></td>
				<td>${purchase.status}</td>
				<td>${purchase.req_delivery_date.substring(0,10)}</td>
			</tr>
			<c:set var="num" value="${num + 1 }"></c:set>
		</c:forEach>
	</table>	
	
	<c:if test="${page.startPage > page.pageBlock }">
		<a href="listPurchase?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
		<a href="listPurchase?currentPage=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${page.endPage < page.totalPage }">
		<a href="listPurchase?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
	</c:if>	
	</div>





</body>
</html>