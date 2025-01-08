<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>
<%@ include file="menu.jsp" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Employee List</title>
  <style>

    /*body {*/
    /*  font-family: Arial, sans-serif;*/
    /*  margin: 20px;*/
    /*  background-color: #f4f4f9;*/
    /*}*/

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
      font-size: 24px;
    }

    table {
      width: 50%;
      border-collapse: collapse;
      margin: 10% auto;
      background-color: white;
    }

    th {
      background-color: #4CAF50;
      color: white;
      padding: 5px 15px;
      text-align: left;
      font-size: 16px;
    }

    td {
      padding: 5px 15px;
      border: 1px solid #ddd;
      text-align: left;
      font-size: 14px;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    td, th {
      border: 1px solid #ddd;
    }


  </style>
</head>
<body>
<table>
  <thead>
  <tr>
    <th>Employee No</th>
    <th>Department No</th>
    <th>Name</th>
    <th>Phone</th>
    <th>Email</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="emp" items="${emplist}">
    <tr>
      <td>${emp.emp_no}</td>
      <td>${emp.dept_No}</td>
      <td>${emp.emp_Name}</td>
      <td>${emp.emp_Tel}</td>
      <td>${emp.emp_Email}</td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>
