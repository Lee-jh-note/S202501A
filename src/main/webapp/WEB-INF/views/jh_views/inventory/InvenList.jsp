<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="/../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="/../css/list.css" rel="stylesheet">
    <style>
        .table-container {
            display: flex;
            justify-content: space-between;
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

        input[type="month"] {
            padding: 3px 8px;
            font-size: 12px;
            height: 30px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        #dayClosingLink:hover {
            color: white;
        }

    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menu1.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>


            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">재고 관리 > 재고 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>재고 조회</h1>
                        </div>
                    </div>

                    <div class="list-buttons">
                        <!-- 수기 입력 버튼 -->
                        <button type="button" class="btn btn-info list-full-button" data-bs-toggle="modal"
                                data-bs-target="#createModal">
                            수기 입력
                        </button>

                        <!-- 마감 진행 버튼 -->
                        <button type="button" class="btn btn-info list-full-button" onclick="confirmClosing()">마감 진행
                        </button>

                        <!-- 재고 조정 -->
                        <button type="button" class="btn btn-info list-full-button" onclick="toggleTableSize()">재고 조정
                        </button>

                    </div>
                </div>


                <div class="list-header2">
                    <div></div>
                    <!-- 검색 폼 추가 -->
                    <div class="list-search-filters">
                        <form action="/All/Logistics/InvenList" method="get"
                              style="display: flex; gap: 10px; align-items: center;">
                            <!-- 년월 검색 -->
                            <div>
                                <label for="yymm" class="">년/월</label>
                                <input type="month" id="yymm" name="yymm" class=""
                                       value="${type != null ? type : ''}">
                            </div>
                            <!-- 제품명 검색 -->
                            <div>
                                <label for="searchProduct" class="">제품명</label>
                                <input type="text" id="searchProduct" name="product_name" class=""
                                       placeholder="제품명 검색" value="${name != null ? name : ''}">
                            </div>
                            <!-- 검색 버튼 -->
                            <button type="submit" class="list-gray-button">조회</button>
                        </form>
                        <a href="javascript:void(0);" class="list-gray-button" id="dayClosingLink" style="text-decoration: none">내역 업데이트</a>
                    </div>
                </div>

                <!-- 테이블을 생성하여 재고 데이터를 표시 -->
                <div class="table-container">
                    <table id="inventoryTable" class="list-table">
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
                                <td><fmt:formatNumber value="${inventory.pur_price}" pattern="#,###"/></td>
                                <!-- 구매가격 -->
                                <td><fmt:formatNumber value="${inventory.sale_price}" pattern="#,###"/></td>
                                <!-- 판매가격 -->
                                <td><fmt:formatNumber value="${inventory.closing == 0 ? (inventory.beginning * inventory.pur_price)
                : (inventory.closing * inventory.pur_price)}" pattern="#,###"/></td> <!-- 재고총액 -->
                                <!-- 최적수량을 클릭하면 모달이 뜨게 변경 -->
                                <td>
                                    <a href="javascript:void(0)"
                                       class="optimal-quantity-link"
                                       data-bs-toggle="modal"
                                       data-bs-target="#editModal"
                                       data-id="${inventory.product_no}"
                                       data-optimal_quantity="${inventory.optimal_quantity}">
                                            ${inventory.optimal_quantity}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <%--       재고조정--%>
                    <div class="inventory-form" id="inventoryForm">
                        <h4 style="text-align: center">재고 조정</h4>
                        <form action="/Logistics/QuantityModify" method="post">
                            <div class="mb-3">
                                <label for="product_name" class="form-label">제품명</label>
                                <select id="product_name" name="prodNo" class="form-control"
                                        onchange="updateQuantity()">
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
                                <label for="quantity" class="form-label">변경 수량</label>
                                <input type="number" class="form-control" id="quantity" name="quantity"
                                       value="${list[0].closing == 0 ? list[0].beginning : list[0].closing}"/>
                            </div>

                            <button type="submit" class="btn list-full-button">수정</button>
                        </form>
                    </div>
                </div>
                <div class="text-center mt-3">

                    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                        <a href="/All/Logistics/InvenList?yymm=${type}&product_name=${name}&currentPage=${i}"/>${i}</a>
                    </c:forEach>
                </div>

                <!-- 최적수량 수정 모달 -->
                <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel">최적수량 수정</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="/Logistics/OptimalModify" method="post">
                                    <input type="hidden" id="product_no" name="product_no" value=""/>
                                    <div class="mb-3">
                                        <label for="optimal_quantity" class="form-label">최적수량</label>
                                        <input type="number" class="form-control" id="optimal_quantity"
                                               name="optimal_quantity"
                                               required/>
                                    </div>
                                    <button type="submit" class="btn list-full-button">수정</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 재고 수기 입력 모달 -->
                <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="createModalLabel">재고 수기 입력</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="/Logistics/Inven/CreateAct" method="post">
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
                                        <input type="number" name="quantity" id="quantity" class="form-control"
                                               required>
                                    </div>

                                    <!-- 적정 수량 입력 -->
                                    <div class="form-group">
                                        <label for="optimal_quantity">적정 수량</label>
                                        <input type="number" name="optimal_quantity" id="optimal_quantity"
                                               class="form-control"
                                               value="0" required>
                                    </div>

                                    <div class="form-group text-center">
                                        <button type="submit" class="btn list-full-button">저장</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>

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
            url: '/Logistics/Inven/ClosingCheck',
            method: 'GET',
            data: {yymm: yymm},
            success: function (response) {
                if (response === "1") {
                    if (confirm(yymm + " 날짜로 마감을 진행하시겠습니까?")) {
                        var form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '/Logistics/Inven/Closing';

                        var input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'yymm';
                        input.value = yymm;
                        form.appendChild(input);

                        document.body.appendChild(form);
                        form.submit();
                        alert(yymm + "월 마감 완료되었습니다.");
                    }
                    else if (response === "0") {
                        alert("이미 마감처리된 내역입니다.");

                    }
                } else {
                    alert("권한이 없습니다.");
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

    // 일 마감처리
    $(document).ready(function() {
        $("#dayClosingLink").click(function() {
            $.ajax({
                url: "/Logistics/DayClosing",
                type: "GET",
                success: function(response) {
                    alert("내역이 업데이트되었습니다.");
                    window.location.href = "/All/Logistics/InvenList";
                }
            });
        });
    });



</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</body>
</html>
