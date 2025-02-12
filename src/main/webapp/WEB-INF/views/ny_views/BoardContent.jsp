<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시글</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">
    
    
    <style>

        /* 모달 스타일 */
        .modal-overlay {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }
        /* 모달도 폰트 12로 맞출지?
        .modal-overlay * {
           font-size: 12px;
        }
 */
        .modal-confirm {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 300px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        .modal-confirm p {
            margin: 20px 0;
        }

        .modal-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .modal-actions button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .modal-actions .confirm {
            background-color: #ff5e57;
            color: #fff;
        }

        .modal-actions .cancel {
            background-color: #ccc;
            color: #000;
        }
        pre {
          font-family: inherit; /* 부모 요소의 폰트 스타일을 그대로 상속 */
          font-size: 12px;  /* 부모 요소의 폰트 크기 유지 */
          color: black;
          white-space: pre-wrap; /* 자동 줄바꿈 적용 (줄바꿈 유지) */
      }
      
      
      
      /* 상세 테이블 스타일 수정 */
        .detail-table {
            width: 100%;
            border-collapse: collapse;
        }

        .detail-table th, .detail-table td {
            border: 1px solid #dadada;
            padding: 10px;
            vertical-align: middle;
        }

        /* 테이블 열 너비 조정 */
        .detail-table th:nth-child(1),
        .detail-table td:nth-child(1) { width: 10%; } /* 제목 */
        
        .detail-table th:nth-child(2),
        .detail-table td:nth-child(2) { width: 40%; } /* 제목 내용 */

        .detail-table th:nth-child(3),
        .detail-table td:nth-child(3) { width: 10%; } /* 작성자 */

        .detail-table th:nth-child(4),
        .detail-table td:nth-child(4) { width: 20%; } /* 작성자 이름 */

        .detail-table th:nth-child(5),
        .detail-table td:nth-child(5) { width: 10%; } /* 조회수 */

        .detail-table th:nth-child(6),
        .detail-table td:nth-child(6) { width: 10%; } /* 조회수 값 */

    /* 상세 테이블 스타일 */
    .detail-table {
        width: 100%;
        border-collapse: collapse;
    }

    .detail-table th, .detail-table td {
        border: 1px solid #dadada;
        padding: 10px;
        vertical-align: middle;
    }

    /* 내용 칸을 조회수 끝까지 확장 */
    .detail-table .content-cell {
        min-height: 200px; /* 최소 높이 설정 */
        height: auto; /* 내용이 많아지면 자동 확장 */
        vertical-align: top; /* 위쪽 정렬 */
    }

    /* 내용 칸 내부 div를 사용하여 크기 유지 */
    .content-container {
        display: block;
        min-height: 200px; /* 기본 높이 */
        padding: 10px;
    }

    /* 버튼을 오른쪽 정렬 */
    .detail-buttons {
        display: flex;
        justify-content: flex-end; /* 오른쪽 정렬 */
        gap: 10px; /* 버튼 간격 */
        margin-top: 10px;
    }
    
    
    
     /* 댓글 전체 영역을 게시판과 같은 너비로 설정 */
.comment-section {
    width: 100%; /* 게시판과 동일한 너비 설정 */
    max-width: 100%;
    margin: 0 auto; /* 가운데 정렬 */
    padding: 15px;
    border-top: 2px solid #ddd;
    box-sizing: border-box;
    
      font-family: inherit;
        font-size: 14px;
        color: black;
}

/* 댓글 작성 폼 스타일 */
.comment-form {
    width: 100%;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #f9f9f9;
    
    box-sizing: border-box;
      font-family: inherit;
        font-size: 14px;
        color: black;
}


/* 댓글 목록 스타일 */
.comment-list {
    width: 100%;
    padding: 0;
    list-style: none;
    margin-bottom: 15px;
}

/* 개별 댓글 스타일 */
.comment-item {
    border-bottom: 1px solid #ddd;
    padding: 10px;
    background-color: #fff;
    border-radius: 5px;
    width: 100%;
    box-sizing: border-box;
}

/* 댓글 작성자 및 날짜 정보 */
.comment-info {
    font-size: 14px;
    color: #777;
}

/* 댓글 내용 */
.comment-text {
     margin-top: 3px; /* 위쪽 여백 최소화 */
    padding: 3px 5px; /* 내부 패딩 줄이기 */
    line-height: 1.6; /* 줄 간격 조정 */
    word-break: break-word; /* 긴 단어 줄바꿈 */
     font-family: inherit;
       
}


/* 댓글 내용에서 스크롤바 제거 */
.comment-text pre {
    overflow: hidden; /* 스크롤바 숨김 */
    white-space: pre-wrap; /* 자동 줄바꿈 */
    word-wrap: break-word; /* 긴 단어도 줄바꿈 */
}



/* 댓글 버튼 정렬 */
.comment-buttons {
    text-align: right;
    margin-top: 5px;
}

    /* 댓글 입력 창 크기 조정 */
    .comment-form textarea {
        width: 100%;
        min-height: 100px; /* 기본 높이를 키움 */
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: vertical; /* 사용자가 세로 크기 조절 가능 */
        font-family: inherit;
        font-size: 14px;
        color: black;
    }



/* 댓글 수정 & 삭제 버튼 */
.comment-buttons button {
    font-size: 12px;
    padding: 5px 10px;
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
                            <h1>자유게시글 상세</h1>
                        </div>
                    </div>
                   
                   <div class="detail-buttons">
                        <input class="btn detail-empty-button" type="button" value="목록" onclick="location.href='BoardList'">
                             <c:if test="${board.emp_No eq empDTO.emp_No}">
                             <input class="btn detail-full-button" type="button" value="수정"
                            onclick="location.href='updateBoardForm?board_No=${board.board_No}'">
                            <input class="btn detail-full-button" type="button" value="삭제" onclick="handleDeleteBoard('${board.board_No}')">
                    </c:if>
                    </div>
  				
  					 
                </div>

                <div class="detail-header-content">
                    <table class="detail-table">
                        <tr>
                           <th>제목</th><td colspan="2">${board.title}</td>
                            <th>작성자</th><td>${board.emp_Name}</td>
                            <th>조회수</th><td>${board.hits}</td>
                        </tr>
                       
                        <tr class="date-row">
                             <th>작성일</th><td colspan="2"><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></td>
                            <th>수정일</th><td colspan="3"><fmt:formatDate value="${board.modifiedDate}" pattern="yyyy-MM-dd"/></td>                                       
                         </tr>
                       
                     	<tr> 
				   		  <th>내용</th><td colspan="6" class="content-cell">
       					<div class="content-container"><pre>${board.content}</pre></div></td>
                       </tr> 
                    </table>

<!-- 댓글 영역 (게시판과 동일한 너비로 설정) -->
<div class="comment-section">
    <!-- 댓글 목록 -->
    <ul class="comment-list">
        <c:choose>
            <c:when test="${empty listReply}">
                <li class="comment-item" style="text-align:center; color:gray;">등록된 댓글이 없습니다.</li>
            </c:when>
            <c:otherwise>
                <c:forEach var="board" items="${listReply}">
                    <li class="comment-item" id="comment-${board.board_No}">
                        <!-- 댓글 작성자 정보 -->
                        <div class="comment-info">
                            ${board.emp_Name} | 
                            <fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <c:if test="${not empty board.modifiedDate and board.modifiedDate ne board.createdDate}">
                                (수정됨: <fmt:formatDate value="${board.modifiedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>)
                            </c:if>
                        </div>

                        <!-- 댓글 내용 -->
                        <div class="comment-text" id="commentText-${board.board_No}">
                            <pre>${board.content}</pre>
                        </div>

                        <!-- 수정 폼 (기본 숨김) -->
                        <div class="comment-form" id="editForm-${board.board_No}" style="display:none;">
                            <form action="/board/updateReply" method="post">
                                <input type="hidden" name="board_No" value="${board.board_No}">
                                <input type="hidden" name="comment_Group" value="${board.comment_Group}">
                                <textarea name="content" rows="2" required>${board.content}</textarea>
                                <button type="submit" class="btn detail-gray-button">저장</button>
                                <button type="button" class="btn detail-gray-button" onclick="cancelEdit('${board.board_No}')">취소</button>
                            </form>
                        </div>

                        <!-- 본인만 수정 및 삭제 가능 -->
                        <c:if test="${board.emp_No eq empDTO.emp_No}">
                            <div class="comment-buttons" id="commentButtons-${board.board_No}">
                                <button type="button" class="btn detail-gray-button" onclick="editComment('${board.board_No}')">수정</button>
                                <button type="button" class="btn detail-gray-button" onclick="handleDeleteReply('${board.board_No}', '${board.comment_Group}')">삭제</button>
                            </div>
                        </c:if>
                    </li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>

    <!-- 댓글 작성 폼 -->
    <div class="comment-form">
      <form id="commentForm" action="/board/reply" method="post">
		    <input type="hidden" name="board_No" value="${board.board_No}">
		    <input type="hidden" name="comment_Group" value="${board.comment_Group}">
		    <input type="hidden" name="comment_Indent" value="${board.comment_Indent+1}">
		    <input type="hidden" name="comment_Step" value="${board.comment_Step+1}">
		    <textarea id="commentContent" name="content" rows="3"
		        style="width:100%; height:120px; min-height:120px; resize:vertical; font-size:14px; padding:10px;"
		        placeholder="댓글을 입력하세요..." required></textarea>
		
		    <button type="submit" class="btn detail-gray-button" id="commentSubmit">댓글 작성</button>
		    <button type="button" class="btn detail-gray-button" id="cancelEdit" style="display: none;" onclick="cancelEdit()">취소</button>
	  </form>

    </div>
</div>

                </div>
            </div>


     <!-- 삭제 모달 HTML  -->
<div class="modal-overlay">
    <div class="modal-confirm">
        <p class="modal-message">정말 삭제하시겠습니까?</p>
        <div class="modal-actions">
            <button class="confirm">확인</button>
            <button class="cancel">취소</button>
        </div>
    </div>
</div>

<script> 
// 모달 열기
    function openModal(message, onConfirm) {
        document.querySelector(".modal-message").innerHTML = message;
        document.querySelector(".modal-overlay").style.display = "block";
// 확인 버튼 이벤트 핸들러 설정
        document.querySelector(".confirm").onclick = () => {
            document.querySelector(".modal-overlay").style.display = "none";
            if (typeof onConfirm === "function") {
                onConfirm();
            }
        };
        // 취소 버튼 클릭 시 모달 닫기

        document.querySelector(".cancel").onclick = () => {
            document.querySelector(".modal-overlay").style.display = "none";
        };
    }
    
 // 삭제 버튼 클릭 시 모달 열기
    function handleDeleteReply(boardNo, commentGroup) {
        openModal("정말 삭제하시겠습니까?", () => {
            location.href = "/board/deleteReply?board_No=" + boardNo + "&comment_Group=" + commentGroup;
        });
    }
    function handleDeleteBoard(boardNo) {
        openModal("정말 삭제하시겠습니까?", () => {
            location.href = "/board/deleteBoard?board_No=" + boardNo;
        });
    }
 // 댓글 수정 모드 활성화 (기존 버튼 숨김)
    function editComment(boardNo) {
        // 기존 댓글 숨기기
        document.getElementById("commentText-" + boardNo).style.display = "none";
        
        // 수정 폼 보이기
        document.getElementById("editForm-" + boardNo).style.display = "block";

        // 기존 수정 및 삭제 버튼 숨기기
        document.getElementById("commentButtons-" + boardNo).style.display = "none";
    }

    // 수정 취소 기능 (기존 버튼 다시 보이기)
    function cancelEdit(boardNo) {
        // 기존 댓글 다시 보이기
        document.getElementById("commentText-" + boardNo).style.display = "block";
        
        // 수정 폼 숨기기
        document.getElementById("editForm-" + boardNo).style.display = "none";

        // 기존 수정 및 삭제 버튼 다시 보이기
        document.getElementById("commentButtons-" + boardNo).style.display = "block";
    }
    
    
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("commentForm").addEventListener("submit", function(event) {
            let commentContent = document.getElementById("commentContent").value.trim();
            
            if (commentContent === "") {
                alert("댓글 내용을 입력하세요.");
                event.preventDefault(); // 폼 제출 방지
            }
        });
    });

</script>

 </div>
        <%@ include file="../footer1.jsp" %>
    </div>
</div>
<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="../js1/sb-admin-2.min.js"></script>
</body>

</html>