<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>카테고리 수정</title>
  <!-- Bootstrap CSS 링크 추가 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
  <h3 class="text-center mb-4">카테고리 수정</h3>

  <!-- 오류 메시지가 있을 경우 표시 -->
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        ${errorMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <!-- 카테고리 수정 폼 -->
  <form action="/Prod/Category/ModifyAct" method="post">
    <input type="hidden" id="topCategory" name="top_category" value="${category.top_category}" readonly>
    <input type="hidden" id="midCategory" name="mid_category" value="${category.mid_category}" readonly>

    <div class="mb-3">
      <label for="title" class="form-label">카테고리 제목:</label>
      <input type="text" class="form-control" id="title" name="title" value="${category.title}" required>
    </div>

    <div class="mb-3">
      <label for="content" class="form-label">카테고리 내용:</label>
      <input type="text" class="form-control" id="content" name="content" value="${category.content}">
    </div>

    <div class="d-grid gap-2">
      <button type="submit" class="btn btn-primary">수정</button>
    </div>
  </form>

  <!-- 카테고리 삭제 폼 -->
  <form id="deleteCategoryForm" action="/Prod/Category/Delete" method="post" onsubmit="return confirmDelete();">
    <input type="hidden" name="top_category" value="${category.top_category}">
    <input type="hidden" name="mid_category" value="${category.mid_category}">
    <div class="d-grid gap-2 mt-3">
      <button type="submit" class="btn btn-danger">삭제</button>
    </div>
  </form>
</div>

<!-- Bootstrap JS, Popper.js 추가 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<script>
  // 삭제 폼 전송 전에 중분류가 없는 경우 경고 메시지 표시
  function confirmDelete() {
    var midCategory = "${category.mid_category}"; // 서버에서 전달된 중분류 값을 가져옴

    // 중분류가 없거나 0일 경우 경고 메시지
    if (!midCategory || midCategory == "0") {
      alert("중분류를 먼저 삭제해주세요.");
      location.href = "/Prod/Category/List";
      return false; // 폼 제출 막음
    }

    // 중분류가 있으면 정상적으로 삭제 진행
    return confirm('정말로 삭제하시겠습니까?');
  }
</script>

</body>
</html>
