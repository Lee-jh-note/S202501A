<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Detail</title>
  <!-- Bootstrap CSS 추가 -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
  <h2 class="text-center mb-4">Product Details</h2>

  <table class="table table-bordered table-striped">
    <tr>
      <th>Product No</th>
      <td>${ProductPrice.product_no}</td>
    </tr>
    <tr>
      <th>Product Name</th>
      <td>${ProductPrice.product_name}</td>
    </tr>
    <tr>
      <th>Description</th>
      <td>${ProductPrice.description}</td>
    </tr>
    <tr>
      <th>Status</th>
      <td>${ProductPrice.status == 1 ? '활성화' : '비활성화'}</td>
    </tr>
    <tr>
      <th>탑분류</th>
      <td>${ProductPrice.title}</td>
    </tr>
    <tr>
      <th>중분류</th>
      <td>${ProductPrice.content}</td>
    </tr>
    <tr>
      <th>등록일</th>
      <td>${ProductPrice.reg_date}</td>
    </tr>
    <tr>
      <th>Sale Price</th>
      <td><fmt:formatNumber value="${ProductPrice.sale_price}" pattern="#,###" /></td>
    </tr>
    <tr>
      <th>Purchase Price</th>
      <td><fmt:formatNumber value="${ProductPrice.pur_price}" pattern="#,###" /></td>
    </tr>
  </table>

  <div class="text-center mt-4">
    <a href="/Prod/ProdList" class="btn btn-secondary">Back to Product List</a>
  </div>
</div>

<!-- Bootstrap JS, Popper.js, jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
