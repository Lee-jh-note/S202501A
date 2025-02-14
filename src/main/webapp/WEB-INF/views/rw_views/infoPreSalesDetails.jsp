<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출고 예정 상세조회</title>
<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/detail.css' />">
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
    openModal("정말 출고 처리 하시겠습니까?", () => {
    	document.querySelector("#updateForm").submit(); // 폼 제출
    });
}
</script>
</head>

<body id="page-top">
	<div id="wrapper">
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>
				<!-- 전체 div -->
				<form action="/Logistics/updateSalesStatus" method="post" id="updateForm">
					<div class="detail-wrapper">
						<div class="detail-header">
							<div>
								<div class="detail-submenu">물류 관리 > 출고 예정 조회</div>
								<div class="detail-title">
									<div></div>
									<h1>출고 예정 상세조회</h1>
								</div>
							</div>

							<!-- 버튼 영역 -->
							<div>
								<button type="button" class="detail-empty-button" onclick="history.back()">목록</button>
								<button type="button" class="detail-full-button" onclick="handleStore()">출고 처리</button>
							</div>
						</div>

						<div class="detail-header-content">
							<table class="detail-table">
								<tr>
									<th>매출일자</th><td>${infoPreSalesDetails.sales_date}</td>
								</tr>
								<tr>
									<th>수주 담당자</th><td>${infoPreSalesDetails.emp_name}</td>
								</tr>
								<tr>
									<th>출고 담당자</th><td><input type="hidden" name="emp_no" value="${emp_no}"> ${emp_name}</td>
								</tr>
								<tr>
									<th>거래처명</th><td>${infoPreSalesDetails.client_name}</td>
								</tr>
							</table>

							<!-- 품목 정보 헤더 + '추가' 버튼 -->
							<div class="product-header">
								<div class="product-title">품목 정보</div>
								<div></div>
							</div>

							<!-- 품목 정보 테이블-->
							<table class="detail-table">
								<thead>
									<tr>
										<th style="width: 40px;">선택</th>
										<th>제품명</th>
										<th>단가</th>
										<th>수량</th>
										<th>총금액</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="salesDetails" items="${infoPreSalesDetailsList}" varStatus="status">
										<tr>
											<td><input type="checkbox" name="checked" value="${status.index}"> <input type="hidden" name="sales_date" value="${salesDetails.sales_date}"> <input type="hidden"
												name="client_no" value="${salesDetails.client_no}"
											> <input type="hidden" name="product_no" value="${salesDetails.product_no}"></td>
											<td>${salesDetails.product_name}</td>
											<td>${salesDetails.price}</td>
											<td>${salesDetails.quantity}</td>
											<td><fmt:formatNumber value="${salesDetails.totalPrice}" type="number" pattern="#,###" /></td>
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
						<p class="modal-message">정말 출고 처리 하시겠습니까?</p>
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