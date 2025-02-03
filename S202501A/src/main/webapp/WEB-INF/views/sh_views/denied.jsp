<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 content">
           <div>
               <h3>${exception}</h3>    <br />
               <span>
				   <c:if test="${username != null}">
				       	${username} + ' 님은 접근 권한이 없습니다'
				   </c:if>
				   <c:if test="${username == null}">
				       	${username} + ' '비 정상적인 접근입니다'
				   </c:if>
               </span>
           </div>
        </div>
    </div>
</div>
</body>
</html>