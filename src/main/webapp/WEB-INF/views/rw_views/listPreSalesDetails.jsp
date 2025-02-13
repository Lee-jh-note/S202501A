<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출고 예정 조회</title>
<!-- 엑셀 다운로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/list.css' />">

<!-- 엑셀 다운로드 및 인쇄 기능 -->
<script>
/* 전체 선택 기능 추가 */
window.onload = function () {
    let selectAllCheckbox = document.getElementById("selectAll");
    let checkboxes = document.querySelectorAll(".selectRow");

    if (selectAllCheckbox) {
        // 전체 선택 체크박스 클릭 시 모든 체크박스 상태 변경
        selectAllCheckbox.addEventListener("click", function () {
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        });
        
        // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener("change", function () {
                let allChecked = document.querySelectorAll(".selectRow:checked").length === checkboxes.length;
                selectAllCheckbox.checked = allChecked; // 모든 체크박스가 선택되었을 때만 selectAll 체크
            });
        });
    }
};

/* 엑셀 다운로드 */
function exportToExcel() {
    let table = document.getElementById("preSalesTable"); // 테이블 요소 가져오기
    let selectedRows = document.querySelectorAll(".selectRow:checked"); // 체크된 항목 가져오기

    if (selectedRows.length === 0) { // 선택된 항목이 없을 경우 경고창 표시
        alert("다운로드할 항목을 선택하세요.");
        return;
    }

    let data = []; // XLSX 변환을 위한 데이터 배열
    let headerRow = [];

    // 테이블 헤더 추출 (첫 번째 컬럼인 체크박스 제외)
    table.querySelectorAll("th").forEach((th, index) => {
        if (index > 0) { // 체크박스 컬럼 제외
            headerRow.push(th.innerText.trim()); // 헤더 추가
        }
    });
    data.push(headerRow); // 헤더 추가

    // 선택된 행 데이터 추출
    selectedRows.forEach(checkbox => {
        let row = checkbox.closest("tr"); // 체크박스가 포함된 행 가져오기
        let rowData = [];

        row.querySelectorAll("td").forEach((td, index) => {
            if (index > 0) { // 체크박스 컬럼 제외
                let cellText = td.textContent.trim();

                // 총금액처럼 쉼표가 포함된 숫자는 숫자로 변환
                if (cellText.includes(",")) {
                    cellText = cellText.replace(/,/g, ""); // 쉼표 제거
                }

                rowData.push(cellText);
            }
        });

        data.push(rowData); // 데이터 행 추가
    });

    // 워크북하고 시트
    let ws = XLSX.utils.aoa_to_sheet(data); // 배열을 엑셀 시트로 변환
    let wb = XLSX.utils.book_new(); // 새 엑셀 파일 생성
    XLSX.utils.book_append_sheet(wb, ws, "sales Data"); // 워크북에 시트 추가
    
    // 엑셀 파일 다온로드
    XLSX.writeFile(wb, "sales_data.xlsx");
}

