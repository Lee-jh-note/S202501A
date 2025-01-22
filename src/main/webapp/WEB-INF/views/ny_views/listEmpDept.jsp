<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서와직원 테이블 조회</title>
</head>
<body>
	<h2>부서와직원 테이블 조회</h2>
	<table>
		<tr>
			<th>사번</th>
			<th>이름</th>
			<th>업무</th>
			<th>부서</th>
			<th>부서전화번호</th>
		</tr>
		<c:forEach var="empDept" items="${listEmpDept}">
			<tr>
				<td>${emp.emp_no }</td>
				<td>${emp.emp_name }</td>
				<td>${emp.position}</td>
				<td>${emp.dept_Name}</td>
				<td>${emp.dept_Tel }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>