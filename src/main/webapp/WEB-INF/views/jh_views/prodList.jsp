<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 1. 9.
  Time: 오후 7:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product List</title>
</head>
<body>
<h1>Product List</h1>
<h3><a href="/Prod/ProdCreate">제품 등록</a> </h3>

<!-- 제품 목록 출력 -->
<table border="1">
    <thead>
    <tr>
        <th>Product No</th>
        <th>Product Name</th>
        <th>Description</th>
        <th>Status</th>
        <th>Category</th>
        <th>Actions</th>  <!-- 수정 및 상세 조회 링크 -->
    </tr>
    </thead>
    <tbody>
    <!-- list는 컨트롤러에서 모델에 추가한 ProductDto 리스트입니다. -->
    <c:forEach var="product" items="${list}">
        <tr>
            <td>${product.product_no}</td>
            <td>${product.product_name}</td>
            <td>${product.description}</td>
            <td>${product.status}</td>
            <td>${product.category}</td>
            <td>
                <!-- 수정 링크: product_no를 URL 파라미터로 전달 -->
                <a href="/Prod/Edit/${product.product_no}">Edit</a> |
                <!-- 상세 조회 링크: product_no를 URL 파라미터로 전달 -->
                <a href="/Prod/Detail/${product.product_no}">View</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>

