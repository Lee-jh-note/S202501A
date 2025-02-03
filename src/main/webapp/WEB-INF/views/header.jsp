<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- CSS 불러오기 -->
<link rel="stylesheet" href="<c:url value='/css/header.css' />">

<!-- jQuery 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="header">
    <!-- AJAX로 받아온 emp_name을 표시할 영역 -->
    <span id="empNameSpan"></span>
    
    <div class="icons">
        <img src="<c:url value='/image/gear.png' />" alt="아이콘1" class="icon">
        <img src="<c:url value='/image/box-arrow-in-right.png' />" alt="아이콘2" class="icon">
    </div>
</div>

<script>
  // 문서가 로딩된 후 실행
  $(document).ready(function() {
    $.ajax({
       url:"<%=request.getContextPath()%>/header", // RestController 주소
      type: 'GET',
      dataType: 'json',
      success: function(response) {
        // response가 EmpDTO(JSON)라고 가정
        console.log("AJAX 응답:", response);
        
        // 가져온 이름을 span에 표시
        if (response.emp_Name) {
            $("#empNameSpan").html("<strong>" + response.emp_Name + "</strong> 님, 반갑습니다! 😊");
        }
    },
      error: function(xhr, status, error) {
        console.log("에러 발생:", error);
      }
    });
  });
</script>
