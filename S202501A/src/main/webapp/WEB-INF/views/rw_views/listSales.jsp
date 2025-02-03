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
<title>수주 조회</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style type="text/css">
.bb {
	width: 180px;
}

table {
	width: 100%;
	border-collapse: collapse;
    margin: 0 auto;
    margin-bottom: 20px;}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
	vertical-align: middle;
}

th {
	background-color: #f2f2f2;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 15px;
	gap: 10px;
}

button {
	padding: 8px 12px;
	cursor: pointer;
	margin-left: 5px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	display: flex;
	align-items: center;
	gap: 5px;
}

button:hover {
	background-color: #0056b3;
}

button i {
	margin-right: 5px;
}

.search-container {
	display: flex;
	gap: 10px;
	align-items: center;
	margin-bottom: 15px;
}

.search-container label {
	font-weight: bold;
}

input[type="date"], input[type="text"] {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button.search-btn {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 5px 10px;
	cursor: pointer;
	border-radius: 4px;
}

button.search-btn:hover {
	background-color: #218838;
}
</style>

<!-- 엑셀 다운로드 및 인쇄 기능 -->
<script>
function exportToExcel() {
    let table = document.getElementById("salesTable");
    let selectedRows = document.querySelectorAll(".selectRow:checked");

    if (selectedRows.length === 0) {
        alert("다운로드할 항목을 선택하세요.");
        return;
    }

    let csvContent = "\uFEFF";  
    let headerRow = [];

    table.querySelectorAll("th").forEach(th => {
        headerRow.push(th.innerText);
    });
    csvContent += headerRow.join(",") + "\n";

    selectedRows.forEach(checkbox => {
        let row = checkbox.parentNode.parentNode;
        let rowData = [];
        row.querySelectorAll("td").forEach(td => {
            rowData.push(td.innerText);
        });
        csvContent += rowData.join(",") + "\n";
    });

    let encodedUri = "data:text/csv;charset=utf-8," + encodeURIComponent(csvContent);
    let link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "sales_data.csv");
    document.body.appendChild(link);
    link.click();
}


function printSelectedRows() {
    let selectedRows = document.querySelectorAll(".selectRow:checked");
    
    if (selectedRows.length === 0) {
        alert("인쇄할 항목을 선택하세요.");
        return;
    }
    
    let printWindow = window.open("", "", "width=800,height=600");
    let printContent = "<html><head><title>인쇄</title></head><body>";
    printContent += 
        <style>
            @media print {
                /* 자동 추가되는 브라우저 제목(인쇄) 숨기기 */
                title { display: none; }
                /* 날짜 및 URL이 자동 추가되는 경우 방지 */
                @page {
                    size: auto;
                    margin: 0;
                }
                /* 인쇄 시 페이지 헤더와 푸터를 숨김 */
                body {
                    -webkit-print-color-adjust: exact;
                    print-color-adjust: exact;
                }
            }
        </style>
    ;

    printContent += "</head><body>";
    printContent += "<table border='1'><tr>";

    let headers = document.querySelectorAll("#salesTable th");
    headers.forEach(th => {
        printContent += "<th>" + th.innerText + "</th>";
    });
    printContent += "</tr>";

    selectedRows.forEach(checkbox => {
        let row = checkbox.parentNode.parentNode;
        printContent += "<tr>";
        row.querySelectorAll("td").forEach(td => {
            printContent += "<td>" + td.innerText + "</td>";
        });
        printContent += "</tr>";
    });

    printContent += "</table></body></html>";
    printWindow.document.write(printContent);
    printWindow.document.close();
    printWindow.print();
}
</script>

<!-- 날짜 기본값 (오늘) 설정 -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    let today = new Date().toISOString().split('T')[0];

    let startDateInput = document.getElementById("startDate");
    let endDateInput = document.getElementById("endDate");

    if (!startDateInput.value) {
        startDateInput.value = today;
    }
    if (!endDateInput.value) {
        endDateInput.value = today;
    }
});
</script>

