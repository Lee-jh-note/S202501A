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
<link rel="stylesheet" href="./css/board.css">
</head>
<body>
    <div class="bb">
    </div>
	<div>
	<h1> 발주 </h1>
	
    <form action="searchPurchase">
    
	    <!-- 조회 기간 -->	    
	    <!-- 조회 후에 어떤 값들을 조회했는지 알아보기 위해 값들을 검색칸에 남겨두고 싶어서 각각 value로 남겨둠 -->
	    <label for="startDate">매입일자</label>
	    <input type="date" id="startDate" name="startDate" value="${searchKeyword.startDate}"/>
	
	    <label for="endDate">~</label>
	    <input type="date" id="endDate" name="endDate" value="${searchKeyword.endDate}"/>
	    
	    <!-- 거래처 -->
	    <label for="client_name">거래처</label>
	    <input type="text" id="client_name" name="client_name" value="${searchKeyword.client_name}" placeholder="거래처 입력" />
	    
	    <!-- 상태 조회 추가 -->
	    <!-- 상태(status) 필터 적용 -->
	    <label for="status">상태</label>
		<select name="status">
			<option value="" ${searchKeyword.status == '' ? 'selected' : ''}>전체</option>
			<option value="0" ${searchKeyword.status == '0' ? 'selected' : ''}>대기</option>
			<option value="1" ${searchKeyword.status == '1' ? 'selected' : ''}>부분입고</option>
			<option value="2" ${searchKeyword.status == '2' ? 'selected' : ''}>완료</option>
		</select> 
	    
	    <!-- 검색 버튼 -->
	    <button type="submit">조회</button>
	</form>
    


	<c:set var="num" value="${page.start}"></c:set>
	
	<table>
		<tr><th >발주번호</th><th>매입일자</th><th>제목</th><th>거래처명</th><th>담당자</th><th>상품수</th><th>총수량</th><th>총금액</th><th>처리상태</th><th>요청배송일</th></tr>
		<c:forEach var="purchase" items="${searchListPurchase}">
			<tr><td>${num}</td><td>${purchase.purchase_date}</td>
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
	  <a href="searchPurchase?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&status=${param.status}&currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	  <a href="searchPurchase?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&status=${param.status}&currentPage=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${page.endPage < page.totalPage }">
	  <a href="searchPurchase?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&status=${param.status}&currentPage=${page.startPage+page.pageBlock}">[다음]</a>
	</c:if>
	</div>




</body>
</html>