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
<title>직원 수정</title>

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
	
		<form action="updateEmp" method="post">
			<!-- 디테일 JSP랑 똑같은데 타입만 히든으로 -->
			<input type="hidden" name="emp_No" value="${emp.emp_No}">
			<table>

				<tr>
					<th>사번</th>
					<td>${emp.emp_No}</td>
				</tr>


				<tr>
					<th>이름</th>
					<td><input type="text" name="emp_Name" required="required"
						value="${emp.emp_Name}"></td>
				</tr>


				<tr>
					<th>부서</th>
					<td> <select name="dept_No">
							<c:forEach var="dept" items="${deptList}">
								<option value="${dept.dept_No}"
									<c:if test="${dept.dept_No == emp.dept_No}">selected</c:if>>${dept.dept_Name}</option>
							</c:forEach>
						</select></td></tr>
				
				
				<tr>
					<th>직급</th>
					<td> <select name="position">
              <c:forEach var="emp" items="${empList}">
                <option value="${emp.position}">${emp.position}</option> <!--바로 받아오니까 된다.  -->
            </c:forEach>
                  </select></td></tr>
        

				<tr>
					<th>전화번호</th>
					<td><input type="text" name="emp_Tel" required="required"
						value="${emp.emp_Tel}"></td>
				</tr>



				<tr>
					<th>이메일</th>
					<td><input type="text" name="emp_Email" required="required"
						value="${emp.emp_Email}"></td>
				</tr>



				<tr>
					<th>생년월일</th>
					<td><input type="date" name="birth" id="birth"
						value="${emp.birth}"></td>
				</tr>



				<tr>
					<th>입사일</th>
					<td><input type="date" name="hiredate" id="hiredate"
						value="${emp.hiredate}"></td>
				</tr>
				
				
				<tr>
					<td colspan="3"><input type="submit" value="확인"></td>
				</tr>
				
				
			</table>
		</form>
	
</body>
</html>