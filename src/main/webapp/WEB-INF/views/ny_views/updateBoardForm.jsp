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
    <title>게시판 수정</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0 auto;
            width: 80%;
            padding: 20px;
        }

        .content-detail {
            margin-top: 200px;
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

  

    <!-- 수정 폼 -->
    <div class="content-detail">
        <form action="/updateBoard" method="post">
            <input type="hidden" name="board_No" value="${board.board_No}">
            
            <table>
                <tr>
                    <th>게시글 번호</th>
                    <td>${board.board_No}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${board.emp_Name}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="title" value="${board.title}" style="width: 100%; padding: 5px;" required>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="content" rows="10" style="width: 100%; padding: 5px;" required>${board.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th>수정일</th>
                    <td><fmt:formatDate value="${board.modifiedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                   

                </tr>
                <tr>
                    <th>조회수</th>
                    <td>${board.hits}</td>
                </tr>
            </table>

            <!-- 버튼 영역 -->
            <div class="button-group">
                <button type="submit">저장하기</button>
                <a href="/BoardList" class="cancel-button" style="text-decoration: none; padding: 10px 20px; border-radius: 5px; background-color: #f44336; color: white; font-size: 14px;">취소</a>
            </div>
        </form>
    </div>

</body>
</html>
