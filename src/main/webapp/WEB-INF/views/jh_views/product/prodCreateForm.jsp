<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 등록 </title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="/../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="/../css/insert.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        #description {
            height: 200px;
        }
    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menu1.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>

            <div class="insert-wrapper">

                <form id="productForm" action="/Sales/ProdCreateAct" method="post">

                    <div class="insert-header">
                        <div>
                            <div class="insert-submenu">제품 관리 > 제품 등록</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>제품 등록</h1>
                            </div>
                        </div>
                        <div>
                            <a href="/All/Sales/ProdList" class="insert-empty-button"> 취소</a>
                            <button type="submit" id="submitBtn" class="insert-full-button"> 등록</button>
                        </div>
                    </div>
                    <div class="insert-header-content">
                    <table class="insert-table">
                        <tr>
                            <th>제품명</th>
                            <td colspan="3"><input type="text" name="product_name" id="product_name" required
                                                   placeholder="제품명을 입력하세요"><span id="prodNameStatus"></span></td>
                        </tr>
                        <tr>
                            <th>대분류</th>
                            <td><select id="topCategory" name="category" required onchange="updateMidCategories()">
                                <option value="">대분류를 선택하세요</option>
                            </select></td>
                            <th>중분류</th>
                            <td><select id="midCategory" name="mid_category" required>
                                <option value="">중분류를 선택하세요</option>
                            </select></td>

                        </tr>
                        <tr>
                            <th>매출가</th>
                            <td><input type="number" name="sale_price" id="sale_price" value="0" min="0" required
                                       placeholder="매출가를 입력하세요"></td>
                            <th>매입가</th>
                            <td><input type="number" name="pur_price" id="pur_price" value="0" min="0" required
                                       placeholder="매입가를 입력하세요"></td>
                        </tr>
                        <tr>
                            <th>상세설명</th>
                               <td colspan="3" rowspan="6" style="height: 200px;"><textarea name="description" id="description" rows="4"
                                                                  placeholder="상세설명을 입력하세요" required></textarea></td>
                        </tr>

                    </table>
                    </div>
                </form>
            </div>


        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // 폼 제출 시 중복 체크
        $('#submitBtn').on('click', function (event) {
            var prodName = $('#product_name').val();  // 제품명 가져오기

            // 제품명이 비어 있지 않으면 중복 체크 수행
            if (prodName) {
                $.ajax({
                    url: '/Sales/validProdName',  // 중복 체크 URL
                    type: 'GET',
                    data: {prodName: prodName},  // 서버로 제품명 전달
                    success: function (response) {
                        if (response === '1') {
                            // 중복인 경우
                            alert('이미 존재하는 제품명입니다.');
                            event.preventDefault();  // 폼 제출을 막음
                        } else if (response === '0') {
                            // 사용 가능한 경우
                            alert('등록 하였습니다.');
                            // 중복이 아니면 폼 제출 허용
                            $('#productForm').submit();  // 실제 폼 제출
                        }
                    },
                    error: function () {
                        alert('중복 체크 실패');
                        event.preventDefault();  // 폼 제출을 막음
                    }
                });
            } else {
                alert('제품명을 입력해 주세요.');
                event.preventDefault();  // 제품명이 비었을 때 폼 제출 막음
            }
        });
    });


    // JSON 문자열을 JavaScript 객체로 파싱
    var topList = JSON.parse('${jsonTopList}');
    var midList = JSON.parse('${jsonMidList}');

    // 대분류 select box에 옵션 추가
    var topCategorySelect = document.getElementById("topCategory");

    topList.forEach(function (category) {
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
            midList.forEach(function (midCategory) {
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

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
