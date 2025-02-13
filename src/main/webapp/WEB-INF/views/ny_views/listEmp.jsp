<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>직원 조회</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet"
	href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/list.css' />">


<style>
.list-empty-button {
	padding: 8px 12px;
	font-size: 12px;
	border-radius: 4px;
	cursor: pointer;
	background-color: white;
	color: #4e73df;
	border: 1px solid #4e73df;
}
</style>

</head>

<body id="page-top">
	<div id="wrapper">
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>

				<div class="list-wrapper">
					<div class="list-header">
						<div>
							<div class="list-submenu">인사 관리 > 직원 조회</div>
							<div class="list-title">
								<div></div>
								<h1>직원 조회</h1>
							</div>
						</div>
						<div class="list-buttons">
							<input type="button" value="새로고침" class="btn list-empty-button"
								onclick="location.href='/All/HR/listEmp'">
						</div>
					</div>

					<div class="list-header2">
						<div></div>
						<!-- 검색영역을 .search-filters 로 감싸기 -->
						<div class="list-search-filters">
							<form action="/All/HR/listSearch3" method="get"
								style="display: flex; gap: 10px; align-items: center;">

								<!-- 부서 드롭다운 -->
								<select name="dept_No">
									<option value="">부서별 검색</option>
									<c:choose>
										<c:when test="${not empty deptList}">
											<c:forEach var="dept" items="${deptList}">
												<option value="${dept.dept_No}"
													<c:if test="${dept.dept_No eq dept_No}">selected</c:if>>
													${dept.dept_Name}</option>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<option value="">부서 정보 없음</option>
										</c:otherwise>
									</c:choose>
								</select> <input type="text" name="keyword" placeholder="직원이름 keyword 입력"
									value="${keyword}">
								<button type="submit" class="btn list-gray-button">검색</button>
							</form>

						</div>
					</div>

					<%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>

					<table class="list-table">
						<thead>
							<tr>
								<th>사번</th>
								<th>이름</th>
								<th>부서이름</th>
								<th>직급</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>생년월일</th>
								<th>입사일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="emp" items="${listEmp}">
								<tr>
									<td>${emp.emp_No}</td>
									<td><a href="/All/HR/detailEmp?emp_No=${emp.emp_No}">${emp.emp_Name}</a></td>
									<td><a href="/All/HR/listDept3?emp_No=${emp.emp_No}">${emp.dept_Name}</a></td>
									<td>${emp.position}</td>
									<td>${emp.emp_Tel}</td>
									<td>${emp.emp_Email}</td>
									<td>${emp.birth.substring(0, 10)}</td>
									<td>${emp.hiredate.substring(0, 10)}</td>
								</tr>
								<c:set var="num" value="${num + 1 }"></c:set>
							</c:forEach>
						</tbody>
					</table>

					<div style="text-align: center; margin-top: 20px;">
						<c:if test="${page.startPage > page.pageBlock }">
							<a
								href="/All/HR/listEmp?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="/All/HR/listEmp?currentPage=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage }">
							<a
								href="/All/HR/listEmp?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
						</c:if>

					</div>


				</div>
				<!-- End of Main Content -->


			</div>
			<%@ include file="../footer1.jsp"%>
		</div>
	</div>
	
	<!-- 부서별 검색  -->
	<script>
		document.querySelector("select[name='dept_No']").addEventListener(
				"change", function() {
					document.querySelector("form").submit();
				});
	</script>
	
	<!-- jQuery (항상 가장 먼저 로드) -->
	<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

	<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
	<script
		src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

	<!-- Core plugin (jQuery Easing 등) -->
	<script
		src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

	<!-- Custom scripts -->
	<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>

</body>

</html>
