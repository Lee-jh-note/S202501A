<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발주 조회</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/mainPage.css" rel="stylesheet">
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll('.clickable-row').forEach(row => {
                row.addEventListener('click', function () {
                    window.location.href = this.dataset.href;
                });
            });
        });
    </script>
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="header1.jsp" %>

            
            
            <div class="main-container">
		        <div class="main-header">
		            <div>
		                <h1>${emp_name} ${position}님 환영합니다</h1>
		                
		                <p>사원번호: ${emp_no} / 부서: ${dept_name} / 직급: ${position} / 입사일: ${hiredate}</p>
		            </div>
		            <img src="img/emp_ill-removebg-preview.png" alt="User Illustration">
		        </div>
				<div style="height: 20px"></div>
		        <div class="main-table">
		        	<div class="main-notice">
			            <h2>공지사항</h2>
			            <table>
			                <thead>
			                    <tr>
			                        <th>번호</th>
			                        <th>제목</th>
			                        <th>작성자</th>
			                        <th>작성일</th>
			                        <th>조회수</th>
			                    </tr>
			                </thead>
			                <tbody>
			                	<c:set var="num" value="${fn:length(listNotice)}"/>
				                <c:forEach var="notice" items="${listNotice}" varStatus="status">
					                <tr class="clickable-row" data-href="notice/NoticeContent?board_No=${notice.board_No}">
					                    <td>${num - status.index}</td> 
					                    <td>${notice.title}</td>
					                    <td>${notice.emp_Name}</td>
					                    <td><fmt:formatDate value="${notice.createdDate}" pattern="yyyy-MM-dd"/></td>
					                    <td>${notice.hits}</td>
					                </tr>
					            </c:forEach>
			                </tbody>
			            </table>
			        </div>
		        </div>
		    </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="footer1.jsp" %>
    </div>
</div>
<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="js1/sb-admin-2.min.js"></script>
</body>

</html>
