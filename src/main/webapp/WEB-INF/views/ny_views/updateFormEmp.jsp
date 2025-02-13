<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 수정</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="../css1/sb-admin-2.min.css" rel="stylesheet">
<link href="../css/detail.css" rel="stylesheet">

<style>
.detail-table input, .detail-table select {
	width: 100%;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.insert-full-button {
	padding: 8px 12px;
	font-size: 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	background-color: #4e73df;
	color: white;
}

.insert-empty-button {
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

				<!-- 전체 div -->
				<div class="detail-wrapper">
					<form action="/HR/updateEmp" method="post">
						<div class="detail-header">
							<div>
								<div class="detail-submenu">인사 관리 > 직원 수정</div>
								<div class="detail-title">
									<div></div>
									<h1>직원 수정</h1>
							</div>
						</div>
						<!-- 버튼 -->
						<div class="detail-buttons">
							<button type="button" class="btn insert-empty-button"
								onclick="history.back()">취소</button>
							<button type="submit" class="btn insert-full-button">저장</button>
						</div>

					</div>

					<div class="detail-header-content">
						
							<input type="hidden" name="emp_No" value="${emp.emp_No}">
							<table class="detail-table">
								<tr>
									<th>이름</th>
									<td><input type="text" name="emp_Name" required
										value="${emp.emp_Name}"></td>
									<th>사번</th>
									<td>${emp.emp_No}</td>
								</tr>
								<tr>
									<th>부서</th>
									<td><select name="dept_No">
											<c:forEach var="dept" items="${deptList}">
												<option value="${dept.dept_No}"
													<c:if test="${dept.dept_No == emp.dept_No}">selected</c:if>>${dept.dept_Name}
												</option>
											</c:forEach>
									</select></td>
									<th>직급</th>
									<td><select name="position">
											<c:forEach var="emp" items="${empList}">
												<option value="${emp.position}"
													<c:if test="${emp.position == emp.position}">selected</c:if>>${emp.position}
												</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td><input type="text" name="emp_Tel" required
										value="${emp.emp_Tel}"></td>
									<th>이메일</th>
									<td><input type="email" name="emp_Email" required
										value="${emp.emp_Email}"></td>
								</tr>
								<tr>
									<th>생년월일</th>
									<td><input type="date" name="birth" value="${emp.birth}"></td>
									<th>입사일</th>
									<td><input type="date" name="hiredate"
										value="${emp.hiredate}"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<%@ include file="../footer1.jsp"%>
		</div>
	</div>

	<!-- jQuery (항상 가장 먼저 로드) -->
<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
<script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin (jQuery Easing 등) -->
<script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Custom scripts -->
<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>

</body>
</html>
