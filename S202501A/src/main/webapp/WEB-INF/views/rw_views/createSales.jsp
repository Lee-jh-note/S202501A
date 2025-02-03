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

button {
	cursor: pointer;
	margin-bottom: 10px;
}
/* 삭제버튼-동그랗게 수정예정 */
.minus-btn {
	background-color: red;
	color: white;
	border: none;
	padding: 5px 10px;
	cursor: pointer;
	font-weight: bold;
}
</style>

<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function () {
/*     // 오늘 날짜 가져오기 (YYYY-MM-DD 형식) 서버의 LocalData를 가져오려했으나 에러->DB의 sysdate로 바꿈
    let today = new Date().toISOString().split("T")[0];
    // 매출일자 입력 필드의 기본값을 오늘 날짜로 설정
    $("#sales_Date").val(today);
}); */
function insertTitle() {
    let clientName = $("#client_Name option:selected").text(); // 선택된 거래처명
    if (clientName === "-- 선택 --") clientName = ""; // 선택 안 했으면 빈 값

    $("#title").val(`수주_${date}_${clientName}`);
}
// 품목 추가 (행 추가)
function addRow() {
    let newRow = `
        <tr>
            <td>
                <select name="product_Name" class="product-select" required onchange="getPrice(this)">
                    <option value="">-- 선택 --</option>
                    <c:forEach var="product" items="${productList}">
                        <option value="${product.product_Name}" data-price="${product.price}">${product.product_Name}</option>
                    </c:forEach>
                </select>
            </td>
            <td><input type="text" name="price" class="price" readonly></td>
            <td><input type="number" name="quantity" class="quantity" required min="1" oninput="calculateTotal(this)"></td>
            <td><input type="text" name="totalPrice" class="totalPrice" readonly></td>
            <td><button type="button" class="minus-btn" onclick="removeRow(this)">-</button></td>
        </tr>
    `;
    $("#salesProductTable tbody").append(newRow);
}

// 품목 삭제 (행 삭제)
function removeRow(button) {
    $(button).closest("tr").remove();
}

/* // 품목 선택 시 단가 자동 설정(data-price로 불러오는 방식->실시간 업뎃 단가를 불러오기 힘듦->AJAX로 수정)
function getPrice(select) {
    let selectedOption = select.options[select.selectedIndex];

    // 선택하지 않았으면 그냥 종료 (alert X)
    if (!selectedOption || !selectedOption.value) {
        return;
    }

    let price = selectedOption.getAttribute("data-price") || 0;
    let row = $(select).closest("tr");

    // 동일한 품목이 이미 선택된 경우 방지 (경고띄워서 취소하도록)
    let duplicateCount = 0;
    $(".product-select").each(function () {
        if ($(this).val() === selectedOption.value) {
            duplicateCount++;
        }
    });

    if (duplicateCount > 1) {
        alert("이미 선택한 품목입니다. 다른 품목을 선택해주세요!");
        $(select).val(""); // 선택 취소
        return;
    }

    row.find(".price").val(price);
    calculateTotal(row.find(".quantity")[0]); // 총금액 업데이트
} */


	//품목 선택 시 단가 자동 설정 (AJAX)
 function getProductPrice(pProduct_no, selectElement) {

   $.ajax(
      {
         url:"<%=request.getContextPath()%>/getProductPrice",
         data: {product_no : pProduct_no},
         dataType: "json",
         success:function(productPrice){

            console.log("Product Price: ", productPrice);
            
            const parentRow = $(selectElement).closest('tr');
               parentRow.find('.productPrice').val(productPrice);
            
            // 총금액 업데이트
            calculateTotal(parentRow);
         }
      });
}


//수량 입력값 검증 (0 이하일 경우 자동으로 1로 변경)
function validateQuantity(input) {
    if (input.value <= 0 || input.value === "") {
        alert("수량은 1 이상 입력해야 합니다.");
        input.value = 1;
    }
}

// 총 금액 계산
function calculateTotal(input) {
    let row = $(input).closest("tr");
    let price = parseFloat(row.find(".price").val()) || 0;
    let quantity = parseFloat(row.find(".quantity").val()) || 0;
    let totalPrice = price * quantity;
    row.find(".totalPrice").val(totalPrice ? totalPrice.toLocaleString() : "0");
}

// AJAX를 이용한 수주서 등록
function submitForm(event) {
    event.preventDefault();

    let isValid = true;
    let salesData = {
        title: $("#title").val().trim(),
        salesDate: $("#sales_Date").val(),
        emp_Name: $("#emp_Name").val(),
        client_Name: $("#client_Name").val(),
        remarks: $("#remarks").val().trim(), // 비고는 필수 아님
        productList: []
    };

    // 필수 입력 값 검사(요청배송일도 값이 들어가야되긴 한데 검사할지말지 보류)
    if (!salesData.title) {
        alert("제목을 입력해주세요!");
        $("#title").focus();
        return;
    }

    if (!salesData.salesDate) {
        alert("매출일자를 선택해주세요!");
        $("#sales_Date").focus();
        return;
    }

    if (!salesData.client_Name) {
        alert("거래처를 선택해주세요!");
        $("#client_Name").focus();
        return;
    }

/*     if (!salesData.req_Delivery_Date) {
        alert("요청 배송일을 선택해주세요!");
        $("#req_Delivery_Date").focus();
        return;
    } */


    // 품목 및 수량 필수 검사
    let hasValidProduct = false; // 최소 1개 이상의 품목이 있는지 확인
    $("#salesProductTable tbody tr").each(function () {
        let productName = $(this).find(".product-select").val();
        let quantity = $(this).find(".quantity").val();

        if (!productName) {
            $(this).remove(); // 빈 행 자동 삭제
            return;
        }

        if (!quantity || quantity <= 0) {
            alert("모든 품목의 수량을 입력해주세요!");
            $(this).find(".quantity").focus();
            isValid = false;
            return false; // each문 중단
        }

        let product = {
            product_Name: productName,
            price: $(this).find(".price").val(),
            quantity: quantity,
            totalPrice: $(this).find(".totalPrice").val()
        };
        salesData.productList.push(product);
        hasValidProduct = true;
    });

    // 하나도 유효한 품목이 없으면 등록 불가
    if (!hasValidProduct) {
        alert("최소 하나 이상의 품목을 추가해주세요!");
        return;
    }

    if (!isValid) return;
    

    // AJAX 요청
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
		<form id="createSalesForm" onsubmit="submitForm(event)">

			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title" required></td>
				</tr>
				<tr>
<!-- 					<th>매출일자</th>
					<td><input type="date" class="sales_Date" name="sales_Date"
						readonly></td> LocalDate 쓰는 경우-->
					<th>매출일자</th>
					<td><input type="date" class="sales_Date" name="sales_Date"
						required></td>
				</tr>
				<tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" id="emp_Name" name="emp_Name"
						value="${sessionScope.loggedInUser}" readonly></td>
				</tr>
				<tr>
					<th>요청배송일</th>
					<td><input type="date" id="req_Delivery_Date"
						name="req_Delivery_Date"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><select id="client_Name" name="client_Name" required>
							<option value="">-- 선택 --</option>
							<c:forEach var="client" items="${clientList}">
								<option value="${client.client_Name}">${client.client_Name}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>비고</th>
					<td><textarea name="remarks" rows="4" cols="50">${sales.remarks}</textarea></td>
				</tr>
			</table>

			<!-- 품목 추가 버튼 -->
			<button type="button" onclick="addRow()">+ 추가</button>

			<table id="salesProductTable">
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
						<td><select name="product_Name" class="product-select"
							required onchange="getPrice(this)">
								<option value="">-- 선택 --</option>
								<c:forEach var="product" items="${productList}">
									<option value="${product.product_Name}"
										data-price="${product.price}">${product.product_Name}</option>
								</c:forEach>
						</select></td>
						<td><input type="text" name="price" class="price" readonly></td>
						<td><input type="number" name="quantity" class="quantity"
							required oninput="calculateTotal(this)"></td>
						<td><input type="text" name="totalPrice" class="totalPrice"
							readonly></td>
						<td><button type="button" class="minus-btn"
								onclick="removeRow(this)">-</button></td>
					</tr>
				</tbody>
			</table>
			<button type="submit">수주서 등록</button>
			<button type="button" onclick="location.href='/listSales'">취소</button>
		</form>
	</div>
</body>
</html>
