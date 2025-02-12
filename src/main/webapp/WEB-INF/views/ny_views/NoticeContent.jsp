<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>
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
    pre {
   font-family: inherit; /* 부모 요소의 폰트 스타일을 그대로 상속 */
   font-size: 12px;  /* 부모 요소의 폰트 크기 유지 */
   color: black;
   white-space: pre-wrap; /* 자동 줄바꿈 적용 (줄바꿈 유지) */
}
    </style>
    
    <script>
        // 모달 열기
        function openModal(message, onConfirm) {
            document.querySelector(".modal-message").innerHTML = message;
            document.querySelector(".modal-overlay").style.display = "block";

            // 확인 버튼 이벤트 핸들러 설정
            const confirmButton = document.querySelector(".confirm");
            confirmButton.onclick = () => {
                document.querySelector(".modal-overlay").style.display = "none";
                if (typeof onConfirm === "function") {
                    onConfirm(); // 확인 콜백 호출
                }
            };

            // 취소 버튼 클릭 시 모달 닫기
            document.querySelector(".cancel").onclick = () => {
                document.querySelector(".modal-overlay").style.display = "none";
            };
        }

        // 삭제 버튼 클릭 시 모달 열기
        function handleDelete() {
            openModal("정말 삭제하시겠습니까?", () => {
                // 삭제 로직 실행
                location.href="deleteNotice?board_No=${notice.board_No}";
            });
        }
    </script>
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
                        <div class="detail-submenu">게시판 > 공지사항</div>
                        <div class="detail-title">
                            <div></div>
                            <h1>게시글 상세</h1>
                        </div>
                    </div>
      		<div class="detail-buttons">
                         <input class="btn detail-empty-button" type="button" value="목록" onclick="location.href='NoticeList'">

                            <input class="btn detail-full-button" type="button" value="수정"
                                   onclick="location.href='updateNoticeForm?board_No=${notice.board_No}'">
                            <input class="btn detail-full-button" type="button" value="삭제" onclick="handleDelete()">
                       
                    </div>
   
                </div>

                <div class="detail-header-content">
                    <table class="detail-table">
                        <tr>
                           <th>제목</th><td colspan="2">${notice.title}</td>
                            <th>작성자</th><td>${notice.emp_Name}</td>
                            <th>조회수</th><td>${notice.hits}</td>
                        </tr>
                        
                         <tr class="date-row">
                             <th>작성일</th><td colspan="2"><fmt:formatDate value="${notice.createdDate}" pattern="yyyy-MM-dd"/></td>
                            <th>수정일</th><td colspan="3"><fmt:formatDate value="${notice.modifiedDate}" pattern="yyyy-MM-dd"/></td>                                       
                         </tr>
                         
                     	<tr> 
				   		  <th>내용</th><td colspan="6" class="content-cell">
       					<div class="content-container"><pre>${notice.content}</pre></div></td>
                       </tr> 
                       
                      
                    </table>


                  
                </div>
            </div>

            <!-- 모달 HTML -->
            <div class="modal-overlay">
                <div class="modal-confirm">
                    <p class="modal-message">정말 삭제하시겠습니까?</p>
                    <div class="modal-actions">
                        <button class="confirm">확인</button>
                        <button class="cancel">취소</button>
                    </div>
                </div>
            </div>
            <!-- End of Main Content -->


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