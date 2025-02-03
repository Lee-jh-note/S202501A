<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../ProdTest.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            display: flex;
            justify-content: space-between;
        }

        .table-small {
            width: 50%; /* 테이블 크기를 50%로 줄임 */
        }

        /* 수정 폼을 오른쪽에 위치하도록 설정 */
        .inventory-form {
            display: none;
            width: 45%; /* 폼이 테이블 크기에 맞춰서 45%로 설정 */
            margin-left: 20px; /* 폼과 테이블 사이의 간격 */
        }

        .inventory-form form {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .inventory-form h3 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>재고 목록</h2>
    <!-- 검색 폼 추가 -->
    <form action="/Inven/InvenList" method="get">
        <div class="row mb-3">
            <!-- 년월 검색 -->
            <div class="col-md-4">
                <label for="yymm" class="form-label">기준 년 월</label>
                <input type="month" id="yymm" name="yymm" class="form-control"
                       value="${type != null ? type : ''}">
            </div>
            <!-- 제품명 검색 -->
            <div class="col-md-4">
                <label for="searchProduct" class="form-label">검색할 제품명:</label>
                <input type="text" id="searchProduct" name="product_name" class="form-control"
                       placeholder="제품명 검색" value="${name != null ? name : ''}">
            </div>
            <!-- 버튼들 배치 -->
            <div class="col-md-4 d-flex justify-content-between align-items-end">
                <!-- 검색 버튼 -->
                <button type="submit" class="btn btn-primary">검색</button>

                <!-- 수기 입력 버튼 -->
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#createModal">
                    수기 입력
                </button>

                <!-- 마감 진행 버튼 -->
                <button type="button" class="btn btn-danger" onclick="confirmClosing()">마감 진행</button>

                <!-- 테이블 사이즈 변경 버튼 -->
                <button type="button" class="btn btn-warning" onclick="toggleTableSize()">재고 조정</button>
            </div>
        </div>
    </form>

    <!-- 테이블을 생성하여 재고 데이터를 표시 -->
    <div class="table-container">
        <table id="inventoryTable" class="table table-bordered">
            <thead>
            <tr>
                <th>년월</th>
                <th>대분류</th>
                <th>제품명</th>
                <th>기초재고</th>
                <th>기말재고</th>
                <th>구매가</th>
                <th>판매가</th>
                <th>재고총액</th>
                <th>최적수량</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <!-- InventoryDto 리스트를 출력 -->
            <c:forEach var="inventory" items="${list}">
                <tr>
                    <td>${inventory.yymm}</td>
                    <td>${inventory.title}</td>
                    <td>${inventory.product_name}</td>
                    <td>${inventory.beginning}</td> <!-- 기초재고 -->
                    <td>${inventory.closing}</td>   <!-- 기말재고 -->
                    <td><fmt:formatNumber value="${inventory.pur_price}" pattern="#,###"/></td> <!-- 구매가격 -->
                    <td><fmt:formatNumber value="${inventory.sale_price}" pattern="#,###"/></td> <!-- 판매가격 -->
                    <td><fmt:formatNumber value="${inventory.closing == 0 ? (inventory.beginning * inventory.pur_price)
                    : (inventory.closing * inventory.pur_price)}" pattern="#,###"/></td> <!-- 재고총액 -->
                    <td>${inventory.optimal_quantity}</td>
                    <td>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                                data-id="${inventory.product_no}" data-optimal_quantity="${inventory.optimal_quantity}">
                            최적수량 수정
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

