<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
<%@ include file="../menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>발주 상세</title>
    <link rel="stylesheet" href="./board.css">
    <style>
        /* 전체 컨테이너 스타일 */
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 5px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
            width: 35%;
        }

        td {
            background-color: #f9f9f9;
        }

        /* 버튼 스타일 */
        .button-group {
            text-align: center;
            margin-top: 20px;
        }

        button {
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            transition: 0.3s;
        }

        .btn-list {
            background-color: #6c757d;
            color: white;
        }

        .btn-update {
            background-color: #28a745;
            color: white;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        button:hover {
            opacity: 0.8;
        }
    </style>
    <script>
    function confirmDelete(clientNo) {
        if (confirm("정말 삭제하시겠습니까?")) {
            location.href = 'deleteClient?client_No=' + clientNo;
        }
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        function formatPhoneNumber(phoneNumber) {
            return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
        }

        function formatBusinessNumber(businessNumber) {
            return businessNumber.replace(/(\d{3})(\d{2})(\d{5})/, "$1-$2-$3");
        }

        document.querySelectorAll(".format-phone").forEach(el => {
            el.innerText = formatPhoneNumber(el.innerText);
        });

        document.querySelectorAll(".format-business").forEach(el => {
            el.innerText = formatBusinessNumber(el.innerText);
        });
    });
    
</script>
</head>
<body>
    <div class="container">
        <h2>거래처 상세 정보</h2>
        <table>
            <tr><th>거래처 코드</th><td>${client.client_No}</td></tr>
            <tr><th>회사명</th><td>${client.client_Name}</td></tr>
            <tr><th>구분</th>
                <td>
                    <c:choose>
                        <c:when test="${client.client_Type == 1}">매출처</c:when>
                        <c:when test="${client.client_Type == 0}">매입처</c:when>
                        <c:otherwise>기타</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr><th>대표자</th><td>${client.client_Ceo}</td></tr>
            <tr><th>사업자 번호</th><td class="format-business">${client.business_No}</td></tr>
            <tr><th>이메일</th><td>${client.client_Email}</td></tr>
            <tr><th>기업 전화번호</th><td class="format-phone">${client.client_Tel}</td></tr>
            <tr><th>대표자 전화번호</th><td class="format-phone">${client.ceo_Tel}</td></tr>
            <tr><th>등록일</th><td>${client.reg_Date}</td></tr>
        </table>

        <div class="button-group">
            <button class="btn-list" onclick="location.href='listClient'">목록</button>
            <button class="btn-update" onclick="location.href='updateFormClient?client_No=${client.client_No}'">수정</button>
            <button class="btn-delete" onclick="confirmDelete('${client.client_No}')">삭제</button>
        </div>
    </div>
</body>
</html>