/* 인쇄 기능 */
function printSelectedRows() {
    let selectedRows = document.querySelectorAll(".selectRow:checked"); // 체크된 항목 가져오기

    if (selectedRows.length === 0) { // 선택된 항목이 없을 경우 경고창 표시
        alert("인쇄할 항목을 선택하세요.");
        return;
    }

    let printWindow = window.open("", "", "width=800,height=600"); // 새로운 창 열기 (인쇄용)
    printWindow.document.write("<html><head><title>인쇄</title>"); // 새로운 HTML 문서 작성 시작
    printWindow.document.write("<link href='../css/list.css' rel='stylesheet' media='print'>"); // 외부 CSS 연결
    // 외부 CSS 걸어줬더니 인쇄는 제대로 나오는데 인쇄 미리보기는 제대로 안나옴
        
    printWindow.document.write("</head><body>");
    printWindow.document.write("<table class='list-table'><tr>");

    let headers = document.querySelectorAll("#preSalesTable th"); // 원본 테이블 헤더 가져오기
    headers.forEach(th => {
        printWindow.document.write("<th>" + th.innerText + "</th>"); // 헤더 추가
    });
    printWindow.document.write("</tr>");

    selectedRows.forEach(checkbox => {
        let row = checkbox.parentNode.parentNode; // 체크박스가 포함된 행 가져오기
        printWindow.document.write("<tr style='border: 1px solid #777;'>");
        row.querySelectorAll("td").forEach(td => {
            printWindow.document.write("<td style='border: 1px solid #777;'>" + td.innerText + "</td>"); // 각 열 데이터 추가
        });
        printWindow.document.write("</tr>");
    });

    printWindow.document.write("</table></body></html>"); // 테이블 종료 및 HTML 문서 닫기
    printWindow.document.close();

    // 새 창이 로드된 후 인쇄 실행
    printWindow.addEventListener('load', function() {
        printWindow.print();
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

				<div class="list-wrapper">
					<div class="list-header">
						<div>
							<div class="list-submenu">믈류 관리 > 출고 예정 조회</div>
							<div class="list-title">
								<div></div>
								<h1>출고 예정 조회</h1>
							</div>
						</div>
						<div class="list-buttons">
							<!-- 엑셀 다운로드 및 인쇄 기능 -->
							<a href="/excel/listPreSalesDetailsExcel?startDate=${param.startDate}&endDate=${param.endDate}&client_name=${param.client_name}&req_delivery_date=${param.req_delivery_date}">
								<button class="list-full-button">
									<i class="fa-solid fa-file-excel"></i> 엑셀 전체 다운로드
								</button>
							</a>
							<button class="list-full-button" onclick="exportToExcel()">
								<i class="fa-solid fa-file-excel"></i> 엑셀 선택 다운로드
							</button>

							<button id="printSelection" class="list-full-button" onclick="printSelectedRows()">
								<i class="fa-solid fa-print"></i> 인쇄
							</button>
						</div>
					</div>

					<div class="list-header2">
						<div></div>
						<!-- 검색영역을 .search-filters 로 감싸기 -->
						<div class="list-search-filters">
							<!-- 검색 필터 -->
							<form action="listPreSalesDetails" method="get" style="display: flex; gap: 10px; align-items: center;">

								<!-- 조회 기간 -->
								<label for="startDate">매출일자:</label> <input type="date" name="startDate" value="${param.startDate}"> ~ <input type="date" name="endDate" value="${param.endDate}">

								<!-- 거래처 -->
								<label>거래처:</label> <input type="text" name="client_name" value="${param.client_name}" placeholder="거래처 입력">

								<!-- 요청배송일 -->
								<label>요청배송일:</label> <input type="date" name="req_delivery_date" value="${param.req_delivery_date}">

								<!-- 검색 버튼 -->
								<button type="submit" class="list-gray-button">조회</button>
							</form>
						</div>
					</div>

					<table class="list-table" id="preSalesTable">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll"></th>
								<th>NO</th>
								<th>매출일자</th>
								<th>거래처명</th>
								<th>담당자</th>
								<th>상품수</th>
								<th>총수량</th>
								<th>총금액</th>
								<th>처리상태</th>
								<th>요청배송일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="salesDetails" items="${listPreSalesDetails}">
								<tr>
									<td><input type="checkbox" class="selectRow"></td>
									<td>${(page.total - ((page.currentPage - 1) * page.rowPage)) - status.index}</td>
									<td>${salesDetails.sales_date}</td>
									<td><a href="infoPreSalesDetails?sales_date=${salesDetails.sales_date}&client_no=${salesDetails.client_no}"> ${salesDetails.client_name} </a></td>
									<td>${salesDetails.emp_name}</td>
									<td>${salesDetails.count}</td>
									<td>${salesDetails.totalQuantity}</td>
									<td><fmt:formatNumber value="${salesDetails.totalPrice}" type="number" pattern="#,###" /></td>
									<td>${salesDetails.status}</td>
									<td>${salesDetails.req_delivery_date.substring(0,10)}</td>
								</tr>
							</c:forEach>

							<!-- 데이터가 없을 경우 -->
							<c:if test="${empty listPreSalesDetails}">
								<tr>
									<td colspan="10">출고 예정 데이터가 없습니다.</td>
								</tr>
							</c:if>

						</tbody>
					</table>

					<!-- 페이징 -->
					<div style="text-align: center; margin-top: 20px;">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="listPreSalesDetails?startDate=${param.startDate}&endDate=${param.endDate}&client_Name=${param.client_Name}&status=${param.status}&currentPage=${page.startPage - page.pageBlock}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="listPreSalesDetails?startDate=${param.startDate}&endDate=${param.endDate}&client_Name=${param.client_Name}&status=${param.status}&currentPage=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="listPreSalesDetails?startDate=${param.startDate}&endDate=${param.endDate}&client_Name=${param.client_Name}&status=${param.status}&currentPage=${page.startPage + page.pageBlock}">[다음]</a>
						</c:if>
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
