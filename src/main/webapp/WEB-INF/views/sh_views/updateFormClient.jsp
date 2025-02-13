<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/insert.css' />">
<style type="text/css">
  .insert-table td{
   color: black;
   }
</style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <div class="insert-wrapper">
      
                    <!-- 서브메뉴랑 버튼 들어있는 헤더 -->
                    <form action="/Sales/updateClient" method="post">
                    <div class="insert-header">
                        <div>
                            <div class="insert-submenu">거래처 관리 > 거래처 상세 > 거래처 수정</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>거래처 수정</h1>
                            </div>
                        </div>
                        <div class="insert-buttons">
                            <button class="insert-empty-button" type="button" 
                               onclick="history.back()">
                               취소</button>
                            <button class="insert-full-button" id="btn" type="submit">수정</button>
                        </div>
                    </div>

                    <!-- 등록 테이블은 전체 div의 70프로 -->
                   <div class="insert-header-content">
					  <input type="hidden" name="client_No" value="${client.client_No }">
					  <table class="insert-table">  
						<tr><th>거래처 코드</th><td>${client.client_No}</td></tr>
						<tr><th>회사명</th><td>
						    <input type="text"   name="client_Name" required="required" value="${client.client_Name}" ></td></tr>
						<tr><th>구분</th>
				                <td>
				                    <c:choose>
				                        <c:when test="${client.client_Type == 1}">매출처</c:when>
				                        <c:when test="${client.client_Type == 0}">매입처</c:when>
				                        <c:otherwise>기타</c:otherwise>
				                    </c:choose>
				                </td>
				            </tr>
						<tr><th>대표자</th><td>
						    <input type="text"   name="client_Ceo"   required="required" value="${client.client_Ceo}"></td></tr>
						<tr><th>사업자 번호</th><td>
						    <input type="number" name="business_No"   required="required" value="${client.business_No}"></td></tr>
						<tr><th>이메일</th>
							<td>
					 	      <input type="text"   name="client_Email"   required="required" value="${client.client_Email}">
					    	</td>
					    </tr>
						<tr><th>기업 전화번호</th><td>
						    <input type="number" name="client_Tel" 	required="required" value="${client.client_Tel}"></td></tr>
						<tr><th>대표자 전화번호</th><td>
						    <input type="number" name="ceo_Tel" 	value="${client.ceo_Tel }"></td></tr>
						<tr><th>등록일</th>
							<td>
						       <input type="date" name="reg_Date" id="hiredate"	value="${client.reg_Date}" > 
					        </td>
						</tr>
				
					  </table>
					</form>
            </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="../footer1.jsp" %>
    </div>
</div>
<!-- jQuery (항상 가장 먼저 로드) -->
<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
<script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin (jQuery Easing 등) -->
<script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Custom scripts -->
<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>
</body>

</html>