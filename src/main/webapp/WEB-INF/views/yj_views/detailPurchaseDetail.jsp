<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입고 상세</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">
    <style type="text/css">
        .detail-table td {
            color: black;
        }
    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <div class="detail-wrapper">
                <div class="detail-header">
                    <div>
                        <div class="detail-submenu">물류 관리 > 입고 조회</div>
                        <div class="detail-title">
                            <div></div>
                            <h1>입고 상세</h1>
                        </div>
                    </div>
                    <div>
                        <input class="btn detail-empty-button" type="button" value="목록" onclick="history.back()">
                    </div>
                </div>

                <div class="detail-header-content">
                    <table class="detail-table">
                        <tr>
                            <th>매입일자</th><td>${purchase_details.purchase_date}</td>
                        </tr>
                        <tr>
                            <th>담당자</th><td>${purchase_details.emp_name }</td>
                        </tr>
                        <tr>
                            <th>거래처명</th><td>${purchase_details.client_name}</td>
                        </tr>
                    </table>

                    <!-- 품목 정보 헤더 + '추가' 버튼 -->
                    <div class="product-header">
                        <div class="product-title">품목 정보</div>
                        <div></div>
                    </div>

                    <!-- 품목 정보 테이블 -->
                    <table class="detail-table">
                        <thead>
                        <tr>
                            <th>품목명</th>
                            <th>단가</th>
                            <th>수량</th>
                            <th>총 금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="purchase_details" items="${purchase_details_list}">
                            <tr>
                                <td>${purchase_details.product_name}</td>
                                <td>${purchase_details.price}</td>
                                <td>${purchase_details.quantity}</td>
                                <td><fmt:formatNumber value="${purchase_details.price * purchase_details.quantity}"
                                                      type="number" pattern="#,###"/></td>
                            </tr>
                            <c:set var="num" value="${num - 1 }"></c:set>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="../footer1.jsp" %>
    </div>
</div>
<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="../js1/sb-admin-2.min.js"></script>
</body>

</html>