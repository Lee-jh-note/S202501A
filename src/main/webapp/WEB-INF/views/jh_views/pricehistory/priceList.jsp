<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Price List</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/list.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menu1.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>


            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">제품 관리 > 가격 변동 내역</div>
                        <div class="list-title">
                            <div></div>
                            <h1>가격 변동 내역</h1>
                        </div>
                    </div>
                </div>


                <div class="list-header2">
                    <div></div>
                    <div class="list-search-filters">
                        <form action="/Prod/PriceList" method="get"
                              style="display: flex; gap: 10px; align-items: center;">

                            <label for="name">제품명</label>
                            <input type="text" id="name" name="name" value="${param.name}" placeholder="제품명 검색">

                            <label for="type">매입/매출</label>
                            <select name="type" id="type">
                                <option value="">전체</option>
                                <option value="0" ${param.type == '0' ? 'selected' : ''}>매입</option>
                                <option value="1" ${param.type == '1' ? 'selected' : ''}>매출</option>
                            </select>

                            <button type="submit" class="list-gray-button">검색</button>

                        </form>
                    </div>
                </div>
                <!-- 가격 리스트 테이블 -->
                <table class="list-table">
                    <thead>
                    <tr>
                        <th>제품명</th>
                        <th>시작일</th>
                        <th>종료일</th>
                        <th>매입/매출</th>
                        <th>가격</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 가격 목록을 반복 출력 -->
                    <c:forEach var="price" items="${priceList}">
                        <tr>
                            <td>${price.product_name}</td>
                            <td>${price.from_date}</td>
                            <td>${price.to_date == '99/12/31' ? '미정' : price.to_date}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${price.sale_or_purchase == 1}">매출가</c:when>
                                    <c:otherwise>매입가</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <!-- 가격을 클릭하면 수정 페이지로 이동하는 링크 설정 -->
                                <c:choose>
                                    <c:when test="${price.to_date == '99/12/31'}">
                                        <!-- '99/12/31'이면 ProdModify로 이동 -->
                                        <a href="/Prod/ProdModify?productNo=${price.product_no}" class="price-link">
                                            <fmt:formatNumber value="${price.price}" pattern="#,###"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 그 외에는 PriceModify로 이동 -->
                                        <a href="/Prod/PriceModify?id=${price.id}&product_no=${price.product_no}&product_name=${price.product_name}"
                                           class="price-link">
                                            <fmt:formatNumber value="${price.price}" pattern="#,###"/>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- 페이지 네비게이션 -->
                <div class="text-center mt-3">
                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="/Prod/PriceList?name=${SName}&type=${SType}&currentPage=${i}"
                           class="btn btn-link">${i}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
