<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<body>
<div class="row">
	 <div class="col-md-2 sidebar">
	    <h5>sidebar</h5>
	 </div> 
	 <div class="col-md-8 content">
	     <div class="login-form">
	             <h2>Login</h2>
	              
                  <c:if test="${!empty param.error  }">
   				      <span class="alert alert-danger">잘못된 아이디나 암호입니다</span>
				  </c:if>
		              
	              <form action="login" method="post">
	                  <input type="hidden" value="secret" name="secret_key" />
	                  <div class="form-group">
	                      <label for="username">Username</label>
	                      <input type="text" class="form-control" id="username" name="username" required>
	                  </div>
	                  <div class="form-group">
	                      <label for="password">Password</label>
	                      <input type="password" class="form-control" id="password" name="password" required>
	                  </div>
	                  <button type="submit" class="btn btn-primary">Login</button>
	              </form>
	      </div>
	 </div>
</div>

</body>
</html> 