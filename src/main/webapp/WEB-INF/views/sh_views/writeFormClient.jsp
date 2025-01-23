<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
<%@ include file="../menu.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    .bb {
        width: 300px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 0 auto;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
        vertical-align: middle;
    }
    th {
        background-color: #f2f2f2;
    }
    select, input {
        width: 100%;
        padding: 5px;
        box-sizing: border-box;
    }
  </style>
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
<body>
    <div class="bb">
    </div>
    <div>
	 <h2>직원정보 입력</h2>
	 <form action="writeClient" method="post" name="frm">
	   <table>
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

			
			<tr><td colspan="2"><input type="submit" value="확인"></td></tr> 
				 
	   </table>
	 </form>
	 </div>
</body>
</html>