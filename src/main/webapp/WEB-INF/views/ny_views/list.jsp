
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
<title>직원조회</title>

<style type="text/css">
.bb {
	width: 180px;
}
</style>
</head>

<body>

	<div class="bb"></div>
	<div>
		<h1>직원조회</h1>
		<h3>사원수: ${totalEmp}</h3>

		<form action="listSearch3" style="display: flex; justify-content: space-between; align-items: center;">
			<div>
			<select name="search">				
				<option value="s_ename">이름조회</option>
				<option value="s_position">직급조회</option>
			</select> 
			<input type="text" name="keyword" placeholder="keyword을 입력하세요">
			<button type="submit">키워드 검색</button>
			</div>
			<td>
			<input type="button" value="등록"
				onclick="location.href='writeFormEmp'">
			</td>
		</form>


		<c:set var="num" value="${page.total-page.start+1 }"></c:set>
		<table border="1">
			<tr>
				<th>사번</th>
				<th>이름</th>
				<th>부서이름-</th>
				<th>직급</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>생년월일</th>
				<th>입사일</th>
			</tr>

			<c:forEach var="emp" items="${listEmp}">
				<tr>
					<td>${emp.emp_No}</td>
					<td><a href="detailEmp?emp_No=${emp.emp_No}">${emp.emp_Name}</a></td>
					<td><a href="listDept3?emp_No=${emp.emp_No}">${emp.dept_Name}</a></td>
					<td>${emp.position}</td>
					<td>${emp.emp_Tel}</td>
					<td>${emp.emp_Email}</td>
					<td>${emp.birth.substring(0, 10)}</td>
					<td>${emp.hiredate.substring(0, 10)}</td>
					<td>
						<button onclick="location.href='detailEmp?emp_No=${emp.emp_No}'">세부정보</button>
					</td>
					<td>
						<button onclick="location.href='updateFormEmp?emp_No=${emp.emp_No}'">수정</button>
					</td>
				</tr>
				<c:set var="num" value="${num - 1}"></c:set>
			</c:forEach>

		</table>

		<c:if test="${page.startPage > page.pageBlock }">
			<a href="listEmp?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="listEmp?currentPage=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage }">
			<a href="listEmp?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
		</c:if>

	</div>
</body>
</html>
