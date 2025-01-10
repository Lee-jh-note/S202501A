<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>가격 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
</head>
<body>
<h2>가격 수정</h2>

<form:form method="POST" action="/Prod/PriceModifyAct" modelAttribute="priceHistoryModel">

    <table>
        <!-- type 필드 -->
<%--        <tr>--%>
<%--            <td><label for="type"> 구분 </label></td>--%>
<%--            <td><form:input path="type" id="type" type="number" value="${priceHistoryModel.type}" /></td>--%>
<%--        </tr>--%>
        <!-- id 필드 -->
        <tr>
            <td><label for="id">가격 코드:</label></td>
            <td><form:input path="id" id="id" type="text" readonly="true" /></td>
        </tr>
        <!-- product_no 필드 -->
        <tr>
            <td><label for="product_no">제품 번호:</label></td>
            <td><form:input path="product_no" id="product_no" type="number" /></td>
        </tr>
        <!-- from_date 필드 -->
        <tr>
            <td><label for="from_date">시작 날짜:</label></td>
            <td><form:input path="from_date" id="from_date" type="text" /></td>
        </tr>
        <!-- to_date 필드 -->
        <tr>
            <td><label for="to_date">종료 날짜:</label></td>
            <td><form:input path="to_date" id="to_date" type="text" /></td>
        </tr>
        <!-- sale_or_purchase 필드 -->
        <tr>
            <td><label for="sale_or_purchase">구매/판매:</label></td>
            <td>
                <form:select path="sale_or_purchase" id="sale_or_purchase">
                    <form:option value="0" label="판매" />
                    <form:option value="1" label="구매" />
                </form:select>
            </td>
        </tr>
        <!-- price 필드 -->
        <tr>
            <td><label for="price">가격:</label></td>
            <td><form:input path="price" id="price" type="number" /></td>
        </tr>
        <!-- category 필드 -->
        <tr>
            <td><label for="category">카테고리:</label></td>
            <td>
                <form:select path="category" id="category">
                    <form:option value="500" label="500" />
                    <form:option value="510" label="510" />
                    <form:option value="520" label="520" />
                    <form:option value="530" label="530" />
                </form:select>
            </td>
        </tr>
    </table>

    <button type="submit">수정하기</button>
</form:form>

</body>
</html>
