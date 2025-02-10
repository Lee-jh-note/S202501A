<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수주 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.bb { width: 180px; }
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
th { background-color: #f2f2f2; }
button {
	cursor: pointer;
	margin-bottom: 10px;
}
.minus-btn {
	width: 24px;
	height: 24px;
	background-color: red;
	border: none;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	position: relative;
	margin: auto;
}
.minus-btn::before {
	content: "";
	width: 60%;
	height: 3px;
	background-color: white;
	position: absolute;
	border-radius: 2px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    // 처리 상태가 '대기'가 아니면 수정 불가능하도록 설정
    let status = "${infoSales.status}".trim();
    if (status && parseInt(status, 10) !== 0) { 
        $("input, select, textarea, button").prop("disabled", true);
        alert("처리 상태가 '대기'일 경우에만 수정할 수 있습니다.");
    }

    // 기존 품목 정보 테이블에 추가
    loadExistingProducts();
});

// 기존 품목 목록을 테이블에 추가
function loadExistingProducts() {
    let tableBody = $("#updateSalesDetails tbody");

    <c:forEach var="product" items="${infoSalesDetails}">
    let row = `
        <tr>
            <td>
                <select name="product_no" class="productSelect" required onchange="getProductPrice(this)">
                    <c:forEach var="prod" items="${productList}">
                        <option value="${prod.product_no}" <c:if test="${prod.product_no == product.product_no}">selected</c:if>>${prod.product_name}</option>
                    </c:forEach>
                </select>
            </td>
            <td><input type="text" name="price" class="productPrice" value="${product.price}" readonly></td>
            <td><input type="number" name="quantity" class="quantity" value="${product.quantity}" required min="1" oninput="calculateTotal(this)"></td>
            <td><input type="text" name="totalPrice" class="totalPrice" value="<fmt:formatNumber value='${product.totalPrice}' pattern='#,###'/>" readonly></td>
            <td><button type="button" class="minus-btn" onclick="removeRow(this)">-</button></td>
        </tr>
    `;
    tableBody.append(row);
    </c:forEach>
}

// 품목 추가 (행 추가)
function addRow() {
    let tbody = $("#updateSalesDetails tbody");
    let newRow = `
        <tr>
            <td>
                <select name="product_name" class="product-select" required onchange="getProductPrice(this)">
                    <option value="">-- 선택 --</option>
                    <c:forEach var="product" items="${productList}">
                        <option value="${product.product_no}">${product.product_name}</option>
                    </c:forEach>
                </select>
            </td>
            <td><input type="text" name="price" class="price" readonly></td>
            <td><input type="number" name="quantity" class="quantity" required min="1" oninput="calculateTotal(this)"></td>
            <td><input type="text" name="totalPrice" class="totalPrice" readonly></td>
            <td><button type="button" class="minus-btn" onclick="removeRow(this)">-</button></td>
        </tr>`;
    tbody.append(newRow);
}

// 품목 삭제 (행 삭제)
function removeRow(button) {
    $(button).closest("tr").remove();
}

//품목 선택 시 단가 자동 설정 (AJAX)
function getProductPrice(selectElement) {
    let productNo = selectElement.value;
    if (!productNo) return;

    $.ajax({
        url: "/getProductPrice",
        type: "GET",
        data: { product_no: productNo },
        dataType: "json",
        success: function(productPrice) {
            let row = $(selectElement).closest('tr');
            row.find('.price').val(productPrice);
            // 단가 업데이트 후 총 금액 재계산
            calculateTotal(row.find(".quantity")[0]);
        },
        error: function(xhr, status, error) {
            alert("단가를 가져오는 데 실패했습니다.");
        }
    });
}

// 총 금액 계산
function calculateTotal(input) {
    let row = $(input).closest("tr");
    let price = parseFloat(row.find(".price").val()) || 0;
    let quantity = parseFloat(row.find(".quantity").val()) || 0;
    let totalPrice = price * quantity;
    row.find(".totalPrice").val(totalPrice ? totalPrice.toLocaleString() : "0");
}

