<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
        }
        .container {
            width: 60%; /* 조정된 너비 */
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px; /* 셀 패딩 조정 */
            border: 1px solid #ddd; /* 경계선 스타일 조정 */
            text-align: left;
        }
        th {
            background-color: #f9f9f9; /* 헤더 배경색 */
            font-weight: normal;
        }
        .clickable-row { /* 행 전체 클릭 가능하게 */
            cursor: pointer;
        }
        .clickable-row:hover {
            background-color: #f1f1f1; /* 호버 색상 변경 */
        }
        a {
            color: #333;
            text-decoration: none;
            display: block; /* 링크를 블록으로 설정 */
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll('.clickable-row').forEach(row => {
                row.addEventListener('click', function () {
                    window.location.href = this.dataset.href;
                });
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>게시판 목록</h1>
        <table>
            <tr>
                <th>번호</th><th>이름</th><th>제목</th><th>날짜</th><th>히트</th>
            </tr>
            <c:forEach items="${listBoard}" var="board">
                <tr class="clickable-row" data-href="content_view?board_No=${board.board_No}">
                    <td>${board.board_No}</td>
                    <td>${board.emp_Name}</td>
                    <td>${board.title}</td>
                    <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${board.hits}</td>
                </tr>
            </c:forEach>
        </table>
        <div style="text-align: right; margin-top: 20px;">
            <a href="write_view">글작성</a>
        </div>
    </div>
</body>
</html>
