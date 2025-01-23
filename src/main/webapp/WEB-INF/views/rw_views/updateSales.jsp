<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>수주 수정</title>
<style>
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
button { cursor: pointer; }
.minus-btn {
   background-color: red; 
   color: white; 
   border: none; 
   padding: 5px 10px;
   cursor: pointer;
   font-weight: bold;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function () {
    // 처리 상태가 대기가 아닐 경우 수정 불가능
    let status = "${infoSales.status}";
    if (status !== "대기") {
        $("input, select, textarea, button").prop("disabled", true);
        alert("처리 상태가 '대기'일 경우에만 수정할 수 있습니다.");
    }
});

// 품목 추가 (행 추가)
function addRow() {
    let newRow = `
        <tr>
            <td>
                <select name="product_Name" class="product-select" required onchange="getPrice(this)">
                    <option value="">-- 선택 --</option>
                    <c:forEach var="product" items="${salesProductList}">
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

// 품목 선택 시 단가 자동 설정
/* function getPrice(select) {
    let selectedOption = select.options[select.selectedIndex];
    if (!selectedOption || !selectedOption.value) {
        return;
    }

    let price = selectedOption.getAttribute("data-price") || 0;
    let row = $(select).closest("tr");

    // 동일한 품목 중복 선택 방지
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

// 수량 입력값 검증 (0 이하일 경우 자동으로 1로 변경)
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

// 수주 수정 요청
function submitForm(event) {
    event.preventDefault();

    let salesData = {
        sales_Date: "${infoSales.sales_Date}",
        client_No: "${infoSales.client_No}",
        title: $("#title").val().trim(),
        req_Delivery_Date: $("#req_Delivery_Date").val(),
        remarks: $("#remarks").val().trim(),
        productList: []
    };

    // 필수 입력 값 검사
    if (!salesData.title) {
        alert("제목을 입력해주세요!");
        $("#title").focus();
        return;
    }

    let hasValidProduct = false;
    $("#salesProductTable tbody tr").each(function () {
        let productName = $(this).find(".product-select").val();
        let quantity = $(this).find(".quantity").val();

        if (!productName) {
            $(this).remove();
            return;
        }

        if (!quantity || quantity <= 0) {
            alert("모든 품목의 수량을 입력해주세요!");
            $(this).find(".quantity").focus();
            return false;
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
                window.location.href = "/infoSales?sales_Date=" + salesData.sales_Date + "&client_No=" + salesData.client_No;
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
        <form id="updateSalesForm" onsubmit="submitForm(event)">
            <table>
                <tr><th>제목</th><td><input type="text" id="title" name="title" value="${infoSales.title}" required></td></tr>
                <tr><th>매출일자</th><td>${infoSales.sales_Date}</td></tr>
                <tr><th>담당자</th><td>${infoSales.emp_Name}</td></tr>
                <tr><th>거래처명</th><td>${infoSales.client_Name}</td></tr>
                <tr><th>요청배송일</th><td><input type="date" id="req_Delivery_Date" name="req_Delivery_Date" value="${infoSales.req_Delivery_Date}"></td></tr>
                <tr><th>비고</th><td><textarea id="remarks" name="remarks" rows="4">${infoSales.remarks}</textarea></td></tr>
            </table>

            <button type="button" onclick="addRow()">+ 추가</button>
            <table id="salesProductTable"></table>

            <button type="submit">수정 완료</button>
            <button type="button" onclick="history.back()">취소</button>
        </form>
    </div>
</body>
</html>
