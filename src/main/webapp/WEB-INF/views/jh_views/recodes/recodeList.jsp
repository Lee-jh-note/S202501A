<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실적</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/list.css" rel="stylesheet">
    <style>
        input[type="month"] {
            padding: 3px 8px;
            font-size: 12px;
            height: 30px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menujh.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>


            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">실적 관리 > 실적 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>실적 조회</h1>
                        </div>
                    </div>
                    <div class="list-buttons">
                        <a href="/excel/sprecodes?yymmdd=${yymmdd != null ? yymmdd : ''}"
                           class="btn btn-info list-full-button"
                           onclick="return confirmDownload('${yymmdd != null ? yymmdd : ''}');">엑셀 다운로드</a>
                    </div>
                </div>

                <div class="list-header2">
                    <div></div>
                    <div class="list-search-filters">
                        <form action="/Recodes/List" method="get"
                              style="display: flex; gap: 10px; align-items: center;">
                            <label for="searchMonth" class="form-label">년/월 </label>
                            <input type="month" id="searchMonth" name="yymmdd"
                                   value="${yymmdd != null ? yymmdd : ''}">
                            <label for="product_name" class="form-label">제품명</label>
                            <input type="text" id="product_name" name="product_name"
                                   placeholder="제품명 입력"
                                   value="${param.product_name != null ? param.product_name : '' }">

                            <button type="submit" class="list-gray-button">조회</button>
                        </form>
                    </div>
                </div>
                <table class="list-table">
                    <thead>
                    <tr>
                        <th>날짜</th>
                        <th>대분류</th>
                        <th>제품번호</th>
                        <th>제품명</th>
                        <th>구매량</th>
                        <th>구매단가</th>
                        <th>구매총액</th>
                        <th>판매량</th>
                        <th>판매단가</th>
                        <th>판매총액</th>
                        <th>처리자</th>
                        <th>처리일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${recode}">
                        <tr>
                            <td>${item.yymmdd}</td>
                            <td>${item.title}</td>
                            <td>${item.product_no}</td>
                            <td>${item.product_name}</td>
                            <td>${item.purQuantity}</td>
                            <td>${item.purPrice}</td>
                            <td>${(item.purPrice * item.purQuantity)}</td>
                            <td>${item.saleQuantity}</td>
                            <td>${item.salePrice}</td>
                            <td>${(item.salePrice * item.saleQuantity)}</td>
                            <td>${item.emp_name}</td>
                            <td><fmt:formatDate value="${item.reg_date}" pattern="yy/MM/dd"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="text-center mt-3">
                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="/Recodes/List?currentPage=${i}&yymmdd=${yymmdd}&product_name=${param.product_name}"
                           class="btn btn-link">${i}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>
<script>
    function confirmDownload(yymmdd) {

            var year = yymmdd.substring(2, 4);
            var month = yymmdd.substring(5, 7);

            var formattedDate = year + '/' + month;

            var message = formattedDate + " 월의 실적을 받으시겠습니까?";

            return confirm(message);
    }
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Custom scripts -->
<script src="../../../../js1/sb-admin-2.min.js"></script>

<!-- jQuery -->
<script src="../../../../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../../../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin -->
<script src="../../../../vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
