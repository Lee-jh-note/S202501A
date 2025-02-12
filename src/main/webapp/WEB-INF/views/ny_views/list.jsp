<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>직원 조회</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="../css/list.css" rel="stylesheet">
</head>

<body id="page-top">
<div id="wrapper">
    <%@ include file="../menu1.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../header1.jsp" %>

            <div class="list-wrapper">
                <div class="list-header">
                    <div>
                        <div class="list-submenu">인사 관리 > 직원 조회</div>
                        <div class="list-title">
                            <div></div>
                            <h1>직원 조회</h1>
                        </div>
                    </div>
                    <div class="list-buttons">
                        <input type="button" value="등록" class="list-full-button" onclick="location.href='writeFormEmp'">
                    </div>
                </div>
                
                <div class="list-header2">
                    <div></div>
                    <!-- 검색영역을 .search-filters 로 감싸기 -->
                    <div class="list-search-filters">
                        <form action="listSearch3" method="get"
                              style="display: flex; gap: 10px; align-items: center;">

				         <select name="search">            
				            <option value="s_ename">이름조회</option>
				            <option value="s_position">직급조회</option>
				         </select> 
				         <input type="text" name="keyword" placeholder="keyword을 입력하세요">
				         <button type="submit" class="list-gray-button">키워드 검색</button>

                        </form>
                    </div>
                </div>

                <%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>

                <table class="list-table">
                    <thead>
                    <tr>
                        <th>사번</th>
                        <th>이름</th>
                        <th>부서이름</th>
                        <th>직급</th>
                        <th>전화번호</th>
                        <th>이메일</th>
                        <th>생년월일</th>
                        <th>입사일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="emp" items="${listEmp}">
                        <tr>
                            <td>${emp.emp_No}</td>
                            <td><a href="detailEmp?emp_No=${emp.emp_No}">${emp.emp_Name}</a></td>
                            <td><a href="listDept3?emp_No=${emp.emp_No}">${emp.dept_Name}</a></td>
                            <td>${emp.position}</td>
                            <td>${emp.emp_Tel}</td>
                            <td>${emp.emp_Email}</td>
                            <td>${emp.birth.substring(0, 10)}</td>
                            <td>${emp.hiredate.substring(0, 10)}</td>
                        </tr>
                        <c:set var="num" value="${num + 1 }"></c:set>
                    </c:forEach>
                    </tbody>
                </table>

                <div style="text-align: center; margin-top: 20px;">
                    <c:if test="${page.startPage > page.pageBlock }">
				         <a href="listEmp?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				      </c:if>
				      <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				         <a href="listEmp?currentPage=${i}">[${i}]</a>
				      </c:forEach>
				      <c:if test="${page.endPage < page.totalPage }">
				         <a href="listEmp?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				      </c:if>

                </div>


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
