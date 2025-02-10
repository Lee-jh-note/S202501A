<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 관리</title> <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        table {
            margin: auto;
            width: auto;
            border-collapse: collapse; /* 셀 간 테두리가 겹치지 않도록 설정 */
            table-layout: auto;
            border: 1px solid #555555; /* 테이블의 외부 테두리 설정 */
            border-radius: 5px;
        }

        td, th {
            padding: 10px;
            min-width: 100px;
            text-align: center;
            align-content: center;
            font-size: 12px;
            border: 1px solid #555555; /* 각 셀의 테두리 설정 */
        }

        .top {
            text-align: center;
        }

        .mid {
            border: 1px solid #555555;
            background-color: #f4f4f4;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container mt-4"><h3 class="text-center mb-4">카테고리 목록</h3> <!-- 분류 생성 버튼 -->
    <div>
        <table class="tb1">
            <tbody>

            <c:set var="maxMidCount" value="0"/>

            <!-- 최대 중분류 개수 구하기 -->
            <c:forEach var="topCategory" items="${topList}">
                <c:set var="midCount" value="0"/>
                <c:forEach var="midCategory" items="${midList}">
                    <c:if test="${midCategory.top_category == topCategory.top_category}">
                        <c:set var="midCount" value="${midCount + 1}"/>
                    </c:if>
                </c:forEach>
                <c:if test="${midCount > maxMidCount}">
                    <c:set var="maxMidCount" value="${midCount}"/>
                </c:if>
            </c:forEach>
            <c:forEach var="topCategory" items="${topList}">
                <tr>
                    <th>
                        대분류
                    </th>
                    <td colspan="${maxMidCount}" class="top" ><a href="/Prod/Category/Modify?top_category=${topCategory.top_category}"
                           class="text-decoration-none">${topCategory.title}</a></td>
                </tr>
                <tr>
                    <th>
                        중분류
                    </th>
                    <c:set var="midCount" value="0"/>
                    <c:forEach var="midCategory" items="${midList}">
                        <c:if test="${midCategory.top_category == topCategory.top_category}">
                            <td class="mid">
                                <a href="/Prod/Category/Modify?top_category=${topCategory.top_category}&mid_category=${midCategory.mid_category}"
                                   class="text-decoration-none">${midCategory.content}</a>
                            </td>
                            <c:set var="midCount" value="${midCount + 1}"/>
                        </c:if>
                    </c:forEach>

                    <!-- 중분류가 부족한 경우 빈 td 추가 -->
                    <c:forEach begin="1" end="${maxMidCount - midCount}">
                        <td class="mid"></td>
                    </c:forEach>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div> <!-- Bootstrap JS, Popper.js, jQuery 추가 -->

<script>
    // td 갯수에 맞게 테이블의 크기를 조정하는 JavaScript 코드
    function resizeTable() {
        const table = document.getElementById('tb1');
        const rows = table.getElementsByTagName('tr');
        let maxColumns = 0;

        // 각 행에서 td 갯수를 세서 가장 많은 td가 있는 행의 갯수를 찾음
        for (let row of rows) {
            const columns = row.getElementsByTagName('td');
            maxColumns = Math.max(maxColumns, columns.length);
        }

        // 테이블의 너비를 td 갯수에 맞게 설정
        table.style.width = (maxColumns * 50) + 'px';  // 각 td가 100px 너비로 가정
    }

    // 페이지가 로드된 후 테이블 크기 조정
    window.onload = resizeTable;
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>