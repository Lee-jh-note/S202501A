<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
  <meta charset="UTF-8">
  <title>Price List</title>
</head>
<body>
<h1>가격 목록</h1>

<!-- 가격 리스트 테이블 -->
<table border="1">
  <thead>
  <tr>
    <th>제품 번호</th>
    <th>시작일</th>
    <th>종료일</th>
    <th>판매/구매</th>
    <th>가격</th>
    <th>카테고리</th>
    <th>수정</th>
  </tr>
  </thead>
  <tbody>
  <!-- 가격 목록을 반복 출력 -->
  <c:forEach var="price" items="${priceList}">
    <tr>
      <td>${price.product_no}</td>
      <td>${price.from_date}</td>
      <td>${price.to_date}</td>
      <td>
        <c:choose>
          <c:when test="${price.sale_or_purchase == 0}">판매</c:when>
          <c:otherwise>구매</c:otherwise>
        </c:choose>
      </td>
      <td>${price.price}</td>
      <td>${price.category}</td>
      <!-- 수정 버튼, hidden 필드를 사용하여 price_code(id) 전송 -->
      <td>
        <form action="/Prod/PriceModify" method="get">
          <input type="hidden" name="id" value="${price.id}" />
          <button type="submit">수정</button>
        </form>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<!-- 추가 기능: 새 가격 추가 버튼 -->
<br/>
<a href="/Prod/PriceModify">새 가격 추가</a>

</body>
</html>
