<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가격 수정</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">가격 수정</h2>

    <form method="POST" action="/Prod/PriceModifyAct">
        <!-- 제품 번호 -->
        <input type="hidden" id="product_no" name="product_no" value="${priceHistoryModel.prodNo}" readonly />

        <!-- 가격 코드 -->
        <input type="hidden" id="id" name="id" value="${priceHistoryModel.price.id}" readonly />

        <div class="form-group">
            <label for="product_name">제품 이름</label>
            <input type="text" id="product_name" name="product_name" class="form-control" value="${priceHistoryModel.product}" readonly />
        </div>

        <div class="form-group">
            <label for="from_date">시작 날짜</label>
            <input type="text" id="from_date" name="from_date" class="form-control" value="${priceHistoryModel.price.from_date}" readonly/>
        </div>

        <div class="form-group">
            <label for="to_date">종료 날짜</label>
            <input type="text" id="to_date" name="to_date" class="form-control" value="${priceHistoryModel.price.to_date}"readonly />
        </div>

        <div class="form-group">
            <label for="sale_or_purchase">구매/판매</label>
            <select id="sale_or_purchase" name="sale_or_purchase" class="form-control">
                <option value="0" ${priceHistoryModel.sale_or_purchase == 0 ? 'selected' : ''}>판매</option>
                <option value="1" ${priceHistoryModel.sale_or_purchase == 1 ? 'selected' : ''}>구매</option>
            </select>
        </div>

        <div class="form-group">
            <label for="price">가격</label>
            <input type="number" id="price" name="price" class="form-control" value="${priceHistoryModel.price.price}" />
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary btn-block">가격 수정</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
