<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <a href="/Inven/Inven/Create" class="btn btn-success">
                    수기 입력
                </a>

                <!-- 마감 진행 버튼 -->
                <button type="button" class="btn btn-danger" onclick="confirmClosing()">마감 진행</button>
            </div>
        </div>
    </form>

    <!-- 테이블을 생성하여 재고 데이터를 표시 -->
    <table class="table table-bordered">
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
                <td><fmt:formatNumber value="${inventory.pur_price}" pattern="#,###" /></td> <!-- 구매가격 -->
                <td><fmt:formatNumber value="${inventory.sale_price}" pattern="#,###" /></td> <!-- 판매가격 -->
                <td><fmt:formatNumber value="${inventory.closing == 0 ? (inventory.beginning * inventory.pur_price)
                : (inventory.closing * inventory.pur_price)}" pattern="#,###" /></td> <!-- 재고총액 -->
                <td>${inventory.optimal_quantity}</td>
                <td>
                    <!-- 수정 버튼 클릭 시 모달을 띄웁니다. -->
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                            data-id="${inventory.product_no}" data-optimal_quantity="${inventory.optimal_quantity}"> 최적수량 수정
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
        <a href="/Inven/InvenList?yymm=${type}&product_name=${name}&currentPage=${i}"/>[${i}]</a>
    </c:forEach>

    <!-- 수정 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">최적수량 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm" action="/Inven/OptimalModify" method="post">
                        <input type="hidden" id="product_no" name="product_no" />
                        <div class="mb-3">
                            <label for="optimal_quantity" class="form-label">최적수량</label>
                            <input type="number" class="form-control" id="optimal_quantity" name="optimal_quantity" required />
                        </div>
                        <button type="submit" class="btn btn-primary">수정 완료</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 모달에 데이터 세팅
    var editModal = document.getElementById('editModal');
    editModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget; // 수정 버튼
        var product_no = button.getAttribute('data-id');
        var optimal_quantity = button.getAttribute('data-optimal_quantity');

        // 모달 내 폼 필드에 값을 채워 넣기
        document.getElementById('product_no').value = product_no;
        document.getElementById('optimal_quantity').value = optimal_quantity;

        console.log("프로넘" + product_no);
        console.log("수량" + optimal_quantity);
    });


    function confirmClosing() {
        var yymm = document.getElementById("yymm").value;

        $.ajax({
            url: '/Inven/Inven/ClosingCheck',
            method: 'GET',
            data: { yymm: yymm },
            success: function(response) {
                // 0 마감 가능 // 1 마감 불가
                if (response === "0") {
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
                    alert("데이터가 없거나 이미 마감처리된 내역입니다." +
                        " 관리자에게 문의하세요.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                alert("오류 발생 관리자에게 문의하세요.");
            }
        });
    }
</script>
</body>
</html>
