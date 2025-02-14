<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유 게시판</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/css1/sb-admin-2.min.css" rel="stylesheet">
<link href="/css/list.css" rel="stylesheet">

<style>
.clickable-row { /* 행 전체 클릭 가능하게 */
	cursor: pointer;
}

.clickable-row:hover {
	background-color: #f1f1f1; /* 호버 색상 변경 */
}

style>.list-table th:nth-child(1), .list-table td:nth-child(1) {
	width: 2%; /* 조회수 칸 크기 줄이기 */
}

.list-table th:nth-child(2), .list-table td:nth-child(2) {
	width: 63%; /* 제목을 넓게 설정 */
}

.list-table th:nth-child(3), .list-table td:nth-child(3) {
	width: 10%; /* 글쓴이 칸 크기 축소 */
}

.list-table th:nth-child(4), .list-table td:nth-child(4) {
	width: 15%; /* 날짜 칸 크기 조정 */
}

.list-table th:nth-child(5), .list-table td:nth-child(5) {
	width: 5%; /* 조회수 칸 크기 줄이기 */
}
</style>







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
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>

				<div class="list-wrapper">
					<div class="list-header">
						<div>
							<div class="list-submenu">게시판 > 자유게시판</div>
							<div class="list-title">
								<div></div>
								<h1>자유게시판</h1>
							</div>
						</div>
						<div class="list-buttons">
							<input type="button" value="글작성" class="btn list-full-button"
								onclick="location.href='/All/Management/writeFormBoard'">
						</div>
					</div>
					<div class="list-header2">
						<div></div>
						<!-- 검색영역을 .search-filters 로 감싸기 -->
						<div class="list-search-filters">
							<form action="/All/Management/listSearchB" method="get"
								style="display: flex; gap: 10px; align-items: center;">
								<input type="hidden" name="search" value="s_title"> <input
									type="text" name="keyword" placeholder="제목keyword 입력"
									value="${param.keyword}">
								<button type="submit" class="btn list-gray-button">검색</button>
							</form>
						</div>
					</div>

					<%-- <c:set var="num" value="${page.total-page.start+1 }"></c:set> --%>

					<table class="list-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>글쓴이</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${fn:length(listBoard)}" />
							<!-- 총 개수 가져오기 -->
							<c:forEach var="board" items="${listBoard}" varStatus="status">
								<tr class="clickable-row"
									data-href="/All/Management/BoardContent?board_No=${board.board_No}">
									<td>${num - status.index}</td>
									<!-- 역순으로 번호 표시 -->
									<td>${board.title}</td>
									<td>${board.emp_Name}</td>
									<td><fmt:formatDate value="${board.createdDate}"
											pattern="yyyy-MM-dd" /></td>
									<td>${board.hits}</td>
								</tr>
							</c:forEach>
						</tbody>

					</table>

					<div style="text-align: center; margin-top: 20px;">
						<c:if test="${page.startPage > page.pageBlock }">
							<a
								href="/All/Management/BoardList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="/All/Management/BoardList?currentPage=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage }">
							<a
								href="/All/Management/BoardList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
						</c:if>

					</div>


				</div>
				<!-- End of Main Content -->


			</div>
			<%@ include file="../footer1.jsp"%>
		</div>
	</div>
	<!-- jQuery (항상 가장 먼저 로드) -->
	<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>

	<!-- Bootstrap Bundle (jQuery 다음에 로드) -->
	<script
		src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

	<!-- Core plugin (jQuery Easing 등) -->
	<script
		src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

	<!-- Custom scripts -->
	<script src="<c:url value='/js1/sb-admin-2.min.js' />"></script>
</body>

</html>