</head>
<body>
	<div class="bb"></div>
	<div>
		<h1>수주 조회</h1>
		<!-- 다운로드 및 인쇄 버튼 -->
		<div class="button-container">
			<button onclick="exportToExcel()">
				<i class="fa-solid fa-file-excel"></i> 다운로드
			</button>
			<button onclick="printSelectedRows()">
				<i class="fa-solid fa-print"></i> 인쇄
			</button>
		</div>

<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new java.util.Date());
%>

<!-- 검색 기능 -->
<form action="listSales" method="get">
    <div class="search-container">
	    <label>매출일자:</label> 
	    <input type="date" id="startDate" name="startDate" value="${sales.startDate}">
	    <span>~</span> 
	    <input type="date" id="endDate" name="endDate" value="${sales.endDate}">

	    <label>거래처명:</label> 
	    <input type="text" name="client_Name" placeholder="거래처명 입력" value="${sales.client_Name}">
	    
		<label>처리상태:</label>
		<select name="status">
		    <option value="" ${empty sales.status ? 'selected' : ''}>전체</option>
		    <option value="0" ${sales.status == '0' ? 'selected' : ''}>대기</option>
		    <option value="1" ${sales.status == '1' ? 'selected' : ''}>부분출고</option>
		    <option value="2" ${sales.status == '2' ? 'selected' : ''}>완료</option>
		</select>

        <button type="submit" class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i> 검색
        </button>
    </div>
</form>

		<div style="clear: both; height: 15px;"></div>
		<table id="salesTable">
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<!-- 전체 선택 -->
					<th>NO</th>
					<th>매출일자</th>
					<th>제목</th>
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
				<c:forEach var="sales" items="${listSales}" varStatus="status">
					<tr>
						<td><input type="checkbox" class="selectRow"></td>
						<!-- NO는 현재 반복 순서 (1부터 시작) -->
						<td>${status.index + 1}</td>
						<td>${sales.sales_Date}</td>
						<!-- 제목을 클릭하면 상세조회 페이지로 이동 -->
						<td><a href="infoSales?sales_Date=${sales.sales_Date}&client_No=${sales.client_No}">${sales.title}</a></td>
						<td>${sales.client_Name}</td>
						<td>${sales.emp_Name}</td>
						<td>${sales.count}</td>
						<td>${sales.totalQuantity}</td>
						<td><fmt:formatNumber value="${sales.totalPrice}" type="number" pattern="#,###" /></td>
						<td>${sales.status}</td>
						<td>${sales.req_Delivery_Date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- Paging -->
<c:if test="${page.totalPage > 1}">
    <div class="pagination">
        <!-- 이전 페이지 -->
        <c:if test="${page.startPage > page.pageBlock}">
            <a href="listSales?currentPage=${page.startPage - page.pageBlock}
                   &startDate=${sales.startDate.trim()}
                   &endDate=${sales.endDate.trim()}
                   &client_Name=${sales.client_Name.trim()}
                   &status=${sales.status.trim()}">
                [이전]
            </a>
        </c:if>

        <!-- 페이지 번호 -->
        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
            <a href="listSales?currentPage=${i}
                   &startDate=${sales.startDate.trim()}
                   &endDate=${sales.endDate.trim()}
                   &client_Name=${sales.client_Name.trim()}
                   &status=${sales.status.trim()}">
                [${i}]
            </a>
        </c:forEach>

        <!-- 다음 페이지 -->
        <c:if test="${page.endPage < page.totalPage}">
            <a href="listSales?currentPage=${page.startPage + page.pageBlock}
                   &startDate=${sales.startDate.trim()}
                   &endDate=${sales.endDate.trim()}
                   &client_Name=${sales.client_Name.trim()}
                   &status=${sales.status.trim()}">
                [다음]
            </a>
        </c:if>
    </div>
</c:if>



	<!-- 전체 선택 기능 추가 -->
	<script>
	document.getElementById("selectAll").addEventListener("click", function() {
	    let checkboxes = document.querySelectorAll(".selectRow");
	    checkboxes.forEach(checkbox => {
	        checkbox.checked = this.checked;
	    });
	});
	</script>
</body>
</html>