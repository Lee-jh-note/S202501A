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
<title>직원등록</title>
<style type="text/css">
    .bb {
       width: 180px;
    }
   h2 {
        margin-left: 100px; /* 제목 왼쪽 여백 */
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
<script type="text/javascript">
    function chk() {
        if (!frm.dept_No.value) {
            alert("사번을 입력한 후에 확인하세요");
            frm.dept_No.focus();
            return false;
        } else {
            location.href = "confirm?dept_No=" + frm.dept_No.value;
        }
    }
</script>
</head>

<body>
 <div class="bb"></div>
    <div>
    <div style="margin-top:200px">
    <h2>부서등록</h2>
        <form action="writeDept" method="post" name="frm">
        <table>
         		<tr>
             	<th>부서 번호</th>
                    <td><input type="int" name="Dept_No" required="required"></td>
                </tr>
                <tr>
                    <th>부서 이름</th>
                    <td><input type="text" name="Dept_Name" required="required"></td>
                </tr>                
                <tr>
                    <th>부서 전화번호</th>
                    <td><input type="text" name="Dept_Tel" required="required"></td>
                </tr>
				<tr>
                    <td colspan="2"><input type="submit" value="등록"></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>