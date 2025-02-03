<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%--<html lang="ko">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>Price List</title>--%>
<%--  <!-- Bootstrap CSS 추가 -->--%>
<%--  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container mt-4">--%>
<%--  <h1 class="text-center mb-4">가격 변동 내역</h1>--%>

<%--  <!-- 검색 폼 -->--%>
<%--  <form action="/Prod/PriceList" method="get" class="mb-4">--%>
<%--    <div class="form-row align-items-center">--%>
<%--      <div class="col-auto">--%>
<%--        <label for="name" class="col-form-label">제품명:</label>--%>
<%--        <input type="text" id="name" name="name" value="${param.name}" class="form-control">--%>
<%--      </div>--%>
<%--      <div class="col-auto">--%>
<%--        <label for="type" class="col-form-label">매입/매출:</label>--%>
<%--        <select name="type" id="type" class="form-control">--%>
<%--          <option value="">전체</option>--%>
<%--          <option value="1" ${param.type == '1' ? 'selected' : ''}>매입</option>--%>
<%--          <option value="0" ${param.type == '0' ? 'selected' : ''}>매출</option>--%>
<%--        </select>--%>
<%--      </div>--%>
<%--      <div class="col-auto">--%>
<%--        <button type="submit" class="btn btn-primary">검색</button>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </form>--%>

<%--  <!-- 가격 리스트 테이블 -->--%>
<%--  <table class="table table-bordered table-striped">--%>
<%--    <thead class="thead-dark">--%>
<%--    <tr>--%>
<%--      <th>제품 번호</th>--%>
<%--      <th>시작일</th>--%>
<%--      <th>종료일</th>--%>
<%--      <th>판매/구매</th>--%>
<%--      <th>가격</th>--%>
<%--      <th>카테고리</th>--%>
<%--      <th>수정</th>--%>
<%--    </tr>--%>
<%--    </thead>--%>
<%--    <tbody>--%>
<%--    <!-- 가격 목록을 반복 출력 -->--%>
<%--    <c:forEach var="price" items="${priceList}">--%>
<%--      <tr>--%>
<%--        <td>${price.product_name}</td>--%>
<%--        <td>${price.from_date}</td>--%>
<%--        <td>${price.to_date}</td>--%>
<%--        <td>--%>
<%--          <c:choose>--%>
<%--            <c:when test.xml="${price.sale_or_purchase == 0}">판매</c:when>--%>
<%--            <c:otherwise>구매</c:otherwise>--%>
<%--          </c:choose>--%>
<%--        </td>--%>
<%--        <td><fmt:formatNumber value="${price.price}" pattern="#,###" /></td>--%>
<%--        <td>${price.category}</td>--%>
<%--        <td>--%>
<%--          <form action="/Prod/PriceModify" method="get">--%>
<%--            <input type="hidden" name="id" value="${price.id}"/>--%>
<%--            <input type="hidden" name="product_name" value="${price.product_name}"/>--%>
<%--            <input type="hidden" name="product_no" value="${price.product_no}"/>--%>
<%--            <button type="submit" class="btn btn-warning btn-sm">수정</button>--%>
<%--          </form>--%>
<%--        </td>--%>
<%--      </tr>--%>
<%--    </c:forEach>--%>
<%--    </tbody>--%>
<%--  </table>--%>

<%--  <!-- 페이지 네비게이션 -->--%>
<%--  <div class="d-flex justify-content-center">--%>
<%--    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">--%>
<%--      <a href="/Prod/PriceList?name=${SName}&type=${SType}&currentPage=${i}" class="btn btn-outline-secondary btn-sm mx-1">${i}</a>--%>
<%--    </c:forEach>--%>
<%--  </div>--%>

<%--  <!-- 새 가격 추가 버튼 -->--%>
<%--  <div class="text-center mt-4">--%>
<%--    <a href="/Prod/PriceModify" class="btn btn-success">새 가격 추가</a>--%>
<%--  </div>--%>
<%--</div>--%>

<%--<!-- Bootstrap JS, Popper.js, jQuery 추가 -->--%>
<%--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>--%>
<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
<%--</body>--%>
<%--</html>--%>
