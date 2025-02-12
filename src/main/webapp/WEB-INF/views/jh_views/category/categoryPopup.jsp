<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            background-color: white;
            color: #3b5998;
        }

        .top {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        a {
            color: #000000;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #2f8efd;
            text-decoration: underline;
        }

        .card {
            margin-bottom: 15px;
        }

        .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h3 class="text-center mb-4">카테고리 목록</h3>

    <div class="row">
        <c:forEach var="topCategory" items="${topList}">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <a href="javascript:void(0);" onclick="toggleMidCategories('${topCategory.top_category}')">
                                ${topCategory.title}
                        </a>
                    </div>
                    <div class="card-body" id="midCategories_${topCategory.top_category}" style="display: none;">
                        <table class="table">
                            <tbody>
                            <c:set var="count" value="0"/>
                            <tr>
                                <c:forEach var="midCategory" items="${midList}">
                                <c:if test="${midCategory.top_category == topCategory.top_category}">
                                <td>
                                    <a href="/Prod/Category/Modify?top_category=${topCategory.top_category}&mid_category=${midCategory.mid_category}">
                                            ${midCategory.content}
                                    </a>
                                </td>
                                <c:set var="count" value="${count + 1}"/>
                                <c:if test="${count % 2 == 0}">
                            </tr><tr>
                                </c:if>
                                </c:if>
                                </c:forEach>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    function toggleMidCategories(topCategory) {
        var row = document.getElementById("midCategories_" + topCategory);
        if (row.style.display === "none") {
            row.style.display = "block";
        } else {
            row.style.display = "none";
        }
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
