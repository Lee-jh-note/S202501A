<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/list.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .tb1 {
            width: auto;
            border: 1px solid;
            table-layout: auto;
            border-radius: 5px;
        }

        .tb1 td, th {
            padding: 10px;
            min-width: 100px;
            text-align: center;
            align-content: center;
            font-size: 12px;
            text-decoration: none;
            color: black;
        }

        .top {
            text-align: center;
        }

        .mid {
            border: 1px solid #555555;
            background-color: #f4f4f4;
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
                        <div class="list-submenu">제품 관리 > 제품 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>제품 조회</h1>
                        </div>
                    </div>
                    <div class="list-buttons">
                        <a href="/Prod/ProdCreate" class="btn btn-success list-full-button">제품 등록</a>
                        <div class="dropdown">
                            <button class="btn btn-success dropdown-toggle list-full-button" type="button"
                                    id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                분류 관리
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="window.open('/Prod/Category/List', 'Popup', 'width=800,height=500,scrollbars=yes');">분류 목록</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="window.open('/Prod/Category/Create', 'Popup', 'width=800,height=500,scrollbars=yes');">분류 생성</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="list-header2">
                    <div></div>
                    <!-- 검색 폼 -->
                    <div class="list-search-filters">
                        <form action="/Prod/ProdList" method="get"
                              style="display: flex; gap: 10px; align-items: center;">
                            <label for="product_name">제품명:</label>
                            <input type="text" id="product_name" name="name" value="${param.name}"
                                   placeholder="제품명 검색"/>

                            <label for="category">대분류</label>
                            <select id="category" name="type">
                                <option value="0">모든 대분류</option>
                                <c:forEach var="category" items="${category}">
                                    <option value="${category.top_category}">${category.title}</option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="list-gray-button">조회</button>
                        </form>
                    </div>
                </div>

                <!-- 상태 변경 폼 -->
                <form action="/Prod/Status" method="post">
                    <table class="list-table">
                        <thead>
                        <tr>
                            <th>제품 코드</th>
                            <th>제품 이름</th>
                            <th>상세</th>
                            <th>상태</th>
                            <th>분류</th>
                            <th><input type="checkbox" id="select_all" onclick="toggleAll(this)"/> All</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${list}">
                            <tr>
                                <td>${product.product_no}</td>
                                <td>
                                    <a href="/Prod/ProdDetails?productNo=${product.product_no}">${product.product_name}</a>
                                </td>
                                <td>${product.description}</td>
                                <td>${product.status == 0 ? '비활성' : '활성'}</td>
                                <td>${product.content}</td>
                                <td><input type="checkbox" name="product_no" value="${product.product_no}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div style="text-align: right; margin-top: 10px;">
                        <button type="submit" class="btn btn-primary">상태 변경</button>
                    </div>
                </form>

                <!-- 페이지 네비게이션 -->
                <div class="text-center mt-3">
                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="/Prod/ProdList?name=${name}&type=${type}&currentPage=${i}"
                           class="btn btn-link">${i}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>

<%--<!-- 카테고리 목록 모달 -->--%>
<%--<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">--%>
<%--    <div class="modal-dialog" role="document">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h5 class="modal-title" id="categoryModalLabel">카테고리 목록</h5>--%>
<%--                <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                    <span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
<%--            </div>--%>
<%--            <div class="modal-body">--%>
<%--                <table class="tb1" id="modaltbl">--%>
<%--                    <tbody>--%>
<%--                    <c:set var="maxMidCount" value="0"/>--%>

<%--                    <!-- 최대 중분류 개수 구하기 -->--%>
<%--                    <c:forEach var="topCategory" items="${topList}">--%>
<%--                        <c:set var="midCount" value="0"/>--%>
<%--                        <c:forEach var="midCategory" items="${midList}">--%>
<%--                            <c:if test="${midCategory.top_category == topCategory.top_category}">--%>
<%--                                <c:set var="midCount" value="${midCount + 1}"/>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                        <c:if test="${midCount > maxMidCount}">--%>
<%--                            <c:set var="maxMidCount" value="${midCount}"/>--%>
<%--                        </c:if>--%>
<%--                    </c:forEach>--%>

<%--                    <c:forEach var="topCategory" items="${topList}">--%>
<%--                        <tr>--%>
<%--                            <th colspan="${maxMidCount}" class="top">--%>
<%--                                <a href="/Prod/Category/Modify?top_category=${topCategory.top_category}"--%>
<%--                                   class="text-decoration-none">${topCategory.title}</a>--%>
<%--                            </th>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <c:set var="midCount" value="0"/>--%>
<%--                            <c:forEach var="midCategory" items="${midList}">--%>
<%--                                <c:if test="${midCategory.top_category == topCategory.top_category}">--%>
<%--                                    <td class="mid">--%>
<%--                                        <a href="/Prod/Category/Modify?top_category=${topCategory.top_category}&mid_category=${midCategory.mid_category}"--%>
<%--                                           class="text-decoration-none">${midCategory.content}</a>--%>
<%--                                    </td>--%>
<%--                                    <c:set var="midCount" value="${midCount + 1}"/>--%>
<%--                                </c:if>--%>
<%--                            </c:forEach>--%>

<%--                            <!-- 중분류가 부족한 경우 빈 td 추가 -->--%>
<%--                            <c:forEach begin="1" end="${maxMidCount - midCount}">--%>
<%--                                <td class="mid"></td>--%>
<%--                            </c:forEach>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>


<script>
    function toggleAll(source) {
        checkboxes = document.getElementsByName('product_no');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
    //     function adjustModalSize() {
    //         var table = document.getElementById('modaltbl'); // 모달 안의 테이블
    //         var modalDialog = document.getElementById('categoryModal').querySelector('.modal-dialog'); // 모달 다이얼로그
    //
    //     // 테이블이 제대로 로드되었는지 확인
    //     if (table) {
    //         // 테이블의 높이를 기반으로 모달의 크기 결정
    //         var tableHeight = table.offsetHeight;
    //         var tableWidth = table.offsetWidth;
    //
    //         // 테이블의 크기에 맞춰 모달 창 크기 설정
    //         modalDialog.style.maxHeight = (tableHeight + 100) + 'px';  // 테이블 높이에 여유 공간 추가
    //         modalDialog.style.maxWidth = (tableWidth + 100) + 'px';  // 테이블 너비에 여유 공간 추가
    //         modalDialog.style.overflowY = 'auto';  // 내용이 많을 경우 스크롤 가능하게 설정
    //     }
    // }
    //
    // // 모달이 열릴 때 adjustModalSize 함수 호출
    // $('#categoryModal').on('shown.bs.modal', function() {
    //     setTimeout(adjustModalSize, 100);  // 모달이 완전히 열린 후 크기 조정
    // });


</script>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
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
