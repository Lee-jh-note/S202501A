<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출고 상세조회</title>
<!-- 엑셀 다운로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/detail.css' />">
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
							<div class="detail-submenu">물류 관리 > 출고 조회</div>
							<div class="detail-title">
								<div></div>
								<h1>출고 상세조회</h1>
							</div>
						</div>

						<!-- 버튼 -->
						<div>
							<button type="button" class="detail-empty-button" onclick="history.back()">목록</button>
						</div>
					</div>

					<div class="detail-header-content">
						<table class="detail-table">
							<tr>
								<th>매출일자</th>
								<td>${infoGoSalesDetails.sales_date}</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td>${infoGoSalesDetails.emp_name}</td>
							</tr>
							<tr>
								<th>거래처명</th>
								<td>${infoGoSalesDetails.client_name}</td>
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
									<th>제품명</th>
									<th>단가</th>
									<th>수량</th>
									<th>총금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="salesProduct" items="${infoGoSalesDetailsList}">
									<tr>
										<td>${salesProduct.product_name}</td>
										<td>${salesProduct.price}</td>
										<td>${salesProduct.quantity}</td>
										<td><fmt:formatNumber value="${salesProduct.totalPrice}" type="number" pattern="#,###" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
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
