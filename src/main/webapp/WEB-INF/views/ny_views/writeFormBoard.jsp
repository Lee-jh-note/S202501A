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
    <title>게시글 작성</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0 auto;
            width: 80%;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .content-detail {
            margin: 50px auto;
            width: 80%;
        }
        .content-detail table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 50px;
            table-layout: fixed;
        }
        .content-detail th, .content-detail td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
            word-wrap: break-word;
        }
        .content-detail th {
            background-color: #f4f4f4;
            width: 20%;
        }
        .content-detail td {
            background-color: #fff;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button-group button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .button-group button:hover {
            background-color: #45a049;
        }
        .button-group .cancel-button {
            background-color: #f44336;
        }
        .button-group .cancel-button:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>

    <h1>게시글 작성</h1>

    <!-- 게시글 작성 폼 -->
    <div class="content-detail">
        <form action="/writeBoard" method="post">
            <!-- 로그인한 사용자의 사원 번호를 hidden input으로 전달 -->
            <input type="hidden" name="emp_No" value="${empDTO.emp_No}">
            <input type="hidden" name="emp_Name" value="${empDTO.emp_Name}">

            <table>
                <tr>
                    <th>작성자</th>
                    <td>
                        <span>${empDTO.emp_Name}</span> <!-- 화면에만 표시 -->
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="title" placeholder="제목을 입력하세요" style="width: 100%; padding: 5px;" required>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="content" placeholder="내용을 입력하세요" rows="10" style="width: 100%; padding: 5px;" required></textarea>
                    </td>
                </tr>
            </table>

            <!-- 버튼 영역 -->
            <div class="button-group">
                <button type="submit">등록하기</button>
                <a href="/BoardList" class="cancel-button" style="text-decoration: none; padding: 10px 20px; border-radius: 5px; background-color: #f44336; color: white; font-size: 14px;">취소</a>
            </div>
        </form>
    </div>

</body>
</html>
