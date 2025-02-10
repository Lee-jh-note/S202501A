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
        .tb1 td, th {
            padding: 10px;
            min-width: 100px;
            text-align: center;
            align-content: center;
            font-size: 12px;
            text-decoration: none;
            color: black;
        }

        .button-group {
            /*display: flex;*/
            gap: 10px; /* 버튼 간의 간격 */
            /*justify-content: flex-start;  !* 왼쪽 정렬 *!*/
            align-items: center; /* 수직 중앙 정렬 */
        }

        .list-header2 {
            display: block;
        }

        .list-search-filters {
            justify-content: right;
        }

        .list-status-button {
            background-color: #759fff;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
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
                        <a href="/Prod/ProdCreate" class="btn list-full-button">제품 등록</a>
                        <div class="dropdown">
                            <button class="btn dropdown-toggle list-full-button" type="button"
                                    id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                분류 관리
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <li><a class="dropdown-item" href="javascript:void(0);"
                                       onclick="window.open('/Prod/Category/List', 'Popup', 'width=800,height=500,scrollbars=yes');">분류
                                    목록</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);"
                                       onclick="window.open('/Prod/Category/Create', 'Popup', 'width=800,height=500,scrollbars=yes');">분류
                                    생성</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="list-header2">
                    <div></div>
                    <!-- 검색 폼 -->
                    <div class="button-group">
                        <div class="list-search-filters">
                            <label for="product_name">제품명:</label>
                            <input type="text" id="product_name" placeholder="제품명 검색"/>

                            <label for="category">대분류</label>
                            <select id="category">
                                <option value="0">모든 대분류</option>
                                <c:forEach var="category" items="${category}">
                                    <option value="${category.top_category}">${category.title}</option>
                                </c:forEach>
                            </select>

                            <button id="searchButton" class="list-gray-button">조회</button>
                            <button type="button" id="submitBtn" class="list-status-button">상태 변경</button>
                        </div>
                        <form id="statusForm" action="/Prod/Status" method="post" onsubmit="return validateForm()"
                              style="margin: 0">
                            <table class="list-table">
                                <thead>
                                <tr>
                                    <th>제품 코드</th>
                                    <th>제품 이름</th>
                                    <th>상세</th>
                                    <th>상태</th>
                                    <th>분류</th>
                                    <th><input type="checkbox" id="select_all" onclick="toggleAll(this)"/></th>
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
                                        <td><input type="checkbox" name="product_no" value="${product.product_no}"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </form>


                    </div>
                </div>
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


<script>

    document.getElementById('submitBtn').addEventListener('click', function() {
        if (validateForm()) {
            document.getElementById('statusForm').submit();
        }
    });

    function validateForm() {
        // 선택값이 없을 때 검증
        const checkboxes = document.querySelectorAll('input[name="product_no"]:checked');
        if (checkboxes.length === 0) {
            alert("상태 변경할 제품을 선택하세요.");
            return false;
        }
        return true;
    }
    function toggleAll(source) {
        checkboxes = document.getElementsByName('product_no');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }

    document.getElementById("searchButton").addEventListener("click", function () {
        var productName = document.getElementById("product_name").value;  // 제품명
        var category = document.getElementById("category").value;  // 대분류

        // URL에 쿼리 문자열을 추가하여 서버로 전달
        var url = "/Prod/ProdList?name=" + encodeURIComponent(productName) + "&type=" + encodeURIComponent(category);

        // 페이지 리디렉션 (서버에서 데이터를 처리하여 해당 URL로 이동)
        window.location.href = url;
    });

</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="../../../../js1/sb-admin-2.min.js"></script>

<script src="../../../../vendor/jquery/jquery.min.js"></script>

<script src="../../../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../../../../vendor/jquery-easing/jquery.easing.min.js"></script>

</body>
</html>
