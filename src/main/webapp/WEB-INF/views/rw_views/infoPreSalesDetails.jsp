<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>출고예정 상세조회</title>
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
thead th { text-align: center; }

/* 라디오 버튼 */
.select {
    display: flex;
    justify-content: center;
    gap: 5px;
}
.select input[type=radio] {
    display: none;
}
.select input[type=radio] + label {
    display: inline-block;
    cursor: pointer;
    height: 24px;
    width: 80px;
    border: 1px solid #333;
    line-height: 24px;
    text-align: center;
    font-weight: bold;
    font-size: 13px;
    background-color: #fff;
    color: #333;
    transition: background-color 0.3s, color 0.3s; 
}
.select input[type=radio]:checked + label {
    background-color: #333;
    color: #fff;
}
.select input[type=radio] + label:hover {
    background-color: #555;
    color: #fff;
}
</style>
</head>
<body>
    <div class="bb"></div>
    <div>
        <h1>출고 예정 상세조회</h1>
        <table>
            <tr>
                <th>매출일자</th>
                <td>${infoPreSalesDetails.sales_date}</td>
            </tr>
            <tr>
                <th>수주 담당자</th>
                <td>${infoPreSalesDetails.emp_name}</td>
            </tr>
            <tr>
                <th>출고 담당자</th>
                <td>${infoPreSalesDetails.emp_name}</td>
            </tr>
            <tr>
                <th>거래처명</th>
                <td>${infoPreSalesDetails.client_name}</td>
            </tr>
        </table>
        
        <!-- 폼 전송 -->
        <form action="/updateSalesStatus" method="post">
            <!-- 헤더 정보 -->
            <input type="hidden" name="sales_date" value="${infoPreSalesDetails.sales_date}">
            <input type="hidden" name="client_no" value="${infoPreSalesDetails.client_no}">
            
            <!-- 품목정보 테이블 -->
            <table>
                <thead>
                    <tr>
                        <th>제품명</th>
                        <th>단가</th>
                        <th>수량</th>
                        <th>총금액</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="salesProduct" items="${infoPreSalesDetailsList}" varStatus="status">
                        <tr>
                            <td>${salesProduct.product_name}</td>
                            <td>${salesProduct.price}</td>
                            <td>${salesProduct.quantity}</td>
                            <td>
                                <fmt:formatNumber value="${salesProduct.totalPrice}" type="number" pattern="#,###" />
                            </td>
                            <td>
                                <!-- 제품번호 hidden input (동일 name이면 배열로 전달됨) -->
                                <input type="hidden" name="product_no" value="${salesProduct.product_no}">
                                <!-- 각 행별 라디오 버튼 그룹 -->
                                <div class="select">
                                    <input type="radio" id="goSalesDetails${status.index}" name="salesDetailsStatus[${status.index}]" value="출고">
                                    <label for="goSalesDetails${status.index}">출고</label>
                                    
                                    <input type="radio" id="noSalesDetails${status.index}" name="salesDetailsStatus[${status.index}]" value="미출고">
                                    <label for="noSalesDetails${status.index}">미출고</label>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <!-- 버튼 영역 -->
            <div>
                <button type="button" onclick="history.back()">목록</button>
                <button type="submit">출고/미출고 처리</button>
            </div>
        </form>
    </div>
</body>
</html>
