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
<title>부서 수정</title>

<style type="text/css">
.bb {
	width: 300px;
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

	<div style="margin-top:200px">
		<form action="updateDept" method="post">
			<!-- 디테일 JSP랑 똑같은데 타입만 히든으로 -->
			<input type="hidden" name="dept_No" value="${dept.dept_No}">
			<table>

				<tr>
					<th>부서 번호</th>
					<td>${dept.dept_No}</td>
				</tr>
				
				<tr>
					<th>부서 이름</th>
					<td><input type="text" name="dept_Name" required="required"
						value="${dept.dept_Name}"></td>
				</tr>
				
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="dept_Tel" required="required"
						value="${dept.dept_Tel}"></td>
				</tr>
				
				<tr>
					<td colspan="3"><input type="submit" value="확인"></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>