<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>분류 등록</title>
</head>
<body>
<h3>분류 등록</h3>

<!-- 분류 등록 폼 -->
<form action="/Prod/Category/CreateAct" method="post">
    <!-- 대분류 -->
<%--    <label for="topCategory">대분류:</label>--%>
<%--    <input type="text" id="topCategory" name="top_category" required><br><br>--%>

    <!-- 대분류 내용 -->
    <label for="topCategoryContent">대분류</label>
    <textarea id="topCategoryContent" name="title" required></textarea><br><br>

    <!-- 중분류 -->
<%--    <label for="midCategory">중분류:</label>--%>
<%--    <input type="text" id="midCategory" name="mid_category" required><br><br>--%>

    <!-- 중분류 내용 -->
    <label for="midCategoryContent">중분류</label>
    <textarea id="midCategoryContent" name="content" required></textarea><br><br>

    <!-- 제출 버튼 -->
    <button type="submit">등록</button>
</form>

<br><br>
<!-- 목록으로 돌아가는 링크 -->
<a href="/Prod/Category/List">카테고리 목록으로 돌아가기</a>
</body>
</html>
