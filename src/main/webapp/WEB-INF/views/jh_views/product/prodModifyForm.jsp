<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Edit</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Edit Product Details</h2>

    <form action="/Prod/ProdModifyAct" method="post">
        <input type="hidden" name="product_no" value="${ProductPrice.product_no}"> <!-- 제품 번호는 히든 필드로 -->

        <table class="table table-bordered">
            <tr>
                <th>제품 번호</th>
                <td>${ProductPrice.product_no}</td>
            </tr>
            <tr>
                <th>제품명</th>
                <td><input type="text" name="product_name" value="${ProductPrice.product_name}" class="form-control" required></td>
            </tr>
            <tr>
                <th>상세설명</th>
                <td><input type="text" name="description" value="${ProductPrice.description}" class="form-control" required></td>
            </tr>
            <tr>
                <th>상태</th>
                <td>
                    <select name="status" class="form-control" required>
                        <option value="1" ${ProductPrice.status == 1 ? 'selected' : ''}>활성화</option>
                        <option value="0" ${ProductPrice.status == 0 ? 'selected' : ''}>비활성화</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>대분류</th>
                <td>
                    <select id="topCategory" name="category" class="form-control" required onchange="updateMidCategories()">
                        <option value="${ProductPrice.category}">${ProductPrice.title}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>중분류</th>
                <td>
                    <select id="midCategory" name="mid_category" class="form-control" required>
                        <option value="${ProductPrice.mid_category}">${ProductPrice.content}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td><input type="text" name="reg_date" value="<fmt:formatDate value="${ProductPrice.reg_date}" pattern="yy/MM/dd"/>" class="form-control" disabled></td> <!-- 등록일은 수정 불가능 -->
            </tr>
            <tr>
                <th>판매가</th>
                <td><input type="number" name="sale_price" value="${ProductPrice.sale_price}" class="form-control" required></td>
            </tr>
            <tr>
                <th>구매가</th>
                <td><input type="number" name="pur_price" value="${ProductPrice.pur_price}" class="form-control" required></td>
            </tr>
        </table>

        <div class="text-center mb-4">
            <button type="submit" class="btn btn-primary">Update Product</button>
        </div>
    </form>

    <!-- 삭제 버튼 -->
    <form action="/Prod/ProdDelete" method="post" style="display:inline;" class="text-center">
        <input type="hidden" name="product_no" value="${ProductPrice.product_no}">
        <button type="submit" class="btn btn-danger" onclick="return confirm('진짜 지울거니?')">Delete Product</button>
    </form>
</div>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // JSON 문자열을 JavaScript 객체로 파싱
    var topList = JSON.parse('${jsonTopList}');
    var midList = JSON.parse('${jsonMidList}');

    // 대분류 select box에 옵션 추가
    var topCategorySelect = document.getElementById("topCategory");

    topList.forEach(function(category) {
        var option = document.createElement("option");
        option.value = category.top_category;  // top_category
        option.text = category.title;  // title
        topCategorySelect.appendChild(option);
    });

    // 대분류 선택 시 중분류 업데이트
    function updateMidCategories() {
        var topCategoryId = document.getElementById("topCategory").value;
        var midCategorySelect = document.getElementById("midCategory");

        // 기존 중분류 항목을 비운다
        midCategorySelect.innerHTML = "<option value=''>중분류를 선택하세요</option>";

        // 대분류를 선택하면 해당 대분류에 속하는 중분류들만 표시
        if (topCategoryId) {
            midList.forEach(function(midCategory) {
                if (midCategory.top_category == topCategoryId) {
                    var option = document.createElement("option");
                    option.value = midCategory.mid_category;  // mid_category
                    option.text = midCategory.content;  // content
                    midCategorySelect.appendChild(option);
                }
            });
        }
    }
</script>

</body>
</html>
