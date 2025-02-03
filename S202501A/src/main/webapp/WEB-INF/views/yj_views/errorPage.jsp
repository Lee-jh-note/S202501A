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
<link rel="stylesheet" href="<c:url value='/css/board.css' />">
</head>
<body>
    <div class="bb">
    </div>
	  <!-- 가운데 컨테이너 -->
	  <div class="center-container">
	    <c:if test="${errorMessage != null}">
	      ${errorMessage}
	    </c:if>
	    <input type="button" value="돌아가기" onclick="history.back()">
	  </div>




</body>
</html>