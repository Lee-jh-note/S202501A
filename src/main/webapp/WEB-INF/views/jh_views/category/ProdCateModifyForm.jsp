<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>카테고리 수정</title>
</head>
<body>
<h3>카테고리 수정</h3>

<form action="/Prod/Category/ModifyAct" method="post">

  <label for="topCategory">상위 카테고리:</label>
  <input type="text" id="topCategory" name="top_category" value="${category.top_category}" readonly><br><br>

  <label for="midCategory">중간 카테고리:</label>
  <input type="text" id="midCategory" name="mid_category" value="${category.mid_category}" readonly><br><br>

  <label for="title">카테고리 제목:</label>
  <input type="text" id="title" name="title" value="${category.title}" required><br><br>

  <label for="content">카테고리 내용:</label>
  <textarea id="content" name="content" required>${category.content}</textarea><br><br>

  <button type="submit">수정</button> <br>
</form>
<form action="/Prod/Category/Delete" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
  <input type="hidden" name="top_category" value="${category.top_category}">
  <input type="hidden" name="mid_category" value="${category.mid_category}">
  <button type="submit">삭제</button>
</form>

</body>
</html>
