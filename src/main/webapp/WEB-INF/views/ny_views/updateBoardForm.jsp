<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">

    <style>
        
          pre {
          font-family: inherit; /* 부모 요소의 폰트 스타일을 그대로 상속 */
          font-size: 12px;  /* 부모 요소의 폰트 크기 유지 */
          color: black;
          white-space: pre-wrap; /* 자동 줄바꿈 적용 (줄바꿈 유지) */
      }
        /* 기존 테이블 스타일 유지 */
        .detail-table {
            width: 100%;
            border-collapse: collapse;
        }

        .detail-table th, .detail-table td {
            border: 1px solid #dadada;
            padding: 10px;
            vertical-align: middle;
        }

        /* 입력 필드 스타일 */
        .detail-table input, 
        .detail-table textarea {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .detail-table textarea {
            min-height: 200px; /* 내용 칸의 최소 높이 설정 */
            resize: vertical; /* 세로 크기 조절 가능 */
        }


    /* 버튼을 오른쪽 정렬 */
    .detail-buttons {
        display: flex;
        justify-content: flex-end; /* 오른쪽 정렬 */
        gap: 10px; /* 버튼 간격 */
        margin-top: 10px;
    }
    </style>
    <style type="text/css">
        .detail-table td {
            color: black;
        }
    </style>
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>

            <!-- 전체 div -->
            <div class="detail-wrapper">
                <div class="detail-header">
                    <div>
                        <div class="detail-submenu">게시판 > 자유게시판</div>
                        <div class="detail-title">
                            <div></div>
                            <h1>자유게시글 수정</h1>
                        </div>
                    </div>
                </div>

                <div class="detail-header-content">
                    <form action="/board/updateBoard" method="post">
                        <input type="hidden" name="board_No" value="${board.board_No}">

                        <table class="detail-table">
                            <!-- 제목 수정 가능 -->
                            <tr>
                                <th>제목</th>
                                <td colspan="5">
                                    <input type="text" name="title" value="${board.title}" required>
                                </td>
                            </tr>

                            <!-- 내용 수정 가능 -->
                            <tr>
                                <th>내용</th>
                                <td colspan="5">
                                    <textarea name="content" required>${board.content}</textarea>
                                </td>
                            </tr>

                            <!-- 작성일 & 수정일 -->
                            <tr class="date-row">
                                <th>작성일</th>
                                <td colspan="2"><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <th>수정일</th>
                                <td colspan="2"><fmt:formatDate value="${board.modifiedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            </tr>
                        </table>

                        <!-- 버튼 -->
                        <div class="detail-buttons">
                            <button type="submit" class="detail-full-button">저장</button>
                            <button type="button" class="detail-full-button" onclick="history.back()">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../footer1.jsp" %>
    </div>
</div>

<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../js1/sb-admin-2.min.js"></script>

</body>
</html>
