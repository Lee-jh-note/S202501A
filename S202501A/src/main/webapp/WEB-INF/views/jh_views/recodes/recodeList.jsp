<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SP Recodes</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">실적 조회 </h2>

  <!-- Form for filtering options -->
  <form action="/Recodes/List" method="get">
    <div class="col-md-4">
      <label for="searchMonth" class="form-label">검색할 년/월:</label>
      <input type="month" id="searchMonth" name="yymmdd" class="form-control"
             value="${yymmdd != null ? yymmdd : ''}">
    </div>

      <!-- Select for product name filter -->
    <div class="col">
      <label for="product_name">제품명 검색</label>
      <input type="text" id="product_name" name="product_name" class="form-control" placeholder="제품명 입력"
       value="${param.product_name != null ? param.product_name : '' }">
    </div>
      <!-- Submit button -->
      <div class="col">
        <button type="submit" class="btn btn-primary mt-4">조회</button>
      </div>
  </form>

  <!-- Table displaying data -->
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>날짜</th>
      <th>대분류</th>
      <th>제품번호</th>
      <th>제품명</th>
      <th>구매량</th>
      <th>구매단가</th>
      <th>구매총액</th>
      <th>판매량</th>
      <th>판매단가</th>
      <th>판매총액</th>
      <th>처리자</th>
      <th>처리일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${recode}">
      <tr>
        <td>${item.yymmdd}</td>
        <td>${item.title}</td>
        <td>${item.product_no}</td>
        <td>${item.product_name}</td>
        <td>${item.purQuantity}</td>
        <td>${item.purPrice}</td>
        <td>${(item.purPrice * item.purQuantity)}</td>
        <td>${item.saleQuantity}</td>
        <td>${item.salePrice}</td>
        <td>${(item.salePrice * item.saleQuantity)}</td>
        <td>${item.emp_name}</td>
        <td>${item.reg_date}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- Pagination -->
  <div>
    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
      <a href="/Recodes/List?currentPage=${i}&yymmdd=${yymmdd}&product_name=${param.product_name}">[${i}]</a>
    </c:forEach>
  </div>
</div>
</body>
</html>

