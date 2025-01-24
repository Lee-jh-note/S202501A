<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 관리</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3 class="text-center mb-4">카테고리 목록</h3>

    <!-- 분류 생성 버튼 -->
    <div class="text-right mb-3">
        <a href="/Prod/Category/Create" class="btn btn-primary">분류 생성</a>
    </div>

    <!-- 카테고리 테이블 -->
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>

            <th>대분류</th>

            <th>중분류</th>
        </tr>
        </thead>
        <tbody>
        <!-- 모델에서 받은 topList 데이터를 반복하여 출력 -->
        <c:forEach var="topCategory" items="${topList}">
            <tr>
                <!-- 대분류 내용에 링크 추가 -->
<%--                <td><a href="/Prod/Category/Modify?top_category=${topCategory.top_category}" class="text-decoration-none">${topCategory.top_category}</a></td>--%>
                <td><a href="/Prod/Category/Modify?top_category=${topCategory.top_category}" class="text-decoration-none">${topCategory.title}</a></td>


                <!-- 해당 top_category에 속한 midList만 필터링하여 출력 -->
                <c:forEach var="midCategory" items="${midList}">
                    <c:if test="${midCategory.top_category == topCategory.top_category}">
                        <!-- 중분류 내용에 링크 추가 -->
<%--                        <td><a href="/Prod/Category/Modify?top_category=${topCategory.top_category}&mid_category=${midCategory.mid_category}" class="text-decoration-none">${midCategory.mid_category}</a></td>--%>
                        <td><a href="/Prod/Category/Modify?top_category=${topCategory.top_category}&mid_category=${midCategory.mid_category}" class="text-decoration-none">${midCategory.content}</a></td>
                    </c:if>
                </c:forEach>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
