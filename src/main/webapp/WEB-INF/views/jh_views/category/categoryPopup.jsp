<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 관리</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h3 {
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 14px;
            min-width: 100px;
            vertical-align: middle;
        }

        th {
            background-color: #efefef;
            color: #000000;
        }

        a {
            color: #000000;
            text-decoration: none;
        }

        a:hover {
            color: #2f8efd;
            text-decoration: underline;
        }

        #midCategoryTable {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h3 class="text-center mb-4">카테고리 목록</h3>

    <!-- 대분류 드롭다운 -->
    <div class="form-group">
        <label for="topCategorySelect">대분류 선택:</label>
        <select class="form-control" id="topCategorySelect" onchange="loadMidCategories()">
            <option value="">대분류 선택</option>
            <c:forEach var="topCategory" items="${topList}">
                <option value="${topCategory.top_category}">${topCategory.title}</option>
            </c:forEach>
        </select>
    </div>

    <div id="midCategoryTable">
        <table class="table">
            <thead>
            <tr>
                <th colspan="2">중분류</th>
            </tr>
            </thead>
            <tbody id="midCategoryTableBody">
            </tbody>
        </table>
    </div>
</div>

<script>
    function loadMidCategories() {
        var topCategoryId = document.getElementById("topCategorySelect").value;

        if (!topCategoryId) {
            document.getElementById("midCategoryTable").style.display = 'none';
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('GET', '/api/categories/mid?topCategory=' + topCategoryId, true);
        xhr.onload = function() {
            if (xhr.status == 200) {
                var midCategories = JSON.parse(xhr.responseText);
                var tableBody = document.getElementById("midCategoryTableBody");

                tableBody.innerHTML = '';

                for (var i = 0; i < midCategories.length; i++) {
                    var row;

                    if (i % 2 === 0) {
                        row = document.createElement('tr');
                        tableBody.appendChild(row);
                    }

                    var cell = document.createElement('td');
                    var link = document.createElement('a');
                    link.href = "/Sales/Category/Modify?top_category=" + topCategoryId + "&mid_category=" + midCategories[i].mid_category;
                    link.innerHTML = midCategories[i].content;
                    cell.appendChild(link);
                    row.appendChild(cell);
                }

                document.getElementById("midCategoryTable").style.display = midCategories.length > 0 ? 'block' : 'none';
            }
        };
        xhr.send();
    }

</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