<%--       재고조정--%>
        <div class="inventory-form" id="inventoryForm">
            <h3>재고 조정</h3>
            <form action="/Inven/QuantityModify" method="post">
                <div class="mb-3">
                    <label for="product_name" class="form-label">제품명</label>
                    <select id="product_name" name="prodNo" class="form-control" onchange="updateQuantity()">
                        <!-- prodList를 이용하여 제품명을 동적으로 표시 -->
                        <c:forEach var="product" items="${list}">
                            <option value="${product.product_no}" data-beginning="${product.beginning}"
                                    data-closing="${product.closing}">
                                    ${product.product_name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="quantity" class="form-label">현재 수량</label>
                    <input type="number" class="form-control" id="quantity" name="quantity"
                           value="${list[0].closing == 0 ? list[0].beginning : list[0].closing}"/>
                </div>

                <button type="submit" class="btn btn-primary">수정 완료</button>
            </form>
        </div>
    </div>

    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
        <a href="/Inven/InvenList?yymm=${type}&product_name=${name}&currentPage=${i}"/>[${i}]</a>
    </c:forEach>

    <!-- 최적수량 수정 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">최적수량 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/Inven/OptimalModify" method="post">
                        <input type="hidden" id="product_no" name="product_no" value=""/>
                        <div class="mb-3">
                            <label for="optimal_quantity" class="form-label">최적수량</label>
                            <input type="number" class="form-control" id="optimal_quantity" name="optimal_quantity"
                                   required/>
                        </div>
                        <button type="submit" class="btn btn-primary">수정 완료</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 재고 수기 입력 모달 -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">재고 수기 입력</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/Inven/Inven/CreateAct" method="post">
                        <div class="form-group">
                            <label for="yymm">기준 년월</label>
                            <input type="text" name="yymm" id="yymm" class="form-control"
                                   value="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM'/>"
                                   readonly>
                        </div>

                        <!-- 제품 선택 -->
                        <div class="form-group">
                            <label for="product_no">제품</label>
                            <select name="product_no" id="product_no" class="form-control" required>
                                <option value="" disabled selected>제품을 선택하세요</option>
                                <c:forEach var="product" items="${prodList}">
                                    <option value="${product.product_no}">${product.product_name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- 재고 수량 입력 -->
                        <div class="form-group">
                            <label for="quantity">재고 수량</label>
                            <input type="number" name="quantity" id="quantity" class="form-control" required>
                        </div>

                        <!-- 적정 수량 입력 -->
                        <div class="form-group">
                            <label for="optimal_quantity">적정 수량</label>
                            <input type="number" name="optimal_quantity" id="optimal_quantity" class="form-control"
                                   value="0" required>
                        </div>

                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 테이블 사이즈 조정 함수
    function toggleTableSize() {
        var table = document.getElementById('inventoryTable');
        var inventoryForm = document.getElementById('inventoryForm');

        // 테이블 크기 줄이기
        table.classList.toggle('table-small');

        // 폼 표시 여부 토글
        if (table.classList.contains('table-small')) {
            inventoryForm.style.display = 'block';
        } else {
            inventoryForm.style.display = 'none';
        }
    }

    function confirmClosing() {
        var yymm = document.getElementById("yymm").value;

        $.ajax({
            url: '/Inven/Inven/ClosingCheck',
            method: 'GET',
            data: {yymm: yymm},
            success: function (response) {
                if (response === "1") {
                    if (confirm(yymm + " 날짜로 마감을 진행하시겠습니까?")) {
                        var form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '/Inven/Inven/Closing';

                        var input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'yymm';
                        input.value = yymm;
                        form.appendChild(input);

                        document.body.appendChild(form);
                        form.submit();
                    }
                } else {
                    alert("이미 마감처리된 내역입니다.");
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: " + error);
                alert("마감 월을 선택해 주세요.");
            }
        });
    }

    // 선택된 제품에 맞는 수량을 갱신하는 함수
    function updateQuantity() {
        var select = document.getElementById('product_name');
        var selectedOption = select.options[select.selectedIndex]; // 선택된 옵션
        var beginning = selectedOption.getAttribute('data-beginning');
        var closing = selectedOption.getAttribute('data-closing');

        // 수량 필드에 시작 수량이나 기말 수량을 설정
        var quantityInput = document.getElementById('quantity');
        quantityInput.value = (closing == 0 ? beginning : closing);
    }

    // 페이지 로드 시 첫 번째 제품에 대한 수량을 설정
    window.onload = function () {
        updateQuantity(); // 처음 페이지 로드 시에도 수량을 업데이트
    }

    // 모달이 열릴 때 데이터 속성 가져오기
    $('#editModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 버튼을 클릭한 시점의 요소
        var productNo = button.data('id'); // data-id에서 product_no 값 가져오기
        var optimalQuantity = button.data('optimal_quantity'); // data-optimal_quantity에서 최적수량 값 가져오기

        // 모달 내에서 데이터를 처리
        var modal = $(this);
        modal.find('#product_no').val(productNo);  // product_no 숨겨진 input에 값 설정
        modal.find('#optimal_quantity').val(optimalQuantity);  // 최적수량 input에 값 설정
    });
</script>
</body>
</html>