// AJAX 수주 수정
function submitForm(event) {
    event.preventDefault();

    let salesData = {
      //  sales_date: "${infoSales.sales_date}",
      //  client_no: "${infoSales.client_no}",
        title: $("#title").val().trim(),
        req_delivery_date: $("#req_delivery_date").val(),
        remarks: $("#remarks").val().trim(),
        salesDetails: []
    };

    // 필수 입력 값 검사
    if (!salesData.title) {
        alert("제목을 입력해주세요!");
        $("#title").focus();
        return;
    }

    let hasValidProduct = false;
    $("#updateSalesDetails tbody tr").each(function () {
        let productNo = $(this).find(".productSelect").val();
        let quantity = $(this).find(".quantity").val();

        if (!productNo) {
            alert("품목을 선택해주세요!");
            return false;
        }
        if (!quantity || quantity <= 0) {
            alert("수량을 입력해주세요!");
            return false;
        }

        let product = {
            product_no: productNo,
            price: $(this).find(".productPrice").val(),
            quantity: quantity,
        };
        salesData.salesDetails.push(product);
        hasValidProduct = true;
    });

    if (!hasValidProduct) {
        alert("최소 하나 이상의 품목을 추가해주세요!");
        return;
    }

    if (confirm("정말 수정하시겠습니까?")) {
        $.ajax({
            url: "/updateSales",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(salesData),
            success: function () {
                alert("수주 수정 성공!");
                window.location.href = "/infoSales?sales_date=" + salesData.sales_date + "&client_no=" + salesData.client_no;
            },
            error: function (xhr, status, error) {
                alert("수주 수정 실패: " + error);
            }
        });
    }
}
</script>
</head>
<body>
    <div class="bb"></div>
    <div>
        <h1>수주 수정</h1>
        <!-- onsubmit 이벤트로 AJAX 전송 함수 호출 -->
        <form id="updateSales" onsubmit="submitForm(event)">
            <table>
                <tr><th>제목</th><td><input type="text" id="title" name="title" value="${infoSales.title}" required></td></tr>
                <tr><th>매출일자</th><td>${infoSales.sales_date}</td></tr>
                <tr><th>담당자</th><td>${infoSales.emp_name}</td></tr>
                <tr><th>거래처명</th><td>${infoSales.client_name}</td></tr>
                <tr><th>요청배송일</th><td><input type="date" id="req_delivery_date" name="req_delivery_date" value="${infoSales.req_delivery_date}"></td></tr>
                <tr><th>비고</th><td><textarea id="remarks" name="remarks" rows="4">${infoSales.remarks}</textarea></td></tr>
            </table>

			<!-- 품목 추가 버튼 -->
			<button type="button" id="addRow">+ 추가</button>
			
			<table id="updateSalesDetails">
				<thead>
					<tr>
						<th>품목명</th>
						<th>단가</th>
						<th>수량</th>
						<th>총금액</th>
						<th>삭제</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td><select name="product_name" class="product-select" required onchange="getProductPrice(this)">
								<option value="">-- 선택 --</option>
								<c:forEach var="product" items="${productList}">
									<option value="${product.product_no}">${product.product_name}</option>
								</c:forEach>
							</select></td>
						<td><input type="text" name="price" class="price" readonly></td>
						<td><input type="number" name="quantity" class="quantity" required oninput="calculateTotal(this)"></td>
						<td><input type="text" name="totalPrice" class="totalPrice"	readonly></td>
						<td><button type="button" class="minus-btn" onclick="removeRow(this)">-</button></td>
					</tr>
				</tbody>
			</table>
            <button type="submit">수정 완료</button>
            <button type="button" onclick="history.back()">취소</button>
        </form>
    </div>
</body>
</html>
