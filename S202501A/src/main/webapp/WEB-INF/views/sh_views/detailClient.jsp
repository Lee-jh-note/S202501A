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
<link rel="stylesheet" href="./board.css">
<style type="text/css">
.bb {
    width: 180px;
    }
</style>
</head>
<body>
    <div class="bb">
    </div>
   <div>

	<h2>직원정보</h2> 
	<table>
		<tr><th>거래처 코드</th><td>${client.client_No }</td></tr>
		<tr><th>회사명</th><td>${client.client_Name }</td></tr>
		<tr><th>구분</th><td>${client.client_Type }</td></tr>
		<tr><th>대표자</th><td>${client.client_Ceo}</td></tr>
		<tr><th>사업자 번호</th><td>${client.business_No}</td></tr>
		<tr><th>이메일</th><td>${client.client_Email }</td></tr>
		<tr><th>기업 전화번호</th><td>${client.client_Tel }</td></tr>
		<tr><th>대표자 전화번호</th><td>${client.ceo_Tel}</td></tr>
		<tr><th>등록일</th><td>${client.reg_Date}</td></tr>
		<tr><td colspan="2">
		    <input type="button" value="목록" 
				onclick="location.href='listClient'">
			<input type="button" value="수정" 
				onclick="location.href='updateFormClient?client_No=${client.client_No}'">
			<input type="button" value="삭제" 
				onclick="location.href='deleteClient?client_No=${client.client_No}'"></td>
		</tr>
	</table>
  </div>
</body>
</html>