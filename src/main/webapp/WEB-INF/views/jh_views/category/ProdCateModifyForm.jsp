<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 수정</title>
    <!-- Bootstrap CSS 링크 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">
</head>
<style>

    .bt1 {
        padding: 8px 12px;
        font-size: 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        background-color: #4e73df;
        color: white;
    }
    .bt {
        padding: 8px 12px;
        font-size: 12px;
    }
</style>
<body>

<div class="container mt-5">
    <h3 class="text-center mb-4">분류 관리</h3>


    <!-- 카테고리 수정 폼 -->
    <form action="/Sales/Category/ModifyAct" method="post" class="d-flex flex-column">
        <button type="submit" class="bt1 align-self-end">수정</button>
        <div class="mb-3">
            <div>
                <label for="title" class="form-label">대분류</label>
                <input type="text" class="form-control" id="title" name="title" value="${category.title}" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">중분류</label>
            <input type="text" class="form-control" id="content" name="content" value="${category.content}">
        </div>

        <input type="hidden" id="topCategory" name="top_category" value="${category.top_category}">
        <input type="hidden" id="midCategory" name="mid_category" value="${category.mid_category}">
    </form>
    <div class="d-flex gap-2">

        <form id="deleteCategoryForm" action="/Sales/Category/Delete" method="post" onsubmit="return confirmDelete();">
            <input type="hidden" name="top_category" value="${category.top_category}">
            <input type="hidden" name="mid_category" value="${category.mid_category}">
            <button type="submit" class="bt btn btn-danger">삭제</button>
        </form>
        <button type="button" class="bt btn btn-secondary" onclick="window.history.back();">
            돌아가기
        </button>
    </div>

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
            location.href = "/All/Sales/Category/List";
            return false; // 폼 제출 막음
        }

        // 중분류가 있으면 정상적으로 삭제 진행
        return confirm('정말로 삭제하시겠습니까?');
    }
</script>

</body>
</html>
