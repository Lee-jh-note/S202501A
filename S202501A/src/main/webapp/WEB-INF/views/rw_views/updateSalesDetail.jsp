<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>출고예정리스트 수정</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        select {
            width: 100%;
            padding: 5px;
        }
    </style>
</head>
<body>
    <h2>출고 상세 조회</h2>

    <table>
        <tr><th>요청배송일</th><td>${infoSalesDetail.req_Delivery_Date}</td></tr>
        <tr><th>거래처명</th><td>${infoSalesDetail.clientName}</td></tr>
        <tr><th>담당자</th><td>${infoSalesDetail.manager}</td></tr>
        <tr><th>비고</th><td>${infoSalesDetail.remarks}</td></tr>
        <tr>
            <th>처리 상태</th>
            <td>
                <select id="status" name="status">
                    <option value="대기" ${infoSalesDetail.status == '대기' ? 'selected' : ''}>대기</option>
                    <option value="출고 완료" ${infoSalesDetail.status == '출고 완료' ? 'selected' : ''}>출고 완료</option>
                </select>
            </td>
        </tr>
    </table>

    <h3>출고 품목 목록</h3>
    <table>
        <thead>
            <tr>
                <th>품목명</th>
                <th>단가</th>
                <th>수량</th>
                <th>총금액</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${salesDetailProductList}">
                <tr>
                    <td>${product.productName}</td>
                    <td><fmt:formatNumber value="${product.price}" pattern="#,###" /></td>
                    <td>${product.quantity}</td>
                    <td><fmt:formatNumber value="${product.totalPrice}" pattern="#,###" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <button onclick="updateStatus()">처리 상태 변경</button>
    <button onclick="location.href='listSalesDetail'">목록으로</button>

    <script>
        function updateStatus() {
            let status = document.getElementById("status").value;
            let salesDate = "${infoSalesDetail.sales_Date}";
            let clientNo = "${infoSalesDetail.client_No}";

            if (!confirm("정말 처리 상태를 변경하시겠습니까?")) return;

            fetch('/updateSalesDetailStatus', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ salesDate, clientNo, status })
            })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.status === "success") {
                    location.reload();
                }
            })
            .catch(error => alert("처리 상태 변경 실패: " + error));
        }
    </script>
</body>
</html>
