<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입고 예정 리스트</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
	<style>
		body {
			font-family: 'Inter', sans-serif;
			margin: 0;
			padding: 0;
			background-color: white;
		}

		/* 전체 div */
		.wrapper {
			width: 90%;
			max-width: 1200px;
			margin: 20px auto;
			padding: 20px;
		}

		/* 서브메뉴랑 버튼 들어있는 헤더 */
		.header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding-bottom: 5px;
		}

		/* 조회기간 헤더 */
		.header2 {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding-bottom: 5px;
		}

		.submenu {
			font-size: 12px;
			color: #AAAAAA;
			margin-bottom: 10px;
		}

		.title {
			display: flex;
			align-items: center;
			gap: 10px;
			margin-bottom: 20px;
		}

		.title div {
			width: 4px;
			height: 32px;
			background-color: #1E1E1E;
		}

		.title h1 {
			font-size: 16px;
			color: black;
			margin: 0;
		}

		.buttons {
			display: flex;
			gap: 10px;
		}

		.full-button{
			padding: 8px 12px;
			font-size: 12px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			background-color: #4e73df;
			color: white;
		}

		.search-filters {
			display: flex;
			gap: 10px;
			align-items: center;
			/* 검색 아래 여백 */
		}

		/* 검색 버튼 */
		.gray-button {
			background-color: #898c89;
			color: white;
			border: none;
			padding: 8px 12px;
			border-radius: 4px;
			font-size: 12px;
			cursor: pointer;
		}

		.search-filters input[type="date"],
		.search-filters input[type="text"],
		.search-filters select {
			padding: 3px 8px;
			font-size: 12px;
			height: 30px;
			border: 1px solid #ddd;
			border-radius: 4px;
		}

		.search-filters label {
			font-size: 12px;
		}


		.table {
			width: 100%;
			border-collapse: collapse;
			margin-top: 10px;
		}

		.table th,
		.table td {
			border: 1px solid #EEEEEE;
			padding: 10px;
			text-align: center;
		}

		.table th {
			background-color: #F8F8F8;
			color: #777;
			font-size: 12px;
			font-weight: 400;
		}

		.table td {
			font-size: 12px;
			color: black;
		}
	</style>
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>

            <div class="wrapper">
                <div class="header">
                    <div>
                        <div class="submenu">물류 관리 > 입고 예정 리스트</div>
                        <div class="title">
                            <div></div>
                            <h1>입고 예정 리스트</h1>
                        </div>
                    </div>
                    <div class="buttons">
                        <a href="/excel/purchaseDetailPlanExcel?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&req_delivery_date=${param.req_delivery_date}">
                            <button class="full-button">
                                <i class="fa-solid fa-file-excel"></i> 엑셀 다운로드
                            </button>
                        </a>
                        <button id="printSelection" class="full-button">
                            <i class="fa-solid fa-print"></i> 인쇄
                        </button>
                    </div>
                </div>
                <div class="header2">
                    <div></div>
                    <!-- 검색영역을 .search-filters 로 감싸기 -->
                    <div class="search-filters">
                        <form action="listPurchaseDetailPlan" method="get"
                              style="display: flex; gap: 10px; align-items: center;">

                            <!-- 조회 기간 -->
                            <label for="startDate">매입일자</label>
                            <input type="date" id="startDate" name="startDate" value="${searchKeyword.startDate}"/>
                            <span>~</span>

                            <input type="date" id="endDate" name="endDate" value="${searchKeyword.endDate}"/>

                            <!-- 거래처 -->
                            <label for="client_name">거래처</label>
                            <input type="text" id="client_name" name="client_name" value="${searchKeyword.client_name}"
                                   placeholder="거래처 입력"/>

							<!-- 요청 배송일 검색 추가 -->
							<label for="req_delivery_date">요청배송일</label>
							<input type="date" id="req_delivery_date" name="req_delivery_date"  value="${searchKeyword.req_delivery_date}"/>

                            <!-- 검색 버튼 -->
                            <button type="submit" class="gray-button">조회</button>
                        </form>
                    </div>
                </div>

                <%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>
                <c:set var="num" value="${page.start}"/>

                <table class="table">
                    <thead>
                    <tr><th >NO</th><th>매입일자</th><th>거래처명</th><th>발주 담당자</th><th>상품수</th><th>총수량</th><th>총금액</th><th>처리상태</th><th>요청배송일</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="purchase_details" items="${listPurchaseDetailPlan}">
						<tr>
							<td>${num}</td>
							<td>${purchase_details.purchase_date}</td>
									<!-- 다른점: 6. 페이지 이동 -->
							<td><a href="detailPurchaseDetailPlan?purchase_date=${purchase_details.purchase_date}&client_no=${purchase_details.client_no}">${purchase_details.client_name}</a></td>
							<td>${purchase_details.emp_name}</td>
							<td>${purchase_details.product_count}</td>
							<td>${purchase_details.total_quantity}</td>
							<td><fmt:formatNumber value="${purchase_details.total_price}" type="number" pattern="#,###" /></td>
							<td>${purchase_details.status}</td>
							<td>${purchase_details.req_delivery_date.substring(0,10)}</td>
						</tr>
						<c:set var="num" value="${num + 1}"></c:set>
					</c:forEach>
                    </tbody>
                </table>

                <div style="text-align: center; margin-top: 20px;">
                    <c:if test="${page.startPage > page.pageBlock}">
                        <a href="listPurchaseDetailPlan?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&req_delivery_date=${param.req_delivery_date}&currentPage=${page.startPage-page.pageBlock}">[이전]</a>
                    </c:if>
                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="listPurchaseDetailPlan?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&req_delivery_date=${param.req_delivery_date}&currentPage=${i}">[${i}]</a>
                    </c:forEach>
                    <c:if test="${page.endPage < page.totalPage}">
                        <a href="listPurchaseDetailPlan?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&req_delivery_date=${param.req_delivery_date}&currentPage=${page.startPage+page.pageBlock}">[다음]</a>
                    </c:if>
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
