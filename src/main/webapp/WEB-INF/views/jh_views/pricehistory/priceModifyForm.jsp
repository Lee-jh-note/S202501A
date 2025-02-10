<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가격 수정</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menu1.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>

            <form method="POST" action="/Prod/PriceModifyAct">
                <div class="detail-wrapper">

                    <div class="detail-header">
                        <div>
                            <div class="detail-submenu">제품 관리 > 가격 수정</div>
                            <div class="detail-title">
                                <div></div>
                                <h1>가격 수정</h1>
                            </div>
                        </div>
                    </div>

                    <!-- 제품 번호 -->
                    <input type="hidden" id="product_no" name="product_no" value="${priceHistoryModel.prodNo}"
                           readonly/>

                    <!-- 가격 코드 -->
                    <input type="hidden" id="id" name="id" value="${priceHistoryModel.price.id}" readonly/>
                    <div class="detail-header-content">
                        <table class="detail-table">
                            <tr>
                                <th>제품 이름</th>
                                <td>
                                    <input type="text" id="product_name" name="product_name" class="form-control"
                                           value="${priceHistoryModel.product}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th>시작 날짜</th>
                                <td>
                                    <input type="text" id="from_date" name="from_date" class="form-control"
                                           value="${priceHistoryModel.price.from_date}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th>종료 날짜</th>
                                <td>
                                    <input type="text" id="to_date" name="to_date" class="form-control"
                                           value="${priceHistoryModel.price.to_date}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th>구매/판매</th>
                                <td>
                                    <select id="sale_or_purchase" name="sale_or_purchase" class="form-control">
                                        <option value="0" ${priceHistoryModel.sale_or_purchase == 0 ? 'selected' : ''}>
                                            판매
                                        </option>
                                        <option value="1" ${priceHistoryModel.sale_or_purchase == 1 ? 'selected' : ''}>
                                            구매
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>가격</th>
                                <td>
                                    <input type="number" id="price" name="price" class="form-control"
                                           value="${priceHistoryModel.price.price}"/>
                                </td>
                        </table>
                        <div class="detail-buttons">
                            <a href="/Prod/PriceList" class="btn btn-secondary">돌아가기</a>
                            <button type="submit" class="btn btn-dark">수정</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
