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
<title>수주 등록</title>
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
    // 오늘 날짜를 매출일자(input type="date")에 기본값으로 설정
    let today = new Date().toISOString().split("T")[0];
    $("#sales_date").val(today);

    // "추가" 버튼 이벤트 리스너 추가
    $("#addRow").click(addRow);

    // 중복 확인 버튼 이벤트 리스너 추가
    $("#chkClientBtn").click(chkClient);
});

// 중복 확인 함수
function chkClient() {
    let client_no = $("#client_no").val();
    let sales_date = $("#sales_date").val(); 
    
    if (!client_no || !sales_date) {
        alert("거래처와 매출일자를 모두 선택해주세요!");
        return;
    }

    $.ajax({
        url: "/checkDuplicateSales",
        type: "GET",
        data: { client_no: client_no, sales_date: sales_date },
        dataType: "json",
        success: function(response) {
            console.log("중복 확인 결과:", response); // 디버깅 로그 추가

            if (response.isDuplicate) {
                alert("이미 해당 거래처로 등록된 수주서가 있습니다.");
            } else {
                alert("사용 가능한 거래처입니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("중복 확인 오류:", error); // 디버깅 로그 추가

            alert("중복 확인 중 오류가 발생했습니다.");
        }
    });
}

// 품목 추가 (행 추가)
function addRow() {
    let tbody = $("#createSalesDetails tbody");
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

// 품목 선택 시 단가 자동 설정 (AJAX)
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

//  AJAX 수주서 등록
function submitForm(event) {
    event.preventDefault();

    let salesData = {
        title: $("#title").val().trim(),
        salesDate: $("#sales_date").val(),
        emp_no: $("#emp_name").val(),
        req_delivery_date: $("#req_delivery_date").val(),
        client_no: $("#client_no").val(),
        remarks: ($("#remarks").val() || "").trim(),
        productList: []
    };
    
    // 필수 항목 확인
    if (!salesData.title || !salesData.client_no) {
        alert("필수 항목을 입력해주세요!");
        return;
    }
    
    // 각 품목 행에서 데이터 추출
    $("#createSalesDetails tbody tr").each(function () {
        let product = {
            product_no: $(this).find(".product-select").val(),
            price: $(this).find(".price").val(),
            quantity: $(this).find(".quantity").val(),
       };
        salesData.productList.push(product);
    });

    if (salesData.productList.length === 0) {
        alert("최소 하나 이상의 품목을 추가해주세요!");
        return;
    }
    
    // 전송할 데이터 콘솔 출력 
    console.log("전송 데이터:", JSON.stringify(salesData));
    
    // AJAX를 통해 수주서 등록 요청 전송
    $.ajax({
        url: "/createSales",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(salesData),
        success: function () {
            alert("수주서 등록 성공!");
            window.location.href = "/listSales";
        },
        error: function (xhr, status, error) {
            alert("수주서 등록 실패: " + error);
        }
    });
}
</script>

</head>
<body>
	<div class="bb"></div>
	<div>
		<h1>수주 등록</h1>
		<!-- onsubmit 이벤트로 AJAX 전송 함수 호출 -->
		<form id="createSales" onsubmit="submitForm(event)">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title" required="required" placeholder="수주_YYYYMMDD_거래처"></td>
				</tr>
				<tr>
					<th>매출일자</th>
					<td><input type="date" id="sales_date" name="sales_date" required="required" readOnly></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><select id="emp_name" name="emp_name" required>
							<option value="">-- 선택 --</option>
							<c:forEach var="emp" items="${empList}">
								<option value="${emp.emp_no}">${emp.emp_name}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>요청배송일</th>
					<td><input type="date" id="req_delivery_date" name="req_delivery_date"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><select id="client_no" name="client_no" required>
							<option value="">-- 선택 --</option>
							<c:forEach var="client" items="${clientList}">
								<option value="${client.client_no}">${client.client_name}</option>
							</c:forEach>
						</select> 
						<!-- 중복 확인 버튼에 id 추가하여 jQuery 이벤트 바인딩 활용 -->
						<input type="button" value="중복확인" onclick="chkClient()"></td>
				</tr>
				<tr>
					<th>비고</th>
					<td><textarea id="remarks" name="remarks" rows="4" cols="50">${sales.remarks}</textarea></td>
				</tr>
			</table>

			<!-- 품목 추가 버튼 -->
			<button type="button" id="addRow">+ 추가</button>
			
			<table id="createSalesDetails">
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
			<button type="submit">수주서 등록</button>
			<button type="button" onclick="location.href='/listSales'">취소</button>

		</form>
	</div>
</body>
</html>
