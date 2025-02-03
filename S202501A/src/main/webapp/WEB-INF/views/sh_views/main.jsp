<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="/">Login Page 이동</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-12 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="Sales">Sales</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="Logistics">Logistics</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="HR">HR</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="login">로그인</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="writeFormEmp">직원등록</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="logout">로그아웃</a>
	        </li>
	      </ul>
	      <form class="d-flex">
	        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	        <button class="btn btn-outline-success" type="submit">Search</button>
	      </form>
	    </div>
	  </div>
	  	<!-- 누르면 콘솔에 정보 출력됨 -->
		<a href="/my-profile">얌</a>
       		${dto.emp_Name}
	</nav>

	<div class="sidebar">
	
	    <div>
	        <div>
	            <p><a href="/purchaseDetail/listPurchaseDetailPlan">입고 예정 리스트</a></p>
	            <p><a href=/purchaseDetail/listPurchaseDetail>입고 조회</a></p>
	            <p><a href="/purchaseDetail/listPurchaseDetailNo">미입고 조회</a></p>
	        </div>
	    </div>
	
	    <div>
	        <div>
	            <p><a href="/purchase/listPurchase">발주 조회</a></p>
	            <p><a href="/purchase/insertFormPurchase">발주 등록</a></p>
	        </div>
	    </div>
	</div>
</body>
</html>