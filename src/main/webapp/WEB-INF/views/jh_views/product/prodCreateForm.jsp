<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 등록 </title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            font-weight: 500;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f1f1f1;
            color: #555;
        }

        td {
            background-color: #fff;
            color: #333;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }

        button {
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: 500;
            color: #555;
        }

        .form-footer {
            text-align: center;
        }

        .form-footer a {
            color: #4CAF50;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .form-footer a:hover {
            color: #388e3c;
        }

        /* For Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>제품 등록</h2>

    <form id="productForm" action="/Prod/ProdCreateAct" method="post">
        <div class="form-group">
            <label for="product_name"><i class="fas fa-cogs"></i> 제품명</label>
            <input type="text" name="product_name" id="product_name" required placeholder="제품명을 입력하세요">
            <!-- 중복 체크 결과를 표시할 공간 -->
            <span id="prodNameStatus"></span>
        </div>

        <div class="form-group">
            <label for="topCategory"><i class="fas fa-list"></i> 대분류</label>
            <select id="topCategory" name="category" required onchange="updateMidCategories()">
                <option value="">대분류를 선택하세요</option>
            </select>
        </div>

        <div class="form-group">
            <label for="midCategory"><i class="fas fa-list-alt"></i> 중분류</label>
            <select id="midCategory" name="mid_category" required>
                <option value="">중분류를 선택하세요</option>
            </select>
        </div>

        <div class="form-group">
            <label for="sale_price"><i class="fas fa-tags"></i> 매출가</label>
            <input type="number" name="sale_price" id="sale_price" value="0" min="0" required placeholder="매출가를 입력하세요">
        </div>

        <div class="form-group">
            <label for="pur_price"><i class="fas fa-shopping-cart"></i> 매입가</label>
            <input type="number" name="pur_price" id="pur_price" value="0" min="0" required placeholder="매입가를 입력하세요">
        </div>

        <div class="form-group">
            <label for="description"><i class="fas fa-pencil-alt"></i> 상세설명</label>
            <textarea name="description" id="description" rows="4" placeholder="상세설명을 입력하세요" required></textarea>
        </div>

        <div class="form-footer">
            <button type="button" id="submitBtn"><i class="fas fa-save"></i> 등록</button>
        </div>
    </form>

    <div class="form-footer">
        <p><a href="/Prod/ProdList"><i class="fas fa-arrow-left"></i> 돌아가기</a></p>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 폼 제출 시 중복 체크
        $('#submitBtn').on('click', function(event) {
            var prodName = $('#product_name').val();  // 제품명 가져오기

            // 제품명이 비어 있지 않으면 중복 체크 수행
            if (prodName) {
                $.ajax({
                    url: '/Prod/validProdName',  // 중복 체크 URL
                    type: 'GET',
                    data: { prodName: prodName },  // 서버로 제품명 전달
                    success: function(response) {
                        if (response === '1') {
                            // 중복인 경우
                            $('#prodNameStatus').text('이미 존재하는 제품명입니다.').css('color', 'red');
                            event.preventDefault();  // 폼 제출을 막음
                        } else if (response === '0') {
                            // 사용 가능한 경우
                            $('#prodNameStatus').text('사용 가능한 제품명입니다.').css('color', 'green');
                            // 중복이 아니면 폼 제출 허용
                            $('#productForm').submit();  // 실제 폼 제출
                        }
                    },
                    error: function() {
                        $('#prodNameStatus').text('중복 체크 실패').css('color', 'red');
                        event.preventDefault();  // 폼 제출을 막음
                    }
                });
            } else {
                $('#prodNameStatus').text('제품명을 입력해 주세요.').css('color', 'red');
                event.preventDefault();  // 제품명이 비었을 때 폼 제출 막음
            }
        });
    });




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
