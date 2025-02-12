<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수주 수정</title>
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
<script type="text/javascript">
$(document).ready(function () {
/*     // 처리 상태가 '대기' (0)일 때만 수정 가능
    let status = "${infoSales.status}".trim();
    if (status && parseInt(status, 10) !== 0) { 
        $("input, select, textarea, button").prop("disabled", true);
        alert("처리 상태가 '대기'일 경우에만 수정할 수 있습니다.");
    } */
    
    // 기존 품목 목록 추가 
    <c:forEach var="details" items="${infoSalesDetails}" varStatus="st">
       var newRow = `
            <tr>
                <td>
                    <select name="product_no" class="productSelect" onchange="getProductPrice(this)" required>
                        <option value="">-- 선택 --</option>
                        <c:forEach var="product" items="${productList}">
                           <option value="${product.product_no}" <c:if test="${details.product_no == product.product_no}">selected="selected"</c:if>>
                              ${product.product_name}
                           </option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <input type="text" name="price" class="productPrice" placeholder="단가" value="${details.price}" readonly>
                </td>
                <td>
                    <input type="number" name="quantity" class="quantity" placeholder="수량" value="${details.quantity}" required min="1" oninput="calculateTotal(this)">
                </td>
                <td>
                    <input type="text" name="totalPrice" class="totalPrice" placeholder="총 금액" value="${details.totalPrice}" readonly>
                </td>
                <td>
                    <button type="button" class="minus-btn" onclick="removeRow(this)">-</button>
                </td>
            </tr>
       `;
       $("#productRows").append(newRow);
    </c:forEach>
    
    // 동적 행의 이벤트 바인딩 (선택 변경, 수량 입력 등)
    $(document).on('change', '.productSelect', function() {
        getProductPrice(this);
    });
    $(document).on('input', '.quantity', function() {
        calculateTotal(this);
    });
    
    // "추가" 버튼 클릭 시 새 행 추가
    $("#addRow").click(function () {
        addRow();
    });
});

// 새 행 추가 함수
function addRow() {
    var newRow = `
        <tr>
            <td>
                <select name="product_no" class="productSelect" onchange="getProductPrice(this)" required>
                    <option value="">-- 선택 --</option>
                    <c:forEach var="product" items="${productList}">
                        <option value="${product.product_no}">${product.product_name}</option>
                    </c:forEach>
                </select>
            </td>
            <td><input type="text" name="price" class="productPrice" placeholder="단가" readonly></td>
            <td><input type="number" name="quantity" class="quantity" placeholder="수량" required min="1" oninput="calculateTotal(this)"></td>
            <td><input type="text" name="totalPrice" class="totalPrice" placeholder="총 금액" readonly></td>
            <td><button type="button" class="minus-btn" onclick="removeRow(this)">-</button></td>
        </tr>
    `;
    $("#productRows").append(newRow);
}

// 행 삭제 함수
function removeRow(button) {
    $(button).closest("tr").remove();
}

// 품목 선택 시 단가를 AJAX로 받아오기
function getProductPrice(selectElement) {
    var productNo = selectElement.value;
    if (!productNo) return;
    $.ajax({
        url: "/sales/getProductPrice",
        type: "GET",
        data: { product_no: productNo },
        dataType: "json",
        success: function(productPrice) {
            var row = $(selectElement).closest('tr');
            row.find('.productPrice').val(productPrice);
            calculateTotal(row.find(".quantity")[0]);
        },
        error: function(xhr, status, error) {
            alert("단가를 가져오는 데 실패했습니다.");
        }
    });
}

// 총 금액 계산 함수
function calculateTotal(input) {
    var row = $(input).closest("tr");
    var price = parseFloat(row.find(".productPrice").val()) || 0;
    var quantity = parseFloat(row.find(".quantity").val()) || 0;
    var totalPrice = price * quantity;
    row.find(".totalPrice").val(totalPrice ? totalPrice.toLocaleString() : "0");
}

// AJAX를 통한 수주 수정 전송
function submitForm(event) {
    event.preventDefault();
    
    var salesData = {
        sales_date: "${infoSales.sales_date}",
        client_no: "${infoSales.client_no}",
        title: $("#title").val().trim(),
        req_delivery_date: $("#req_delivery_date").val(),
        remarks: $("#remarks").val().trim(),
        productList: []
    };
    
    $("#productRows tr").each(function () {
        var product = {
            product_no: $(this).find(".productSelect").val(),
            price: $(this).find(".productPrice").val(),
            quantity: $(this).find(".quantity").val()
        };
        salesData.productList.push(product);
    });
    
    if (confirm("정말 수정하시겠습니까?")) {
        $.ajax({
            url: "/sales/updateSales",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(salesData),
            success: function () {
                alert("수주 수정 성공!");
                window.location.href = "/sales/listSales";
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
        <form id="updateSales" onsubmit="submitForm(event)">
            <table>
                <tr>
                    <th>제목</th>
                    <td><input type="text" id="title" name="title" value="${infoSales.title}" required></td>
                </tr>
                <tr>
                    <th>매출일자</th>
                    <td>${infoSales.sales_date}</td>
                </tr>
                <tr>
                    <th>담당자</th>
                    <td>${infoSales.emp_name}</td>
                </tr>
                <tr>
                    <th>거래처명</th>
                    <td>${infoSales.client_name}</td>
                </tr>
                <tr>
                    <th>요청배송일</th>
                    <td><input type="date" id="req_delivery_date" name="req_delivery_date" value="${infoSales.req_delivery_date}"></td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td><textarea id="remarks" name="remarks" rows="4">${infoSales.remarks}</textarea></td>
                </tr>
            </table>
            
            <!-- 품목 추가 버튼 -->
            <button type="button" id="addRow">+ 추가</button>
            
            <!-- 품목 정보 테이블 -->
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
                <tbody id="productRows">
                    <!-- 기존 품목 목록 여기 추가 -->
                </tbody>
            </table>
            <button type="submit">수정 완료</button>
            <button type="button" onclick="history.back()">취소</button>
        </form>
    </div>
</body>
</html>
