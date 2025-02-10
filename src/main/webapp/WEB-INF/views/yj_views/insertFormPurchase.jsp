<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>발주 입력</title>
    <!-- jQuery CDN -->
    <!-- jquery.js랑 연결해서 해보려했으나 안됨,, 그래서 일단 CDN으로 -->
    <!-- 추가(addRow) 버튼을 누르면 jquery 사용해서 물품, 단가, 수량, 총금액의 input태그들이 담긴 Html을 받아오도록.
    그리고 그 물품 선택시, ajax와 연동하여 그 물품의 단가(function getPrice) 받아오도록
    + 발주서는 구매 테이블과 구매상세 테이블 한번에 등록(function insertPurchase())으로 수정. ajax를 사용하여 구매 테이블의 정보를 purchase에, 구매 상세 테이블의 정보를 purchaseDetails에 담아서 넘김.
    - 등록이 되고 나면 발주 조회 페이지로 다시 넘어가도록 설계.-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        let isDuplicateChecked = false;

        // 매입일자와 거래처코드 중복체크
        function chk() {
            // 거래처 코드와 매입일자가 입력되지 않았는지 확인
            if (!frm.client_no.value || !frm.purchase_date.value) {
                alert("거래처명과 매입일자를 모두 입력한 후 확인하세요");
                if (!clientNo) frm.client_no.focus();
                else frm.purchase_date.focus();
                return false;
            } // 처음에 그냥 바로 PurchaseController로 연결했다가 적어놓은 데이터를 불러오지 못해서 ajax로 변경
              // else location.href="confirm?client_no="+frm.client_no.value+"&purchase_date="+frm.purchase_date.value;
            $.ajax({
                url: "<%=request.getContextPath()%>/purchase/confirm",
                type: "GET",
                data: {
                    client_no: frm.client_no.value,
                    purchase_date: frm.purchase_date.value
                },
                dataType: "json",
                success: function (response) {
                    if (response.isDuplicate) {
                        alert("거래처명과 매입일자가 동일한 발주서가 있습니다.");
                        isDuplicateChecked = false;
                    } else {
                        alert("거래처명과 매입일자 사용 가능합니다.");
                        isDuplicateChecked = true; // 중복 확인을 위해 isDuplicateChecked
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("AJAX 오류:", textStatus, errorThrown);
                    alert("중복 확인 중 오류가 발생했습니다.");
                }
            });
        }

        // getPrice- 물품 선택하면 단가 가져오게 하는 ajax- PurchaseController에 있음
        function getPrice(pProduct_no, selectElement) {
            /* alert: 확인하기 위한 알림. 잘 되는게 확인되면 지우기 */
            // alert("pProduct_no->"+pProduct_no)
            $.ajax(
                {
                    url: "<%=request.getContextPath()%>/purchase/getPrice",
                    data: {product_no: pProduct_no},
                    dataType: "json",
                    success: function (productPrice) {
                        // 이렇게만 했다가 한줄만 반영됨,,,,,
                        // $('#productPrice').val(productPrice);
                        console.log("Product Price: ", productPrice);

                        // 1. 현재 선택된 <select> 요소의 <tr> 찾아서
                        const parentRow = $(selectElement).closest('tr');
                        // 2. 찾은 행의 단가 필드 업데이트 시키기
                        parentRow.find('.productPrice').val(productPrice);

                        // 총 금액도 수량이 바뀔때마다 업데이트 되어야 함.
                        calculateTotal(parentRow);
                    }
                });
        }

        // 구매 테이블 데이터를 넣을 때, 그 구매 input에 담겨있는 값들이 사라지면 안됨. 그 자리에 그대로 남아있어야함. 그래서 insert 또한 ajax로

        // 일단 구매 데이터를 먼저 넣고, 이게 성공하면 function insertDetailPurchase()를 실행하도록,,
        <%-- 	function insertPurchase(){
                let purchase = {};
                purchase.purchase_date = 	$('input[name="purchase_date"]').val();
                purchase.client_no = 		$('select[name="client_no"]').val();
                purchase.title = 			$('input[name="title"]').val();
                purchase.req_delivery_date = $('input[name="req_delivery_date"]').val();
                purchase.remarks = 			$('input[name="remarks"]').val();
                purchase.emp_no = 			$('select[name="emp_no"]').val();

                $.ajax({
                    url:"<%=request.getContextPath()%>/insertPurchase",
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(purchase),
                    success:function(response){
                        if(response.success){
                            insertDetailPurchase();
                        }else{
                            alert("구매 테이블 등록 실패,,: " + response.message);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown){
                        console.error("AJAX 오류:", textStatus, errorThrown);

                    }
                });
                console.log("전송 데이터", JSON.stringify(purchase));
            }

            // 구매 상세 테이블 데이터를 넣을 때, 리스트 형식으로 넣어야함. 그래서 ajax로
            // oBootMybatis 파일에 있는 listEmpAjax의 getEmpListUpdate 참고
            function insertDetailPurchase(){

                let purchaseDetails = [];
                $('#dynamicRows tr').each(function (){
                    let detail = {};
                    detail.purchase_date = 	$('input[name="purchase_date"]').val();
                    detail.client_no = 		$('select[name="client_no"]').val();
                    detail.product_no = $(this).find('.productSelect').val();
                    detail.quantity = $(this).find('.quantity').val();
                    detail.price = $(this).find('.productPrice').val();
                    purchaseDetails.push(detail);

                });

                $.ajax({
                    url:"<%=request.getContextPath()%>/insertDetailPurchase",
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(purchaseDetails),
                    success:function(response){
                        if(response.success){
                            alert("발주서 등록 완료");
                            window.location.href = "<%=request.getContextPath()%>/listPurchase";
                        }else{
                            alert("발주 등록 실패,,, " + response.message);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown){
                        console.error("AJAX 오류:", textStatus, errorThrown);

                    }
                });
                console.log("전송 데이터", JSON.stringify(purchaseDetails));
            } --%>

        // 트랜잭션 문제 때문에 Purchasedata 클래스 만들어서 한번에 데이터 넣는걸로 수정
        function insertPurchase() {
            // 구매 데이터
            let purchase = {};
            purchase.purchase_date = $('input[name="purchase_date"]').val();
            purchase.client_no = $('select[name="client_no"]').val();
            purchase.title = $('input[name="title"]').val();
            purchase.req_delivery_date = $('input[name="req_delivery_date"]').val();
            purchase.remarks = $('textarea[name="remarks"]').val();
            purchase.emp_no = $('input[name="emp_no"]').val();

            // 날짜 비교를 위한 Date 객체 생성
            let purchaseDate = new Date(purchase.purchase_date);
            let reqDeliveryDate = new Date(purchase.req_delivery_date);

            // 날짜 비교: 요청 배송일이 매입일보다 빠른 경우
            if (reqDeliveryDate < purchaseDate) {
                alert("요청 배송일은 매입일보다 늦어야 합니다.");
                $('input[name="req_delivery_date"]').focus(); // 요청 배송일 input에 focus
                return false;
            }

            // 칸을 채워야 등록으로 넘어가도록 유효성 검사
            // 제목
            if (!purchase.title) {
                alert("제목을 입력해주세요.");
                $('input[name="title"]').focus();
                return false;
            }
            // 매입일자
            if (!purchase.purchase_date) {
                alert("매입일자를 입력해주세요.");
                $('input[name="purchase_date"]').focus();
                return false;
            }
            // 요청배송일
            if (!purchase.req_delivery_date) {
                alert("요청배송일을 입력해주세요.");
                $('input[name="req_delivery_date"]').focus();
                return false;
            }
            // 담당자
            if (!purchase.emp_no) {
                alert("담당자를 선택해주세요.");
                $('select[name="emp_no"]').focus();
                return false;
            }
            // 거래처명
            if (!purchase.client_no) {
                alert("거래처명을 선택해주세요.");
                $('select[name="client_no"]').focus();
                return false;
            }
            // 중복 확인 여부 검사
            if (!isDuplicateChecked) {
                alert("거래처 및 매입일자 중복 확인을 해주세요.");
                return false;
            }

            // 구매 상세 데이터
            let purchaseDetails = [];
            let productNumbers = []; // 품목 번호 저장
            let isValidDetails = true; // 구매 상세 유효성

            // 물품을 한줄도 추가하지 않은 경우
            if ($('#dynamicRows tr').length === 0) {
                alert("물품을 추가해주세요.");
                return false;
            }

            $('#dynamicRows tr').each(function (index) {
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

            // 구매 정보와 구매 상세 정보를 한번에 보내기 위해 let으로
            let purchaseData = {
                purchase: purchase,
                purchaseDetails: purchaseDetails
            };

            $.ajax({
                url: "<%=request.getContextPath()%>/purchase/insertPurchaseAll",
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(purchaseData),
                success: function (response) {
                    if (response.success) {
                        alert("발주서 등록 완료");
                        window.location.href = "<%=request.getContextPath()%>/purchase/listPurchase";
                    } else {
                        alert("발주 등록 실패: " + response.message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("AJAX 오류:", textStatus, errorThrown);
                }
            });
        }


        // 총 금액 계산을 위한,,
        function calculateTotal(row) {
            // 가격 받아오기
            const price = parseInt(row.find('.productPrice').val()) || 0;
            // 수량 받아오기
            const quantity = parseInt(row.find('.quantity').val()) || 0;
            const total = price * quantity; // 총금액 계산
            row.find('.total').val(total);
        }

        $(document).ready(function () {
            $('#dynamicRows tr').each(function () {
                const initialSelect = $(this).find('.productSelect');
                if (initialSelect.length > 0) { // select 요소가 있는 경우에만 실행
                    getPrice(initialSelect.val(), initialSelect[0]);
                }
            });
            // 물품 드롭다운으로 물품 선택하면 getPrice로 그 물품의 단가 가져오기
            $(document).on('change', '.productSelect', function () {
                getPrice(this.value, this);
            });
            // 수량(class)이 입력되면 그걸 받아서 총금액 계산
            $(document).on('input', '.quantity', function () {
                calculateTotal($(this).closest('tr'));
            });
            // 삭제 버튼을 클릭함으로써 제품 등록의 한 줄 지우기
            $(document).on('click', '.deleteRow', function () {
                $(this).closest('tr').remove();
            });
            $('#addRow').click(function () {
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
                    <td><button type="button" class="deleteRow">삭제</button></td>
                </tr>
            `;
                $('#dynamicRows').append(newRow);

                const newSelect = $('#dynamicRows tr').last().find('.productSelect');
                getPrice(newSelect.val(), newSelect[0]);

                nextIndex++; // 다음 index를 위한 증가
                console.log("nextIndex ", nextIndex);

                // 발주서 등록 (btn) 누르면 컨트롤러 실행 되도록.
                $('btn').click(function () {
                    insertPurchase();
                })
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
        let nextIndex = 0; // Purchase_details의 index를 저장할 변수
    </script>
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/insert.css" rel="stylesheet">
    <style type="text/css">
    .insert-table td{
		color: black;
	}
	/* 거래처명 select 필드의 너비를 80%로 설정 */
	.insert-table select[name="client_no"] {
	    width: 70%;
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
                            <div class="insert-submenu">발주/수주 관리 > 발주 입력</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>발주 입력</h1>
                            </div>
                        </div>
                        <div class="insert-buttons">
                            <button class="insert-empty-button" type="button" 
                            	onclick="location.href='/purchase/listPurchase'">취소</button>
                            <button class="insert-full-button" id="btn" type="button" onclick="insertPurchase()">확인</button>
                        </div>
                    </div>

                    <!-- 등록 테이블은 전체 div의 70프로 -->
                    <div class="insert-header-content">
                        <c:if test="${msg!=null}">${msg}</c:if>
                        <!-- 발주 정보 테이블 -->
                        <table class="insert-table">
                            <tr>
                                <th>제목</th>
                                <td colspan="3">
                                    <input type="text" name="title" required="required" placeholder="발주_YYYYMMDD_거래처명"/>
                                </td>
                            </tr>
                            <tr>
                                <th>매입일자</th>
                                	<td><input type="date" name="purchase_date" required="required" value="${sysdate}" readonly/></td>
                                <th>담당자</th>
	                                <!-- 화면에 이름 표시 -->
	                                <td><span>${emp_name}</span>
	                                    <!-- emp_no 값을 숨겨서 전송 -->
	                                    <input type="hidden" name="emp_no" value="${emp_no}"></td>
                            </tr>
                            <tr>
                                <th>요청배송일</th>
                                	<td><input type="date" name="req_delivery_date" required="required"/></td>
                                <th>거래처명</th>
                                	<td><select name="client_no" value="${client_no}">
	                                        <c:forEach var="client" items="${clientList}">
	                                            <option value="${client.client_no}"${client.client_no == client_no ? 'selected' : ''}>${client.client_name}</option>
	                                        </c:forEach>
                                    	</select>
                                    	<input type="button" class="insert-gray-button" value="중복확인" onclick="chk()"></td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="3"><textarea id="note" name="remarks"></textarea></td>
                            </tr>
                        </table>

                        <!-- 품목 정보 헤더 + '추가' 버튼 -->
                        <div class="product-header">
                            <div class="product-title">품목 정보</div>
                            <button class="insert-gray-button" id="addRow">추가</button>
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
<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="../js1/sb-admin-2.min.js"></script>
</body>

</html>
