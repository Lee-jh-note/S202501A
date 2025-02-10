<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html>
<head>
<link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="../css1/sb-admin-2.min.css" rel="stylesheet">
<link href="../css/insert.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk() {
		if (!frm.empno.value) {
			alert("코드를 입력한 후에 확인하세요");
			frm.client_No.focus();
			return false;
		} else location.href="confirm?client_No="+frm.client_No.value;
	}
	
</script>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>
            <!-- 전체 div -->
            <div class="insert-wrapper">
             <form action="writeClient" method="post" name="frm">
                    <!-- 서브메뉴랑 버튼 들어있는 헤더 -->
                    <div class="insert-header">
                        <div>
                            <div class="insert-submenu">거래처 관리 > 거래처 등록</div>
                            <div class="insert-title">
                                <div></div>
                                <h1>거래처 등록</h1>
                            </div>
                        </div>
                        <div class="insert-buttons">
                            <button class="insert-empty-button" type="button" onclick="location.href='/client/listClient'">취소</button>

                            <button class="insert-full-button" id="btn" type="submit">확인</button>
                        </div>
                    </div>

                    <!-- 등록 테이블은 전체 div의 70프로 -->
                    <div class="insert-header-content">
                    <table class="insert-table">
						<tr><th>회사명</th><td>    	<input  type="text"     name="client_Name" 			required="required"></td></tr>
						<tr><th>대표자</th><td>    	<input  type="text" 	name="client_Ceo" 			required="required"></td></tr>
						<tr><th>사업자 번호</th><td>	<input 	type="text"   	name="business_No" 			required="required"></td></tr>
						<tr><th>이메일</th><td>	 	<input 	type="text"   	name="client_Email" 		required="required"></td></tr>
						<tr><th>기업 전화번호</th><td>	<input 	type="text"   	name="client_Tel" 			required="required"></td></tr>
						<tr><th>대표자 전화번호</th><td><input 	type="text"     name="ceo_Tel" 				required="required"></td></tr>
						<tr><th>등록일</th><td>		<input 	type="date" 	name="reg_Date" 			required="required"></td></tr>
					 	<tr><th>구분</th><td>
							<select name="client_Type">
								<c:forEach var="client" items="${clientMngList}">
									<option value="${client.client_Type}">${client.client_Type}
											<c:choose>
						                        <c:when test="${client.client_Type == 0}">
						                            매입처
						                        </c:when>
						                        <c:when test="${client.client_Type == 1}">
						                            매출처
						                        </c:when>
						                        <c:otherwise>
						                            알 수 없음
						                        </c:otherwise>
						                    </c:choose>
									
									</option>
								</c:forEach>  
							</select></td>
							
								<tr>
								  <th>담당자 이름	</th>
								  <td>
								    <select name="emp_No">
								      <c:forEach var="emp" items="${empList}">
					            		<option value="${emp.emp_No}">${emp.emp_Name}</option>
								      </c:forEach>
								    </select>
								  </td>
								</tr>
							 
				   </table>
				 </div>
				</form>
            </div>
            <!-- End of Main Content -->


        </div>
        <%@ include file="../footer1.jsp" %>
    </div>
</div>
<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="../js1/sb-admin-2.min.js"></script>
</body>

</html>