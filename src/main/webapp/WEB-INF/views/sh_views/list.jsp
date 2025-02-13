<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>  
    <meta charset="UTF-8">
    <title>거래처 조회</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css1/sb-admin-2.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/list.css' />">
        <script>
        	// 삭제 알림창
		    function confirmDelete(clientNo) {
		        if (confirm("정말 삭제하시겠습니까?")) {
		            location.href = 'deleteClient?client_No=' + clientNo;
		        }
		    }
		    
        	// 년 월일만 나오게 하는 함수
		    document.addEventListener("DOMContentLoaded", function() {
		        let dateCells = document.querySelectorAll(".date-cell");
		        dateCells.forEach(cell => {
		            let fullDate = cell.innerText.trim();  // 날짜 문자열 가져오기
		            let formattedDate = fullDate.substring(0, 10); // YYYY-MM-DD만 추출
		            cell.innerText = formattedDate;
		        });
		    });
        	
		    document.addEventListener("DOMContentLoaded", function() {
		        function formatBusinessNumber(businessNumber) {
		            businessNumber = businessNumber.toString();
		            return businessNumber.replace(/(\d{3})(\d{2})(\d{5})/, "$1-$2-$3");
		        }

		        document.querySelectorAll(".format-business").forEach(el => {
		            el.innerText = formatBusinessNumber(el.innerText);
		        });
		    })
		</script>
</head>
<body id ="pagetop">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>
    
    <div id="content-wrapper" class="d-flex flex-column">
    	<div id="content">
    	  <%@ include file="../header1.jsp" %>
    	  <div class="list-wrapper">
    	  	<div class="list-header">
    	  	<div>
			   	<div class="list-submenu">거래처 관리 > 거래처 조회</div>
			   	<div class="list-title">
					<div></div>
	        		<h1>거래처 조회</h1>
			   	</div>
    	  	</div>
	        <form action="/All/Sales/listSearchSh">
	            <div class="list-header2">
	            <div class="list-search-filters">
	                <select name="search">
	                    <option value="s_client_Ceo">대표 이름</option>
	                    <option value="s_client_Name">회사 이름</option>
	                </select>
	                <input type="text" name="keyword" placeholder="keyword를 입력하세요">
	                <button type="submit" class="btn list-gray-button">검색</button>
	            </div>
	        </form>
	        </div>
			</div>
	        <table class="list-table">
	            <thead>
	                <tr>
	                    <th>거래처 코드</th>
	                    <th>구분</th>
	                    <th>회사명</th>
	                    <th>대표자</th>
	                    <th>사업자 번호</th>
	                    <th>거래처 등록일</th>
	                
	                </tr>
	            </thead>
	            <tbody>
	                <c:set var="num" value="${page.total - page.start + 1}"/>
	                <c:forEach var="client" items="${listClient}">
	                    <tr>
	                        <td>${client.client_No}</td>
	                        <td>
	                            <c:choose>
	                                <c:when test="${client.client_Type == 1}">매출처</c:when>
	                                <c:when test="${client.client_Type == 0}">매입처</c:when>
	                                <c:otherwise>기타</c:otherwise>
	                            </c:choose>
	                        </td>
	                        <td><a href="detailClient?Client_No=${client.client_No}">${client.client_Name}</a></td>
	                        <td>${client.client_Ceo}</td>
	                        <td class="format-business">${client.business_No}</td>
	                        <td class="date-cell">${client.reg_Date}</td>
	                       
	                    </tr>
	                    <c:set var="num" value="${num - 1}"/>
	                </c:forEach>
	            </tbody>
	        </table>
	
		        <div style="text-align: center; margin-top: 20px;">
		            <c:if test="${page.startPage > page.pageBlock}">
		                <a href="listClient?currentPage=${page.startPage - page.pageBlock}">이전</a>
		            </c:if>
		            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
		                <a href="listClient?currentPage=${i}">[${i}]</a>
		            </c:forEach>
		            <c:if test="${page.endPage < page.totalPage}">
		                <a href="listClient?currentPage=${page.startPage + page.pageBlock}">다음</a>
		            </c:if>
		        </div>
		        
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