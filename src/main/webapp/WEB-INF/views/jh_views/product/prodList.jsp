<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h1 class="text-center mb-4">Product List</h1>

    <!-- 검색 폼 -->
    <form action="/Prod/ProdList" method="get" class="form-inline mb-4">
        <div class="form-group mr-3">
            <label for="product_name" class="mr-2">제품명:</label>
            <input type="text" id="product_name" name="name" class="form-control" value="${param.name}" />
        </div>

        <div class="form-group mr-3">
            <label for="category" class="mr-2">대분류</label>
            <select id="category" name="type" class="form-control">
                <option value="0">모든 대분류</option>
                <c:forEach var="category" items="${category}">
                    <option value="${category.top_category}">${category.title}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">검색하기</button>
    </form>

    <!-- 버튼: 제품 등록, 분류 관리 -->
    <div class="mb-4">
        <a href="/Prod/ProdCreate" class="btn btn-success">제품 등록</a>
        <a href="/Prod/Category/List" onclick="window.open(this.href, 'categoryPopup', 'width=600,height=800'); return false;" class="btn btn-info">분류 관리</a>
    </div>

    <!-- 상태 변경 폼 -->
    <form action="/Prod/Status" method="post">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th><input type="checkbox" id="select_all" onclick="toggleAll(this)"/> Select All</th>
                <th>Product No</th>
                <th>Product Name</th>
                <th>Description</th>
                <th>Status</th>
                <th>Category</th>
                <th>Actions</th> <!-- 수정 및 상세 조회 링크 -->
            </tr>
            </thead>
            <tbody>
            <c:forEach var="product" items="${list}">
                <tr>
                    <!-- 체크박스 -->
                    <td><input type="checkbox" name="product_no" value="${product.product_no}"/></td>
                    <!-- Product No, Product Name 등 -->
                    <td>${product.product_no}</td>
                    <td>${product.product_name}</td>
                    <td>${product.description}</td>
                    <td>${product.status}</td>
                    <td>${product.content}</td>
                    <td>
                        <a href="/Prod/ProdModify?productNo=${product.product_no}" class="btn btn-warning btn-sm">Edit</a>
                        <a href="/Prod/ProdDetails?productNo=${product.product_no}" class="btn btn-info btn-sm">View</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 상태 변경 버튼 -->
        <div class="text-center">
            <button type="submit" class="btn btn-primary">상태 변경</button>
        </div>
    </form>

    <!-- 페이지 네비게이션 -->
    <div class="text-center mt-3">
        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
            <a href="/Prod/ProdList?name=${name}&type=${type}&currentPage=${i}" class="btn btn-link">${i}</a>
        </c:forEach>
    </div>
</div>

<script>
    // Select All 체크박스 클릭 시 전체 선택/해제
    function toggleAll(source) {
        checkboxes = document.getElementsByName('product_no');
        for(var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
</script>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
