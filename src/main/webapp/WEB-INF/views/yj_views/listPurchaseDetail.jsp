<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입고 조회</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/list.css" rel="stylesheet">
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>

            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">물류 관리 > 입고 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>입고 조회</h1>
                        </div>
                    </div>
                    <div class="list-buttons">
                        <a href="/excel/purchaseDetailExcel?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}">
                            <button class="list-full-button">
                                <i class="fa-solid fa-file-excel"></i> 엑셀 다운로드
                            </button>
                        </a>
                        <button id="printSelection" class="list-full-button">
                            <i class="fa-solid fa-print"></i> 인쇄
                        </button>
                    </div>
                </div>
                <div class="list-header2">
                    <div></div>
                    <!-- 검색영역을 .search-filters 로 감싸기 -->
                    <div class="list-search-filters">
                        <form action="listPurchaseDetail" method="get"
                              style="display: flex; gap: 10px; align-items: center;">

                            <!-- 조회 기간 -->
                            <label for="startDate">매입일자</label>
                            <input type="date" id="startDate" name="startDate" value="${searchKeyword.startDate}"/>
                            <span>~</span>

                            <input type="date" id="endDate" name="endDate" value="${searchKeyword.endDate}"/>

                            <!-- 거래처 -->
                            <label for="client_name">거래처</label>
                            <input type="text" id="client_name" name="client_name" value="${searchKeyword.client_name}"
                                   placeholder="거래처 입력"/>

                            <!-- 검색 버튼 -->
                            <button type="submit" class="list-gray-button">조회</button>
                        </form>
                    </div>
                </div>

                <%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>
                <c:set var="num" value="${page.start}"/>

                <table class="list-table">
                    <thead>
                    <tr>
                        <th>NO</th>
                        <th>매입일자</th>
                        <th>거래처명</th>
                        <th>담당자</th>
                        <th>상품수</th>
                        <th>총수량</th>
                        <th>총금액</th>
                        <th>처리상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="purchase_details" items="${searchListPurchaseDetail}">
                        <tr>
                            <td>${num}</td>
                            <td>${purchase_details.purchase_date}</td>
                            <td>
                                <a href="detailPurchaseDetail?purchase_date=${purchase_details.purchase_date}&client_no=${purchase_details.client_no}">${purchase_details.client_name}</a>
                            </td>
                            <td>${purchase_details.emp_name}</td>
                            <td>${purchase_details.product_count}</td>
                            <td>${purchase_details.total_quantity}</td>
                            <td><fmt:formatNumber value="${purchase_details.total_price}" type="number"
                                                  pattern="#,###"/></td>
                            <td>${purchase_details.status}</td>
                        </tr>
                        <c:set var="num" value="${num + 1}"></c:set>
                    </c:forEach>
                    </tbody>
                </table>

                <div style="text-align: center; margin-top: 20px;">
                    <c:if test="${page.startPage > page.pageBlock}">
                        <a href="listPurchaseDetail?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&currentPage=${page.startPage-page.pageBlock}">[이전]</a>
                    </c:if>
                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="listPurchaseDetail?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&currentPage=${i}">[${i}]</a>
                    </c:forEach>
                    <c:if test="${page.endPage < page.totalPage}">
                        <a href="listPurchaseDetail?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&currentPage=${page.startPage+page.pageBlock}">[다음]</a>
                    </c:if>
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
