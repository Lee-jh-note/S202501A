<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../ProdTest.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SP Recodes</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
  <style>
    .container {
      max-width: 1000px;
    }
    .table th, .table td {
      text-align: center;
    }
    .pagination a {
      margin: 0 5px;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4 text-center">실적 조회</h2>

  <!-- Form for filtering options -->
  <form action="/Recodes/List" method="get">
    <div class="row mb-4">
      <div class="col-md-4">
        <label for="searchMonth" class="form-label">검색할 년/월:</label>
        <input type="month" id="searchMonth" name="yymmdd" class="form-control"
               value="${yymmdd != null ? yymmdd : ''}">
      </div>
      <div class="col-md-4">
        <label for="product_name" class="form-label">제품명 검색:</label>
        <input type="text" id="product_name" name="product_name" class="form-control" placeholder="제품명 입력"
               value="${param.product_name != null ? param.product_name : '' }">
      </div>
      <div class="col-md-4 d-flex align-items-end">
        <!-- Submit and Download Buttons -->
        <div class="d-flex w-100 justify-content-between">
          <button type="submit" class="btn btn-primary">조회</button>
          <a href="/excel/sprecodes" class="btn btn-success">엑셀 다운로드</a>
        </div>
      </div>
    </div>
  </form>

  <!-- Table displaying data -->
  <table class="table table-bordered">
    <thead class="thead-dark">
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
        <td><fmt:formatDate value="${item.reg_date}" pattern="yy/MM/dd" /></td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- Pagination -->
  <nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
      <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
        <li class="page-item">
          <a class="page-link" href="/Recodes/List?currentPage=${i}&yymmdd=${yymmdd}&product_name=${param.product_name}">${i}</a>
        </li>
      </c:forEach>
    </ul>
  </nav>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
