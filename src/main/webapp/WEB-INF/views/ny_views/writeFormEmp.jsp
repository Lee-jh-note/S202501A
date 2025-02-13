<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/css1/sb-admin-2.min.css" rel="stylesheet">
<link href="/css/insert.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title
>
<script type="text/javascript">
let isDuplicateChecked = false;

function chk() {
    var empName = document.querySelector("input[name='empName']").value;
    
    if (!empName) {
        alert("직원 이름을 입력한 후에 확인하세요.");
        document.querySelector("input[name='empName']").focus();
        return false;
    }
    
    $.ajax({
        url: "<%=request.getContextPath()%>/HR/empConfirm",
        type: "GET",
        data: {
            emp_Name: empName
        },
        dataType: "json",
        success: function (response) {
            if (response.isDuplicate) {
                alert("동일한 이름 존재. 소문자 알파벳을 뒤에 붙이시오.");
                isDuplicateChecked = false;  // 중복된 경우 false로 설정
            } else {
                alert("이름 등록 가능");
                isDuplicateChecked = true;   // 중복 확인 완료 후 true로 설정
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX 오류:", textStatus, errorThrown);
            alert("중복 확인 중 오류가 발생했습니다.");
        }
    });
}

// 🔹 폼 제출 시 중복 확인 여부 체크
document.querySelector("form[name='frm']").addEventListener("submit", function(event) {
    if (!isDuplicateChecked) {
        alert("중복 확인을 먼저 수행하세요.");
        event.preventDefault();  // 폼 제출 방지
    }
});
</script>

</head>
<body id="page-top">
	<div id="wrapper">
		<%@ include file="../menu1.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../header1.jsp"%>
				<!-- 전체 div -->
				<div class="insert-wrapper">
					<form action="/re/writeFormEmp35" method="post" name="frm">
						<!-- 서브메뉴랑 버튼 들어있는 헤더 -->
						<div class="insert-header">
							<div>
								<div class="insert-submenu">인사관리 > 직원 등록</div>
								<div class="insert-title">
									<div></div>
									<h1>직원 등록</h1>
								</div>
							</div>
							<div class="insert-buttons">
								<button class="btn insert-empty-button" type="button"
									onclick="location.href='/All/HR/listEmp'">취소</button>

								<button class="btn insert-full-button" id="btn" type="submit">확인</button>
							</div>
						</div>

						<!-- 등록 테이블은 전체 div의 70프로 -->
						<div class="insert-header-content">
							<table class="insert-table">
								<tr>
									<th>이름</th>
									<td><input type="text" name="empName" required="required">
										<input type="button" class="btn insert-gray-button"
										value="중복확인" onclick="chk()"></td></tr>
								<tr>
									<th>부서</th>
									<td><select name="dept_No">
											<c:forEach var="emp" items="${deptList}">
												<option value="${emp.dept_No}">${emp.dept_Name}</option>
											</c:forEach>
									</select></td>
								</tr>

								<tr>
									<th>직급</th>
									<td><select name="position">
											<c:forEach var="emp" items="${empList}">
												<option value="${emp.position}">${emp.position}</option>
											</c:forEach>
									</select></td>
								</tr>

								<tr>
									<th>전화번호</th>
									<td><input type="text" name="emp_Tel" required="required"></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><input type="text" name="empEmail" required="required"></td>
								</tr>
								<tr>
									<th>생년월일</th>
									<td><input type="date" name="birth" required="required"></td>
								</tr>
								<tr>
									<th>입사일</th>
									<td><input type="date" name="hiredate" required="required"></td>
								</tr>
								<tr>
									<th>권한</th>
									<td><select name="roles">
											<c:forEach var="role" items="${roleList}">
												<option value="${role.content}">${role.content}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
							</table>
						</div>
					</form>
				</div>
				<!-- End of Main Content -->


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