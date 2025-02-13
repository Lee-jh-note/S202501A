<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에러 발생</title>

<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/list.css' />">
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
	background-color: #f8f9fa;
}

.error-container {
	max-width: 600px;
	margin: auto;
	padding: 20px;
	background: white;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

h2 {
	color: #dc3545;
}

p {
	color: #333;
}

.btn {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

.btn-home {
	background-color: #007bff;
}

.btn-back {
	background-color: #6c757d;
}
</style>
</head>

<body id="page-top">
	<div id="wrapper">
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>

					<div class="error-container">
						<h2>에러 발생</h2>
						<p>${errorMessage != null ? errorMessage : "알 수 없는 에러가 발생했습니다. 다시 시도해주세요."}</p>
				
						<input type="button" value="돌아가기" onclick="history.back()">
					</div>
			<!-- End of Main Content -->


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
