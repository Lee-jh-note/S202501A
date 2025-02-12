<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>출고 예정 상세조회</title>
<style type="text/css">
.bb {
	width: 180px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 0 auto;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
	vertical-align: middle;
}

th {
	background-color: #f2f2f2;
}

thead th {
	text-align: center;
}

/* 라디오 버튼 */
.select {
	display: flex;
	justify-content: center;
	gap: 5px;
}

.select input[type=radio] {
	display: none;
}

.select input[type=radio]+label {
	display: inline-block;
	cursor: pointer;
	height: 24px;
	width: 80px;
	border: 1px solid #333;
	line-height: 24px;
	text-align: center;
	font-weight: bold;
	font-size: 13px;
	background-color: #fff;
	color: #333;
	transition: background-color 0.3s, color 0.3s;
}

.select input[type=radio]:checked+label {
	background-color: #333;
	color: #fff;
}

.select input[type=radio]+label:hover {
	background-color: #555;
	color: #fff;
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
    // 모달 열기 함수
    function openModal(message, onConfirm) {
        document.querySelector(".modal-message").innerHTML = message;
        document.querySelector(".modal-overlay").style.display = "block";

        // 확인 버튼 클릭 시 이벤트 처리
        const confirmButton = document.querySelector(".confirm");
        confirmButton.onclick = () => {
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

    // 출고/미출고 처리 버튼 클릭 시 모달 호출 및 폼 제출
    function handleRelease() {
        openModal("정말 출고/미출고 처리 하시겠습니까?", () => {
            document.querySelector("#releaseForm").submit();
        });
    }
</script>
</head>
<body>
	<div class="bb"></div>
	<div>
		<!-- 전체 내용 영역  -->
		<form action="/salesDetails/updateSalesStatus" method="post">
			<h1>출고 예정 상세조회</h1>

			<table>
				<tr>
					<th>매출일자</th>
					<td>${infoPreSalesDetails.sales_date}</td>
				</tr>
				<tr>
					<th>수주 담당자</th>
					<td>${infoPreSalesDetails.emp_name}</td>
				</tr>
				<tr>
					<th>출고 담당자</th>
					<td><input type="hidden" name="emp_no" value="${emp_no}"> ${emp_name}</td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td>${infoPreSalesDetails.client_name}</td>
				</tr>
			</table>

			<!-- 품목 정보 테이블 -->
			<table>
				<thead>
					<tr>
						<th>제품명</th>
						<th>단가</th>
						<th>수량</th>
						<th>총금액</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="salesDetails" items="${infoPreSalesDetailsList}" varStatus="status">
						<tr>

							<td>${salesDetails.product_name}</td>
							<td>${salesDetails.price}</td>
							<td>${salesDetails.quantity}</td>
							<td><fmt:formatNumber value="${salesDetails.totalPrice}" type="number" pattern="#,###" /></td>
							
							<td>
							<input type="hidden" name="sales_date" value="${infoPreSalesDetails.sales_date}"> 
							<input type="hidden" name="client_no" value="${infoPreSalesDetails.client_no}"> 
							<input type="hidden" name="product_no" value="${salesDetails.product_no}">
                            <input type="checkbox" name="checked" value="${status.index}">  
                        <%--    출고 <input type="radio" name="status" id="status${status.index}" value="2">						
                           미출고<input type="radio" name="status" id="status${status.index}" value="1">			 --%>			
 
 
 </td>
							
<%-- 							<td><select name="status" id="status${status.index}">
									<option value="1" <c:if test="${salesDetails.status == 1}">selected</c:if>>미출고</option>
									<option value="2" <c:if test="${salesDetails.status == 2}">selected</c:if>>출고</option>
							</select></td> --%>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- 버튼 영역 -->
			<div>
				<button type="button" onclick="history.back()">목록</button>
				<button type="submit">출고/미출고 처리</button>
			</div>
		</form>
	</div>
</body>
</html>
