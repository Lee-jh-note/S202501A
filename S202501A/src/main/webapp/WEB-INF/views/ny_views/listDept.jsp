<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<%@ include file="../footer.jsp"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서조회</title>
<link rel="stylesheet" href="./css/board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function confirmDelete(dept_No, dept_Name) {
    $.ajax({
        url: 'countEmpInDept',
        type: 'GET',
        data: { dept_No: dept_No },
        success: function(empCount) {
            var confirmMessage = dept_Name + "부서는 " + empCount + "명의 직원을 포함하고 있습니다.\n삭제를 진행하겠습니까?";
            if (confirm(confirmMessage)) {
                window.location.href = 'deleteDept?dept_No=' + dept_No;
            }
        },
        error: function() {
            alert('직원 수 조회 오류');
        }
    });
}

function editRow(button) {
    // 현재 행(row)을 찾아온다
    var row = $(button).closest('tr');
    
    // 부서 이름과 전화번호 셀(td)을 찾는다
    var deptNameCell = row.find('td:eq(1)');
    var deptTelCell = row.find('td:eq(2)');

    // 현재 텍스트를 input으로 변경
    var deptName = deptNameCell.text().trim();
    var deptTel = deptTelCell.text().trim();

    deptNameCell.html('<input type="text" name="dept_Name" value="' + deptName + '">');
    deptTelCell.html('<input type="text" name="dept_Tel" value="' + deptTel + '">');

    // "수정" 버튼을 "확인" 버튼으로 변경
    $(button).replaceWith('<button onclick="saveRow(this)">확인</button>');
}

function saveRow(button) {
    // 현재 행(row)을 찾아온다
    var row = $(button).closest('tr');

    // 입력값 가져오기
    var deptNo = row.find('td:eq(0)').text().trim(); // 부서 번호
    var deptName = row.find('td:eq(1)').find('input').val(); // 부서 이름 입력값
    var deptTel = row.find('td:eq(2)').find('input').val(); // 부서 전화번호 입력값

    // 서버에 수정 요청
    $.ajax({
        url: 'updateDept',
        type: 'POST',
        data: {
            dept_No: deptNo,
            dept_Name: deptName,
            dept_Tel: deptTel
        },
        success: function(response) {
            alert('수정되었습니다.');

            // 수정된 값으로 텍스트 변경
            row.find('td:eq(1)').text(deptName);
            row.find('td:eq(2)').text(deptTel);

            // "확인" 버튼을 다시 "수정" 버튼으로 변경
            $(button).replaceWith('<input type="button" value="수정" onclick="editRow(this)">');
        },
        error: function() {
            alert('수정 중 오류가 발생했습니다.');
        }
    });
}
</script>
<style>
/* 등록 버튼을 오른쪽으로 정렬하기 위한 스타일 */
.button-container {
    text-align: right; /* 오른쪽 정렬 */
    margin-bottom: 10px; /* 버튼 아래에 여백 추가 */
}
table {
    width: 100%; /* 테이블 너비를 페이지 전체로 확장 */
    border-collapse: collapse;
    margin: 0 auto; /* 테이블 중앙 정렬 */
}
th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #f2f2f2;
}
</style>
</head>
<body>
<div class="bb"></div>
<div class="center-container">
    <!-- 등록 버튼을 테이블 상단 오른쪽으로 위치 -->
    <div class="button-container">
        <input type="button" value="등록" onclick="location.href='writeFormDept'">
    </div>
    
    <!-- 부서 테이블 -->
    <table>
        <tr>
            <th>부서번호</th>
            <th>부서이름</th>
            <th>부서전화번호</th>
            <th>조치</th>
        </tr>
        <c:forEach var="dept" items="${listDept}">
            <tr>
                <td>${dept.dept_No}</td>
                <td>${dept.dept_Name}</td>
                <td>${dept.dept_Tel}</td>
                <td>
                    <button onclick="confirmDelete(${dept.dept_No}, '${dept.dept_Name}')">삭제</button>
                    <input type="button" value="수정" onclick="editRow(this)">
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
