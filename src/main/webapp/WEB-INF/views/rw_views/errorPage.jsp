<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 발생</title>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
	padding: 50px;
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
<body>
	<div class="error-container">
		<h2>에러 발생</h2>
		<p>${errorMessage != null ? errorMessage : "알 수 없는 에러가 발생했습니다. 다시 시도해주세요."}</p>

		<input type="button" value="돌아가기" onclick="history.back()">
	</div>
</body>
</html>