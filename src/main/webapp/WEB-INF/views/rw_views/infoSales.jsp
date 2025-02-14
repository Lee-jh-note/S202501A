<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수주 상세조회</title>
<!-- 엑셀 다운로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/detail.css' />">
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
	font-size: 12px; /* 부모 요소의 폰트 크기 유지 */
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
        location.href = "/Sales/deleteSales?sales_date=${sales.sales_date}&client_no=${sales.client_no}&status=${sales.status}";
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
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>
				<!-- 전체 div -->
				<div class="detail-wrapper">
					<div class="detail-header">
						<div>
							<div class="detail-submenu">발주/수주 관리 > 수주 조회</div>
							<div class="detail-title">
								<div></div>
								<h1>수주 상세조회</h1>
							</div>
						</div>

						<!-- 버튼 -->
						<div>
							<button type="button" class="detail-empty-button" onclick="history.back()">목록</button>

							<!-- 상태가 '0'(대기)일 때만 수정/삭제 버튼 표시 -->
							<c:if test="${infoSales.status == '0'}">
								<button type="button" class="detail-full-button" onclick="location.href='/Sales/updateSales?sales_date=${infoSales.sales_date}&client_no=${infoSales.client_no}'">수정</button>
								<button type="button" class="detail-full-button" onclick="handleDelete()">삭제</button>
							</c:if>
						</div>
					</div>

					<!-- 수주 정보 테이블-->
					<div class="detail-header-content">
						<table class="detail-table">

							<tr>
								<th>제목</th><td colspan="3">${infoSales.title}</td>
							</tr>
							<tr>
								<th>매출일자</th><td>${infoSales.sales_date}</td>
								<th>담당자</th><td>${infoSales.emp_name}</td>
							</tr>
							<tr>
								<th>요청배송일</th><td>${infoSales.req_delivery_date.substring(0,10)}</td>
								<th>거래처명</th><td>${infoSales.client_name}</td>
							</tr>
							<tr>
								<th>비고</th><td colspan="3" id="note"><pre>${infoSales.remarks}</pre></td>
							</tr>
						</table>

						<div class="product-header">
							<div class="product-title">품목 정보</div>
							<div></div>
						</div>

						<!-- 품목 정보 테이블 -->
						<table class="detail-table">
							<thead>
								<tr>
									<th>제품명</th>
									<th>단가</th>
									<th>수량</th>
									<th>총금액</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="product" items="${infoSalesDetails}">
									<tr>
										<td>${product.product_name}</td>
										<td>${product.price}</td>
										<td>${product.quantity}</td>
										<td><fmt:formatNumber value="${product.totalPrice}" type="number" pattern="#,###" /></td>
										<td>${product.status}</td>
									</tr>
								</c:forEach>
							</tbody>
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
			<%@ include file="../footer1.jsp"%>
		</div>
	</div>
	<!-- jQuery (항상 가장 먼저 로드) -->
	<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

	<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
	<script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

	<!-- Core plugin (jQuery Easing 등) -->
	<script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

	<!-- Custom scripts -->
	<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>
</body>

</html>