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
    <title>게시판 상세정보</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0 auto;
            width: 80%;
            padding: 100px;
        }
 
 
        .content-detail {
            width: 100%; /* 테이블 너비 확장 */
            margin-bottom: 30px;
        }
        .content-detail table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            table-layout: fixed;
        }
        .content-detail th, .content-detail td {
            border: 1px solid #ddd;
            padding: 15px;
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
        .button-group .delete-button {
            background-color: #f44336;
        }
        .button-group .delete-button:hover {
            background-color: #e53935;
        }
        /* 댓글 영역 스타일 */
        .comment-section {
            width: 100%;
            margin-top: 50px;
            padding: 15px;
            border-top: 2px solid #ddd;
        }
        .comment-section h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
        .comment-form {
            width: 100%;
            margin-bottom: 30px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .comment-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: vertical;
        }
        .comment-list {
            list-style: none;
            padding: 0;
        }
        .comment-item {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #fff;
            border-radius: 5px;
        }
        .comment-item .comment-info {
            font-size: 14px;
            color: #777;
        }
        .comment-item .comment-text {
            margin-top: 5px;
        }
        .comment-buttons {
            text-align: right;
            margin-top: 5px;
        }
        .comment-buttons button {
            font-size: 12px;
            padding: 5px 10px;
        }
    </style>
</head>
<body>



    <!-- 게시글 상세정보 -->
    <div class="content-detail">
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
                <td>${board.title}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${board.content}</td>
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
    </div>


<!-- 본인만 수정 및 삭제 가능 -->
<div class="button-group">

    <c:if test="${board.emp_Name eq empDTO.emp_Name}">
        <form action="/updateBoardForm" method="get" style="display:inline;">
            <input type="hidden" name="board_No" value="${board.board_No}">
            <button type="submit">수정하기</button>
            
        </form>
        <form action="/deleteBoard" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display:inline;">
            <input type="hidden" name="board_No" value="${board.board_No}">
            <button type="submit" class="cancel-button">삭제하기</button>
        </form>
    </c:if>
</div>


    <!-- 댓글 영역 -->
    <div class="comment-section">
        <h2>댓글</h2>

        <!-- 댓글 작성 폼 -->
        <div class="comment-form">
            <form action="/addComment" method="post">
                <input type="hidden" name="board_No" value="${board.board_No}">
                <textarea name="commentText" rows="3" placeholder="댓글을 입력하세요..." required></textarea>
                <button type="submit">댓글 작성</button>
            </form>
        </div>

        <!-- 댓글 목록 -->
        <ul class="comment-list">
            <c:choose>
                <c:when test="${empty comments}">
                    <li class="comment-item" style="text-align:center; color:gray;">등록된 댓글이 없습니다.</li>
                </c:when>
                <c:otherwise>
                    <c:forEach var="comment" items="${comments}">
                        <li class="comment-item">
                            <div class="comment-info">
                                ${comment.emp_Name} | <fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </div>
                            <div class="comment-text">
                                ${comment.content}
                            </div>
                            <div class="comment-buttons">
                                <form action="/deleteComment" method="post" style="display:inline;">
                                    <input type="hidden" name="comment_No" value="${comment.comment_No}">
                                    <button type="submit" class="delete-button">삭제</button>
                                </form>
                                <form action="/updateCommentForm" method="get" style="display:inline;">
                                    <input type="hidden" name="comment_No" value="${comment.comment_No}">
                                    <button type="submit">수정</button>
                                </form>
                            </div>
                        </li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

</body>
</html>
