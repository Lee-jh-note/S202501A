<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수주 등록</title>
<!-- 아이콘 및 CSS 스타일 -->
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/insert.css' />">
<style type="text/css">
.insert-table td {
	color: black;
}
/* 삭제 마이너스 버튼 스타일 */
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
/* 거래처명 select 필드의 너비를 80%로 설정 */
.insert-table select[name="client_no"] {
	width: 70%;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
let isDuplicateClient = false; // 중복 거래처 여부 저장

$(document).ready(function () {
    // 오늘 날짜를 매출일자(input type="date")에 기본값으로 설정
    let today = new Date().toISOString().split("T")[0];
    $("#sales_date").val(today);

    // "추가" 버튼 이벤트 리스너 추가
    $("#addRow").click(addRow);

    // 중복 확인 버튼 이벤트 리스너 추가
    $("#chkClientBtn").click(chkClient);
    
    // 사용자가 거래처 변경 시, 중복 검증 상태 초기화
    $("#client_no").change(function() {
        isDuplicateClient = false; 
    });
});

// 중복 확인 함수 (같은 거래처 같은 날짜 수주 등록 방지)
function chkClient() {
    let client_no = $("#client_no").val();
    let sales_date = $("#sales_date").val(); 
    
    if (!client_no || !sales_date) {
        alert("거래처와 매출일자를 모두 선택해주세요!");
        return;
    }

    $.ajax({
        url: "/Sales/checkDuplicateSales",
        type: "GET",
        data: { client_no: client_no, sales_date: sales_date },
        dataType: "json",
        success: function(response) {
            console.log("중복 확인 결과:", response); // 디버깅 로그 추가

            if (response.isDuplicate) {
                alert("이미 해당 거래처로 등록된 수주서가 있습니다.");
                isDuplicateClient = true; // 중복된 경우 true로 설정
            } else {
                alert("사용 가능한 거래처입니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("중복 확인 오류:", error); 
            alert("중복 확인 중 오류가 발생했습니다.");
        }
    });
}

// 품목 추가 (행 추가)
function addRow() {
    let tbody = $("#createSalesDetails tbody");
    let newRow = `
        <tr>
            <td style="width: 160px;">
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
            <td><button type="button" class="insert-gray-button" onclick="removeRow(this)">삭제</button></td>
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
        url: "/Sales/getProductPrice",
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

// 필수 입력값 검증 함수
function validateForm() {
    let title = $("#title").val().trim();
    let client_no = $("#client_no").val();
    let req_delivery_date = $("#req_delivery_date").val();
    let sales_date = $("#sales_date").val();
    
    if (!title) {
        alert("제목을 입력해주세요.");
        $("#title").focus();
        return false;
    }

    if (!client_no) {
        alert("거래처를 선택해주세요.");
        $("#client_no").focus();
        return false;
    }

    if (!req_delivery_date) {
        alert("요청 배송일을 선택해주세요.");
        $("#req_delivery_date").focus();
        return false;
    }

    if (new Date(req_delivery_date) < new Date(sales_date)) {
        alert("요청 배송일은 매출일자 이후여야 합니다.");
        $("#req_delivery_date").focus();
        return false;
    }
    
    if (isDuplicateClient) { 
        alert("이미 등록된 거래처입니다. 다른 거래처를 선택해주세요.");
        return false;
    }

    let hasProduct = false;
    let allValid = true;
    let productSet = new Set(); // 중복 품목 검사용

    $("#createSalesDetails tbody tr").each(function () {
        let product_no = $(this).find(".product-select").val();
        let quantity = $(this).find(".quantity").val();
        
        if (product_no) {
            if (productSet.has(product_no)) {
                alert("동일한 품목이 중복되었습니다.");
                $(this).find(".product-select").focus();
                allValid = false;
                return false;
            }
            productSet.add(product_no);
            hasProduct = true;

            if (!quantity || parseInt(quantity) < 1) {
                alert("수량은 1개 이상 입력해야 합니다.");
                $(this).find(".quantity").focus();
                allValid = false;
                return false;
            }
        }
    });

    if (!hasProduct) {
        alert("최소 하나 이상의 품목을 추가해주세요.");
        return false;
    }

    return allValid;
}

// AJAX 수주서 등록
function submitForm(event) {
    event.preventDefault();
    
    // 폼 검증 실행
    if (!validateForm()) return;

    let salesData = {
        title: $("#title").val().trim(),
        sales_date: $("#sales_date").val(),
        emp_no: $("#emp_no").val(),
        req_delivery_date: $("#req_delivery_date").val(),
        client_no: $("#client_no").val(),
        remarks: ($("#remarks").val() || "").trim(),
        productList: []
    };   
    
    // 각 품목 행에서 데이터 추출
    $("#createSalesDetails tbody tr").each(function () {
        let product = {
            product_no: $(this).find(".product-select").val(),
            price: $(this).find(".price").val(),
            quantity: $(this).find(".quantity").val(),
       };
        salesData.productList.push(product);
    });
    
    // 전송할 데이터 콘솔 출력 
    console.log("전송 데이터:", JSON.stringify(salesData));
    
    // AJAX를 통해 수주서 등록 요청 전송
    $.ajax({
        url: "/Sales/createSales",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(salesData),
        success: function () {
            alert("수주서가 등록되었습니다");
            window.location.href = "/All/Sales/listSales";
        },
        error: function (xhr, status, error) {
            alert("수주서 등록이 실패하였습니다: " + error);
        }
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
				<!-- 전체 div -->
				<div class="insert-wrapper">
					<!-- 서브메뉴랑 버튼 들어있는 헤더 -->
					<!-- onsubmit 이벤트로 AJAX 전송 함수 호출 -->
					<form id="createSales" onsubmit="submitForm(event)">
						<div class="insert-header">
							<div>
								<div class="insert-submenu">발주/수주 관리 > 수주 등록</div>
								<div class="insert-title">
									<div></div>
									<h1>수주 등록</h1>
								</div>
							</div>
							
						<!-- 버튼 -->
							<div class="insert-buttons">
								<button type="button" class="insert-empty-button" onclick="location.href='/All/Sales/listSales'">취소</button>
								<button type="submit" class="insert-full-button">등록</button>
							</div>
						</div>

						<div class="insert-header-content">
							<!-- 수주 정보 테이블 -->
							<table class="insert-table">
								<tr>
									<th>제목</th>
									<td colspan="3"><input type="text" id="title" name="title" required="required" placeholder="수주_YYYYMMDD_거래처"></td>
								</tr>
								<tr>
									<th>매출일자</th>
									<td><input type="date" id="sales_date" name="sales_date" required="required" readOnly></td>
									<th>담당자</th>
									<td><input type="hidden" id="emp_no" name="emp_no" value="${emp_no }">${emp_name}</td>
								</tr>
								<tr>
									<th>요청배송일</th>
									<td><input type="date" id="req_delivery_date" name="req_delivery_date"></td>
									<th>거래처명</th>
									<td><select id="client_no" name="client_no" required>
											<option value="">-- 선택 --</option>
											<c:forEach var="client" items="${clientList}">
												<option value="${client.client_no}">${client.client_name}</option>
											</c:forEach>
									</select> 
									<!-- 중복 확인 버튼에 id 추가하여 jQuery 이벤트 바인딩 활용 --> 
									<input type="button" class="insert-gray-button" value="중복확인" onclick="chkClient()"></td>
								</tr>
								<tr>
									<th>비고</th>
									<td colspan="3"><textarea id="remarks" name="remarks" rows="4" cols="50">${sales.remarks}</textarea></td>
								</tr>
							</table>

							<!-- 품목 정보 헤더 + '추가' 버튼 -->
							<div class="product-header">
								<div class="product-title">품목 정보</div>
								<button type="button" class="insert-gray-button" id="addRow">+ 추가</button>
							</div>

							<!-- 품목 정보 테이블 -->
							<table class="insert-table" id="createSalesDetails">
								<thead>
									<tr>
										<th>품목명</th>
										<th>단가</th>
										<th>수량</th>
										<th>총금액</th>
										<th style="width: 58px;">삭제</th>
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
										<td><input type="text" name="totalPrice" class="totalPrice" readonly></td>
										<td><button type="button" class="insert-gray-button" onclick="removeRow(this)">삭제</button></td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
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