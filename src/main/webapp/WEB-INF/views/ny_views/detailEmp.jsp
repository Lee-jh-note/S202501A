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
<title>직원 상세 정보</title>
<link rel="stylesheet" href="./board.css">
<style type="text/css">
.bb {
	width: 180px;
}


    table {
        width: 100%;
        border-collapse: collapse;
        margin: 0 auto;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
        vertical-align: middle;
    }
    th {
        background-color: #f2f2f2;
    }
</style>

</head>
<body>

	<div class="bb"></div>
	<div>
		<h2>직원 상세 정보</h2>
		<table>
			<tr>
				<th>사번</th>
				<td>${emp.emp_No}</td>
			</tr>

			<tr>
				<th>이름</th>
				<td>${emp.emp_Name}</td>
			</tr>

			
			<tr>
				<th>부서</th>
				<td>${emp.dept_Name}</td>
			</tr>

			<tr>
				<th>직급</th>
				<td>${emp.position}</td>
			</tr>

			<tr>
				<th>전화번호</th>
				<td>${emp.emp_Tel}</td>
			</tr>

			<tr>
				<th>이메일</th>
				<td>${emp.emp_Email}</td>
			</tr>

			<tr>
				<th>생년월일</th>
				<td>${emp.birth.substring(0, 10)}</td>
			</tr>

			<tr>
				<th>입사일</th>
				<td>${emp.hiredate.substring(0, 10)}</td>
			</tr>
			<tr>
				<th>id</th>
				<td>${emp.id}</td>
			</tr>
			<tr>
				<th>passwd</th>
				<td>${emp.password}</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="목록" onclick="location.href='listEmp'"> 
				<input type="button" value="수정" onclick="location.href='updateFormEmp?emp_No=${emp.emp_No}'">
				<input type="button" value="삭제" onclick="location.href='deleteEmp?emp_No=${emp.emp_No}'"></td>
			</tr>

		</table>
	</div>
</body>
</html>