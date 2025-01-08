<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
  <meta charset="UTF-8">
  <title>Employee List</title>
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
    }
    table, th, td {
      border: 1px solid black;
    }
    th, td {
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>
<h2>Employee List</h2>
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
