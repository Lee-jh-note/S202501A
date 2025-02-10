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
        if (!frm.emp_No.value) {
            alert("사번을 입력한 후에 확인하세요");
            frm.emp_No.focus();
            return false;
        } else {
            location.href = "confirm?emp_No=" + frm.emp_No.value;
        }
    }
</script>
</head>
<body>
    
    <div class="bb"></div>
    <div>
    <h2>직원등록</h2>
        <form action="/re/writeFormEmp35" method="post" name="frm">
        <table>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="empName" required="required"></td>
                </tr>
                <tr>
                    <th>부서</th>
                    <td><select name="dept_No">
                            <c:forEach var="emp" items="${deptList}">
                                <option value="${emp.dept_No}">${emp.dept_Name}</option>
                            </c:forEach>
                        </select>
                    </td></tr>
                    
                    <!-- listEmp -->
                <tr><th>직급</th>
                  <td><select name="position">
                            <c:forEach var="emp" items="${empList}">
                                <option value="${emp.position}">${emp.position}</option>
                            </c:forEach>
                        </select>  
                    </td>
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
	                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="확인"></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
