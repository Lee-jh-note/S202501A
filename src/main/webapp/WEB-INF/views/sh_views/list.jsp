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
<meta charset="UTF-8">
<title>거래처 조회</title>
<link rel="stylesheet" href="./board.css">
<style>
    .bb {
        width: 300px;
    }
</style>
</head>
<body>
    <div class="bb">
    </div>
   <div>
   <h1> 발주 </h1>
        <form action="listSearch3" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
            	<select name="search">
            		<option value="s_client_Ceo">대표 이름</option>
            		<option value="s_client_Name">회사 이름</option>
            	</select>
                <input type="text" name="keyword" placeholder="keyword를 입력하세요">
                <button type="submit">검색</button>
            </div>
        
        	<td>
        		<button type="button"><a href="/chat">Chating </a><p></button>
        	</td>
        	
			<td>
			   <button type="button"><a href="writeFormClient">거래처</a></button>	
			</td>
        </form>
	
   <c:set var="num" value="${page.total-page.start+1 }"></c:set>
   
   <table>
      <tr><th >거래처 코드</th><th>구분</th><th>회사명</th><th>대표자</th><th>사업자 번호</th><th>거래처 등록일</th><th>상세/수정</th><th>삭제</th>
      <c:forEach var="client" items="${listClient}">
         <tr><td>${client.client_No}</td>
        	 <td>
                <c:choose>
                    <c:when test="${client.client_Type == 0}">
                        매출처
                    </c:when>
                    <c:when test="${client.client_Type == 1}">
                        매입처
                    </c:when>
                    <c:otherwise>
                        기타
                    </c:otherwise>
                </c:choose>
            </td>
         	 <td> ${client.client_Name}</td>
         	 <td>${client.client_Ceo}</td>
             <td>${client.business_No}</td>
             <td>${client.reg_Date}</td>
             <td><button type="button" ><a href="detailClient?Client_No=${client.client_No}">수정</button></a></td>
             <td><button type="button"><a href="deleteClient?Client_No=${client.client_No}">삭제</button></a></td>
            </tr>
            
            
         <c:set var="num" value="${num - 1 }"></c:set>
      </c:forEach>
   </table>   
   
   
   
   <c:if test="${page.startPage > page.pageBlock }">
      <a href="listClient?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
   </c:if>
   <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
      <a href="listClient?currentPage=${i}">[${i}]</a>
   </c:forEach>
   <c:if test="${page.endPage < page.totalPage }">
      <a href="listClient?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
   </c:if>   
   </div>

</body>
</html>