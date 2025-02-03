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
<title>Insert title here</title>
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
	<h2>거래처 정보</h2>
	<form action="updateClient" method="post">
	  <input type="hidden" name="client_No" value="${client.client_No }">
	  <table>  
		<tr><th>거래처 코드</th><td>${client.client_No}</td></tr>
		<tr><th>회사명</th><td>
		    <input type="text"   name="client_Name" required="required" value="${client.client_Name}" ></td></tr>
		<tr><th>구분</th><td>${client.client_Type }</td></tr>
		<tr><th>대표자</th><td>
		    <input type="text"   name="client_Ceo"   required="required" value="${client.client_Ceo}"></td></tr>
		<tr><th>사업자 번호</th><td>
		    <input type="number" name="business_No"   required="required" value="${client.business_No}"></td></tr>
		<tr><th>이메일</th>
			<td>
	 	      <input type="text"   name="client_Email"   required="required" value="${client.client_Email}">
	    	</td>
	    </tr>
		<tr><th>기업 전화번호</th><td>
		    <input type="number" name="client_Tel" 	required="required" value="${client.client_Tel}"></td></tr>
		<tr><th>대표자 전화번호</th><td>
		    <input type="number" name="ceo_Tel" 	value="${client.ceo_Tel }"></td></tr>
		<tr><th>등록일</th>
			<td>
		       <input type="date" name="reg_Date" id="hiredate"	value="${client.reg_Date}" > 
	        </td>
		</tr>
		<tr><td colspan="2">
		   <input type="submit" value="확인">
		   </td>
		</tr>
	  </table>
	</form>
		  </div>


</body>
</html>