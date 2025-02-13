<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 등록</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/css1/sb-admin-2.min.css" rel="stylesheet">
<link href="/css/detail.css" rel="stylesheet">

<style>
/* 기존 테이블 스타일 유지 */
.detail-table {
	width: 100%;
	border-collapse: collapse;
}

.detail-table th, .detail-table td {
	border: 1px solid #dadada;
	padding: 10px;
	vertical-align: middle;
}

/* 입력 필드 스타일 */
.detail-table input, .detail-table textarea {
	width: 100%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.detail-table textarea {
	min-height: 200px;
	resize: vertical;
}

/* 테이블 열 너비 조정 */
.detail-table th:nth-child(1), .detail-table td:nth-child(1) {
	width: 10%;
} /* 제목 */
.detail-table th:nth-child(2), .detail-table td:nth-child(2) {
	width: 40%;
} /* 제목 내용 */
.detail-table th:nth-child(3), .detail-table td:nth-child(3) {
	width: 10%;
} /* 작성자 */
.detail-table th:nth-child(4), .detail-table td:nth-child(4) {
	width: 30%;
} /* 작성자 이름 (30%) */

/* 버튼을 오른쪽 정렬 */
.detail-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 10px;
}
</style>
</head>

<body id="page-top">
	<div id="wrapper">
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>

				<div class="detail-wrapper">
					<form action="/All/Management/writeBoard" method="post">
						<div class="detail-header">
							<div>
								<div class="detail-submenu">게시판 > 자유게시판</div>
								<div class="detail-title">
									<div></div>
									<h1>자유게시글 등록</h1>
								</div>
							</div>
						</div>

						<div class="detail-header-content">

							<!-- 로그인한 사용자의 사원 번호를 hidden input으로 전달 -->
							<input type="hidden" name="emp_No" value="${empDTO.emp_No}">
							<input type="hidden" name="empName" value="${empDTO.empName}">

							<table class="detail-table">
								<!-- 제목 & 작성자 -->
								<tr>
									<th>제목</th>
									<td colspan="2"><input type="text" name="title" required>
									</td>
									<th>작성자</th>
									<td colspan="1"><span>${empDTO.empName}</span></td>
								</tr>

								<!-- 내용 -->
								<tr>
									<th>내용</th>
									<td colspan="5"><textarea name="content" required></textarea>
									</td>
								</tr>
							</table>

							<!-- 버튼 -->
							<div class="detail-buttons">
								<button type="submit" class="detail-full-button">등록</button>
								<button type="button" class="detail-full-button"
									onclick="history.back()">취소</button>
							</div>
					</form>
				</div>
			</div>
		</div>

		<%@ include file="../footer1.jsp"%>
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
