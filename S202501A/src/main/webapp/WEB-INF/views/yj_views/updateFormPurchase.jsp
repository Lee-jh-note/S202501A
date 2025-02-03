<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="<c:url value='/css/board.css' />">
<script type="text/javascript">
    // getPrice 함수 추가 (insert 폼에서 복사)
    function getPrice(pProduct_no, selectElement) {
        $.ajax({
            url: "<%=request.getContextPath()%>/purchase/getPrice",
            data: { product_no: pProduct_no },
            dataType: "json",
            success: function(productPrice) {
                const parentRow = $(selectElement).closest('tr');
                parentRow.find('.productPrice').val(productPrice);
                calculateTotal(parentRow);
            }
        });
    }

    // 총금액 함수
    function calculateTotal(row) {
    	// 가격 받아오기
        const price = parseInt(row.find('.productPrice').val()) || 0;
    	// 수량 받아오기
        const quantity = parseInt(row.find('.quantity').val()) || 0;
        const total = price * quantity;
        row.find('.total').val(total);
    }
    
    // 삭제 버튼 누르면 그 줄 지워지도록
    $(document).on("click", ".deleteRow", function() {
        $(this).closest('tr').remove();
    });
    
 	// 수량 입력하면 calculateTotal() 함수 실행시켜서 총금액 받아오기
    $(document).on('input', '.quantity', function() {
      calculateTotal($(this).closest('tr'));
    });
 	
 	// 물품 선택할 때 단가 가져오는
    $(document).on('change', '.productSelect', function() {
        getPrice(this.value, this);
    });

    // 기존 물품 나타내기
    $(document).ready(function() {
        <c:forEach var="detail" items="${purchase_detail}" varStatus="status">
        	var newRow = `
                <tr>
                    <td>
                        <select name="product_no" class="productSelect">
                            <c:forEach var="product" items="${productList}">
	                            <option value="${product.product_no}"
	                                <c:if test="${detail.product_no == product.product_no}">
	                                    selected="selected"
	                                </c:if>
	                            	>
	                                ${product.product_name}
	                            </option>
                            </c:forEach>
                        </select>
                    </td>
                    <td><input type="text" name="price" class="productPrice" placeholder="단가" value="${detail.price}" readonly></td>
                    <td><input type="number" name="quantity" class="quantity" placeholder="수량" value="${detail.quantity}" required></td>
                    <td><input type="number" class="total" placeholder="총 금액" value="${detail.price * detail.quantity}" readonly></td>
                    <td><button type="button" class="deleteRow">삭제</button></td>
                </tr>
            `;
            $('#dynamicRows').append(newRow);

            // 각 행에 대한 이벤트 핸들러 바인딩 (forEach 안으로 이동)
            var currentRow = $('#dynamicRows tr').last(); //방금 추가된 행 선택
            currentRow.find('.productSelect').change(function() {
                getPrice(this.value, this);
            });
            currentRow.find('.quantity').on('input', function() {
                calculateTotal($(this).closest('tr'));
            });
            currentRow.find('.deleteRow').click(function() {
                $(this).closest('tr').remove();
            });

        </c:forEach>

        // 초기 단가 설정 (forEach 문 안으로 이동)
        $('#dynamicRows tr').each(function() {
            const initialSelect = $(this).find('.productSelect');
            getPrice(initialSelect.val(), initialSelect[0]); //getPrice 추가
            calculateTotal($(this));
        });

        // 새로운 행 추가
        $('#addRow').click(function() {
            let newRow = `
                <tr>
                    <td>
                        <select name="product_no" class="productSelect">
                            <c:forEach var="product" items="${productList}">
                                <option value="${product.product_no}">${product.product_name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    /* 단가 입력 필드 없이 나타내고 싶으면 이렇게 */
                    /* <input type="hidden" name="price" class="productPrice" value="${detail.price}">
                    <td>${detail.price}</td> */
                    <td><input type="text" name="price" class="productPrice" placeholder="단가" readonly></td>
                    <td><input type="number" name="quantity" class="quantity" placeholder="수량" required></td>
                    <td><input type="number" class="total" placeholder="총 금액" readonly></td>
                    <td><button type="button" class="deleteRow">삭제</button></td>
                </tr>
            `;
            $('#dynamicRows').append(newRow);
            
            const newSelect = $('#dynamicRows tr').last().find('.productSelect');
            getPrice(newSelect.val(), newSelect[0]);
            nextIndex++;
        });
    });
    let nextIndex = 0;

    function updatePurchase() {
    	// 구매 따로
        let purchase = {};
        purchase.purchase_date = $('input[name="purchase_date"]').val();
        purchase.client_no = $('input[name="client_no"]').val();
        purchase.title = $('input[name="title"]').val();
        purchase.req_delivery_date = $('input[name="req_delivery_date"]').val();
        purchase.remarks = $('input[name="remarks"]').val();
        purchase.status = $('input[name="status"]').val();

        // 구매상세 따로 - 구매상세는 리스트 형식임
        let purchaseDetails = [];
        $('#dynamicRows tr').each(function() {
            let detail = {};
            detail.product_no = $(this).find('.productSelect').val();
            detail.quantity = $(this).find('.quantity').val();
            detail.price = $(this).find('.productPrice').val();
            purchaseDetails.push(detail);
        });

        let purchaseData = {
            purchase: purchase,
            purchaseDetails: purchaseDetails
        };

        $.ajax({
            url: "<%=request.getContextPath()%>/purchase/updatePurchase",
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(purchaseData),
            success: function(response) {
                if (response.success) {
                    alert("발주서 수정 완료");
                    window.location.href = "<%=request.getContextPath()%>/purchase/listPurchase";
                } else {
                    alert("발주 수정 실패: " + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 오류:", textStatus, errorThrown);
                alert("발주 수정 중 오류가 발생했습니다.");
            }
        });
    }
</script>
</head>
<body>
    <div class="bb"></div>
    <div>
        <h2>발주 수정</h2>
        <form name="frm">
            <%-- <input type="hidden" name="status" value="${purchase.status }"> 상태는 전부 0으로 넣어줄거임 - 수정 데이터는 짜피 상태가 0일때만 할 수 있는거라--%>
            <input type="hidden" name="purchase_date" value="${purchase.purchase_date}">
            <input type="hidden" name="client_no" value="${purchase.client_no}">
            <input type="hidden" name="emp_no" value="${purchase.emp_no}">
            <table>
                <tr><th>제목</th>
                    <td><input type="text" name="title" value="${purchase.title}" required="required"></td></tr>
                <tr><th>매입일자</th>
                    <td>${purchase.purchase_date}</td></tr>  <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                <tr><th>요청배송일</th>
                    <td><input type="date" name="req_delivery_date" value="${purchase.req_delivery_date}" required="required"></td></tr>
                <tr><th>담당자</th>
                    <td>${purchase.emp_name}</td></tr>  <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                <tr><th>거래처명</th>
                    <td>${purchase.client_name}</td></tr> <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                <tr>
                    <th>비고</th>
                    <td><input type="text" name="remarks" value="${purchase.remarks}"></td>
                </tr>
                <tr><td colspan="2"><button type="button" id="addRow">+ 추가</button></td></tr>
            </table>
            <table>
                <thead>
                    <tr><th>품목명</th><th>단가</th><th>수량</th><th>총금액</th><th>삭제</th></tr>
                </thead>
                <tbody id="dynamicRows"></tbody>
            </table>
            <input type="button" value="수정" onclick="updatePurchase()">
            <input type="button" value="취소" onclick="history.back()">
        </form>
    </div>
</body>
</html>