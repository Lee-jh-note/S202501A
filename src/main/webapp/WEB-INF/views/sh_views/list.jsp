<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      /* 기본 스타일 */
body {
    font-family: Arial, sans-serif;
    background: #f9f9f9;
    margin: 20px;
}

/* 컨테이너 */
.container {
    width: 90%;
    max-width: 800px;
    margin: auto;
    background: white;
    padding: 15px;
    border: 1px solid #ddd;
}

/* 제목 */
h1 {
    text-align: center;
    color: #333;
}

/* 폼 스타일 */
form {
    display: flex;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 10px;
}

input, select, button {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

/* 버튼 */
button {
    background: #007BFF;
    color: white;
    cursor: pointer;
}

button:hover {
    background: #0056b3;
}

/* 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

th {
    background: #007BFF;
    color: white;
}

/* 버튼 스타일 */
.btn {
    padding: 5px 10px;
    border: none;
    cursor: pointer;
}

.btn-edit {
    background: #ffc107;
    color: white;
}

.btn-delete {
    background: #dc3545;
    color: white;
}

.btn-edit:hover {
    background: #e0a800;
}

.btn-delete:hover {
    background: #c82333;
}

/* 페이지네이션 */
.pagination {
    text-align: center;
    margin-top: 10px;
}

.pagination a {
    padding: 5px 10px;
    background: #007BFF;
    color: white;
    text-decoration: none;
    border-radius: 3px;
}

.pagination a:hover {
    background: #0056b3;
}


        
    </style>
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
<body>
    <div class="container">
        <h1>거래처 조회</h1>
        <form action="listSearchSh">
            <div>
                <select name="search">
                    <option value="s_client_Ceo">대표 이름</option>
                    <option value="s_client_Name">회사 이름</option>
                </select>
                <input type="text" name="keyword" placeholder="keyword를 입력하세요">
                <button type="submit">검색</button>
            </div>
            <button type="button"><a href="writeFormClient">거래처 등록</a></button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>거래처 코드</th>
                    <th>구분</th>
                    <th>회사명</th>
                    <th>대표자</th>
                    <th>사업자 번호</th>
                    <th>거래처 등록일</th>
                    <th>상세/수정</th>
                    <th>삭제</th>
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
                        <td>${client.client_Name}</td>
                        <td>${client.client_Ceo}</td>
                        <td class="format-business">${client.business_No}</td>
                        <td class="date-cell">${client.reg_Date}</td>
                        <td>
                            <button><a href="detailClient?Client_No=${client.client_No}">수정</a></button>
                        </td>
                        <td>
                             <button class="btn-delete" onclick="confirmDelete('${client.client_No}')">삭제</button>
                        </td>
                    </tr>
                    <c:set var="num" value="${num - 1}"/>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <c:if test="${page.startPage > page.pageBlock}">
                <a href="listClient?currentPage=${page.startPage - page.pageBlock}">이전</a>
            </c:if>
            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                <a href="listClient?currentPage=${i}">${i}</a>
            </c:forEach>
            <c:if test="${page.endPage < page.totalPage}">
                <a href="listClient?currentPage=${page.startPage + page.pageBlock}">다음</a>
            </c:if>
        </div>
    </div>
</body>
</html>
