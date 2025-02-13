<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    // getPrice 함수 추가 (insert 폼에서 복사)
    function getPrice(pProduct_no, selectElement) {
        $.ajax({
            url: "<%=request.getContextPath()%>/Sales/getPrice",
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
                    <td><button type="button" class="btn deleteRow">삭제</button></td>
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
                    <td style="width: 160px;">
                        <select name="product_no" class="productSelect">
                            <c:forEach var="product" items="${productList}">
                                <option value="${product.product_no}">${product.product_name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td><input type="text" name="price" class="productPrice" placeholder="단가" readonly></td>
                    <td><input type="number" name="quantity" class="quantity" placeholder="수량" required></td>
                    <td><input type="number" class="total" placeholder="총 금액" readonly></td>
                    <td><button type="button" class="btn deleteRow">삭제</button></td>
                </tr>
            `;
            $('#dynamicRows').append(newRow);
            
            const newSelect = $('#dynamicRows tr').last().find('.productSelect');
            getPrice(newSelect.val(), newSelect[0]);
            nextIndex++;
        });
        
       // 바이트 수 제한 관련 코드 추가 (제목 50바이트, 비고 300바이트, 수량 제한)
        function getByteLength(str) {
            let byteCount = 0;
            for (let i = 0; i < str.length; i++) {
                let char = str.charAt(i);
                byteCount += (char.charCodeAt(0) > 127) ? 3 : 1; // 한글(3바이트), 영문/숫자(1바이트)
            }
            return byteCount;
        }

        // 제목 입력 길이 제한 (최대 50바이트)
        $('input[name="title"]').on('input', function () {
            let maxBytes = 50;
            let inputText = this.value;
            let byteCount = getByteLength(inputText);
            
            while (byteCount > maxBytes) {
                inputText = inputText.substring(0, inputText.length - 1);
                byteCount = getByteLength(inputText);
            }

            if (this.value !== inputText) {
                alert("제목은 최대 50바이트까지 입력 가능합니다. (한글 약 16~17자)");
                this.value = inputText;
            }
        });

        // 비고 입력 시 바이트 수 제한 (최대 300바이트)
        $('textarea[name="remarks"]').on('input', function () {
            let maxBytes = 300;
            let inputText = this.value;
            let byteCount = getByteLength(inputText);
            
            while (byteCount > maxBytes) {
                inputText = inputText.substring(0, inputText.length - 1);
                byteCount = getByteLength(inputText);
            }

            if (this.value !== inputText) {
                alert("비고는 최대 300바이트까지 입력 가능합니다. (한글 약 100자)");
                this.value = inputText;
            }
        });

        // 수량 입력 제한 (1~99,999,999)
        $(document).on('input', '.quantity', function () {
            let value = parseInt(this.value);
            if (value > 99999999) {
                alert("수량은 최대 99,999,999까지 입력 가능합니다.");
                this.value = 99999999;
            } else if (value < 1 || isNaN(value)) {
                alert("수량은 1 이상 입력해야 합니다.");
                this.value = 1;
            }
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
        purchase.remarks = $('textarea[name="remarks"]').val();
        purchase.status = $('input[name="status"]').val();
        
        // 제목 체크
        if (!purchase.title) {
            alert("제목을 입력해주세요.");
            $('input[name="title"]').focus();
            return false;
        }

        // 요청 배송일 체크
        if (!purchase.req_delivery_date) {
            alert("요청 배송일을 입력해주세요.");
            $('input[name="req_delivery_date"]').focus();
            return false;
        }

        // 구매상세 따로 - 구매상세는 리스트 형식임
        let purchaseDetails = [];
        let productNumbers = [];
        let isValidDetails = true;
        
        // 물품을 한줄도 추가하지 않은 경우
        if ($('#dynamicRows tr').length === 0) {
            alert("물품을 추가해주세요.");
            return false;
        }
        
        $('#dynamicRows tr').each(function(index) {
            let detail = {};
            let productNo = $(this).find('.productSelect').val();
            let quantity = $(this).find('.quantity').val();
            
            // 품목 선택 여부 검사
            if (!productNo) {
                alert((index + 1) + "번째 행의 품목을 선택해주세요.");
                $(this).find('.productSelect').focus();
                isValidDetails = false;
                return false;
            }
            
            // 중복 검사
            if (productNumbers.includes(productNo)) {
                alert((index + 1) + "번째 행의 품목이 중복되었습니다.");
                $(this).find('.productSelect').focus();
                isValidDetails = false;
                return false;
            }
            
            productNumbers.push(productNo); // 중복 검사 통과 후 배열에 추가
            
            // 수량 유효성 검사
            if (!quantity || isNaN(quantity) || quantity <= 0) {
                alert((index + 1) + "번째 행의 수량을 올바르게 입력해주세요.");
                $(this).find('.quantity').focus();
                isValidDetails = false;
                return false;
            }
         
            detail.product_no = productNo;
            detail.quantity = quantity;
            detail.price = $(this).find('.productPrice').val();
            purchaseDetails.push(detail);
        });
        
        if (!isValidDetails) {
            return false;
        }

        let purchaseData = {
            purchase: purchase,
            purchaseDetails: purchaseDetails
        };

        $.ajax({
            url: "<%=request.getContextPath()%>/Sales/updatePurchase",
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(purchaseData),
            success: function(response) {
                if (response.success) {
                    alert("발주서 수정 완료");
                    window.location.href = "<%=request.getContextPath()%>/All/Sales/listPurchase";
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
<link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
<link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='/css/insert.css' />">
<style type="text/css">
  .insert-table td{
   color: black;
   }
</style>
</head>


<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <div class="insert-wrapper">
                <form name="frm">
                    <!-- 서브메뉴랑 버튼 들어있는 헤더 -->
                    <div class="insert-header">
                        <div>
                            <div class="insert-submenu">발주/수주 관리 > 발주 조회</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>발주 수정</h1>
                            </div>
                        </div>
                        <div class="insert-buttons">
                            <button class="btn insert-empty-button" type="button" 
                               onclick="history.back()">
                               취소</button>
                            <button class="btn insert-full-button" id="btn" type="button" onclick="updatePurchase()">수정</button>
                        </div>
                    </div>

                    <!-- 등록 테이블은 전체 div의 70프로 -->
                    <div class="insert-header-content">
                        <c:if test="${msg!=null}">${msg}</c:if>
                        <!-- 발주 정보 테이블 -->
                          <%-- <input type="hidden" name="status" value="${purchase.status }"> 상태는 전부 0으로 넣어줄거임 - 수정 데이터는 짜피 상태가 0일때만 할 수 있는거라--%>
                     <input type="hidden" name="purchase_date" value="${purchase.purchase_date}">
                     <input type="hidden" name="client_no" value="${purchase.client_no}">
                     <input type="hidden" name="emp_no" value="${purchase.emp_no}">
                        <table class="insert-table">
                            <tr>
                                <th>제목</th>
                                <td colspan="3">
                                    <input type="text" name="title" value="${purchase.title}" required="required">
                                </td>
                            </tr>
                            <tr>
                                <th>매입일자</th>
                                   <td>${purchase.purchase_date}</td> <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                                <th>담당자</th>
                                   <td>${purchase.emp_name}</td> <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                            </tr>
                            <tr>
                                <th>요청배송일</th>
                                   <td><input type="date" name="req_delivery_date" value="${purchase.req_delivery_date}" required="required"></td>
                                <th>거래처명</th>
                                   <td>${purchase.client_name}</td> <%-- 화면 표시용 - input은 hidden으로 해서 위에서 넣음--%>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="3"><textarea id="note" name="remarks">${purchase.remarks}</textarea></td>
                            </tr>
                        </table>

                        <!-- 품목 정보 헤더 + '추가' 버튼 -->
                        <div class="product-header">
                            <div class="product-title">품목 정보</div>
                            <button class="btn insert-gray-button" type="button" id="addRow">추가</button>
                        </div>

                        <!-- 품목 정보 테이블 -->
                        <table class="insert-table">
                            <thead>
                            <tr>
                                <th>품목명</th>
                                <th>단가</th>
                                <th>수량</th>
                                <th>총 금액</th>
                                <th>삭제</th>
                            </tr>
                            </thead>
                            <tbody id="dynamicRows">
                            <!-- 동적 행들이 들어갈 공간 -->
                            </tbody>
                        </table>
                   </div>
                </form>
            </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="../footer1.jsp" %>
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