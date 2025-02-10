<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입고 예정 상세</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/detail.css" rel="stylesheet">
    <style type="text/css">
        .detail-table td {
            color: black;
        }
        .detail-table {
		    table-layout: fixed; /* 테이블 칸 크기 고정 */
		}
		   
		   
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
            background-color: #4e73df;
            color: #fff;
        }

        .modal-actions .cancel {
            background-color: #ccc;
            color: #000;
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
        function handleStore() {
            openModal("정말 입고처리 하시겠습니까?", () => {
            	document.querySelector("#storeForm").submit(); // 폼 제출
            });
        }
    </script>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <form action="purchaseDetailStore" method="post" id="storeForm">
	            <div class="detail-wrapper">
	                <div class="detail-header">
	                    <div>
	                        <div class="detail-submenu">물류 관리 > 입고예정리스트</div>
	                        <div class="detail-title">
	                            <div></div>
	                            <h1>입고예정 상세</h1>
	                        </div>
	                    </div>
	                    <div>
	                        <input class="btn detail-empty-button" type="button" value="목록" onclick="history.back()">
	                        <input class="btn detail-full-button" type="button"  value="입고" onclick="handleStore()">
	                    </div>
	                </div>
	
	                <div class="detail-header-content">
	                    <table class="detail-table">
	                        <tr>
	                            <th>매입일자</th><td>${purchase_details.purchase_date}</td>
	                            <th>발주 담당자</th><td>${purchase_details.emp_name}</td> <!-- 구매 테이블에서 가져온 담당자 이름 -->
	                        </tr>
	                        <tr>
	                            <th>거래처명</th><td>${purchase_details.client_name}</td>
	                            <th>입고 담당자</th><td>${emp_name}<!-- 화면에 이름 표시 -->
                            		<input type="hidden" name="emp_no" value="${emp_no}"><!-- emp_no 값을 숨겨서 전송 --> <!-- 세션에서 가져온 담당자 이름 - 현재 로그인 되어있는 사원 -->
	                        </tr>
	                    </table>
	
	                    <!-- 품목 정보 헤더 + '추가' 버튼 -->
	                    <div class="product-header">
	                        <div class="product-title">품목 정보</div>
	                        <div></div>
	                    </div>
	
	                    <!-- 품목 정보 테이블 -->
	                    <table class="detail-table">
	                        <thead>
	                        <tr>
	                        	<th>선택</th>
	                            <th>품목명</th>
	                            <th>단가</th>
	                            <th>수량</th>
	                            <th>총 금액</th>
	                        </tr>
	                        </thead>
	                        <tbody>
	                        <c:forEach var="purchase_details" items="${purchase_details_list}" varStatus="status">
	                            <tr>
	                            	<td>
				                        <input type="checkbox" name="checked" value="${status.index}">
				                        <input type="hidden" name="purchase_date" value="${purchase_details.purchase_date}">
				                        <input type="hidden" name="client_no" value="${purchase_details.client_no}">
				                        <input type="hidden" name="product_no" value="${purchase_details.product_no}">
			                    	</td>
	                                <td>${purchase_details.product_name}</td>
	                                <td>${purchase_details.price}</td>
	                                <td>${purchase_details.quantity}</td>
	                                <td><fmt:formatNumber value="${purchase_details.price * purchase_details.quantity}"
	                                                      type="number" pattern="#,###"/></td>
	                            </tr>
	                        </c:forEach>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
            </form>
            
            <!-- 모달 HTML -->
            <div class="modal-overlay">
                <div class="modal-confirm">
                    <p class="modal-message">정말 입고처리 하시겠습니까?</p>
                    <div class="modal-actions">
                        <button class="btn confirm">확인</button>
                        <button class="btn cancel">취소</button>
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