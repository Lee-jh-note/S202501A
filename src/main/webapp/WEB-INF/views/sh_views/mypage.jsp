<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .mypage-container {
            width: 350px;
            background: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .title {
            font-size: 24px;
            color: #007BFF;
            margin-bottom: 20px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input {
            width: 95%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[readonly] {
            background-color: #f0f0f0;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .delete-btn {
            background-color: transparent;
            border: none;
            color: gray;
            cursor: pointer;
            font-size: 12px;
        }

        .update-btn {
            background-color: transparent;
            border: none;
            color: gray;
            cursor: pointer;
            font-size: 12px;
        }

        .password-change-btn {
            background-color: #007BFF;
            color: white;
            padding: 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }

        .password-change-btn:hover {
            background-color: #0056b3;
        }

        #password-result {
            margin-top: 10px;
            font-size: 12px;
        }
	        /* 모달 스타일 */
		.modal {
		    display: none; /* 기본적으로 숨김 */
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.4);
		}
		
		/* 모달 컨텐츠 */
		.modal-content {
		    background-color: white;
		    margin: 15% auto;
		    padding: 20px;
		    border-radius: 10px;
		    width: 300px;
		    text-align: center;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
		}
		
		/* 닫기 버튼 */
		.close-btn {
		    float: right;
		    font-size: 20px;
		    cursor: pointer;
		    color: #aaa;
		}
		
		.close-btn:hover {
		    color: black;
		}
			/* 모달 스타일 */
		.modal {
		    display: none; /* 기본적으로 숨김 */
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.4);
		}
		
		/* 모달 컨텐츠 */
		.modal-content {
		    background-color: white;
		    margin: 15% auto;
		    padding: 20px;
		    border-radius: 10px;
		    width: 300px;
		    text-align: center;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
		}
		
		/* 닫기 버튼 */
		.close-btn {
		    float: right;
		    font-size: 20px;
		    cursor: pointer;
		    color: #aaa;
		}
		
		.close-btn:hover {
		    color: black;
		}
		
	
		
    </style>
  <script>
document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("passwordModal");
    const openModalBtn = document.getElementById("openModal");
    const closeModalBtn = document.querySelector(".close-btn");
    const changePasswordForm = document.getElementById("changePasswordForm");

    // 모달 열기
    openModalBtn.addEventListener("click", function() {
        modal.style.display = "block";
    });

    // 모달 닫기
    closeModalBtn.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // 바깥 클릭 시 모달 닫기
    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
});
document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);

    // 비밀번호 변경 성공 시 로그인 페이지로 이동
    if (urlParams.has("message") && urlParams.get("message") === "passwordChanged") {
        alert("비밀번호가 성공적으로 변경되었습니다.");
        window.location.href = "/login";
    }

    // 기존 비밀번호가 틀린 경우
    if (urlParams.has("error") && urlParams.get("error") === "wrongPassword") {
        alert("기존 비밀번호가 일치하지 않습니다.");
    }
});
document.addEventListener("DOMContentLoaded", function() {
    const newPasswordInput = document.getElementById("newPassword");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const errorMessage = document.createElement("div");
    errorMessage.style.color = "red";
    errorMessage.style.fontSize = "12px";
    confirmPasswordInput.parentNode.appendChild(errorMessage); // 입력 필드 아래에 메시지 추가

    confirmPasswordInput.addEventListener("input", function() {
        if (newPasswordInput.value !== confirmPasswordInput.value) {
            errorMessage.textContent = "새 비밀번호가 일치하지 않습니다.";
        } else {
            errorMessage.textContent = ""; // 일치하면 메시지 제거
        }
    });

    document.getElementById("changePasswordForm").addEventListener("submit", function(event) {
        if (newPasswordInput.value !== confirmPasswordInput.value) {
            event.preventDefault();
            alert("새 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
        }
    });
});

</script>

</head>
<body>
        <div class="mypage-container">
            <h1 class="title">마이페이지</h1>
        
            <form action="changePassword" method="post">
                <div class="form-group">
                    <label for="empNo">사원번호</label>
                    <input type="text" id="empNo" name="empNo" value="${emp.emp_No}" readonly>
                </div>

                <div class="form-group">
                    <label for="empName">이름</label>
                    <input type="text" id="empName" name="empName" value="${emp.empName}" readonly>
                </div>

                <div class="form-group">
                    <label for="empTel">휴대폰 번호 (-없이)</label>
                    <input type="text" id="empTel" name="empTel" value="${emp.emp_Tel}" readonly>
                </div>

                <div class="form-group">
                    <label for="username">이메일</label>
                    <input type="text" id="username" name="username" value="${emp.username}" readonly>
                    <input type="hidden" name="username" value="${emp.username}">
                </div>

                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="text" id="birth" name="birth" value="${emp.birth.substring(0,10)}" readonly>
                </div>

                <div class="form-group">
                    <label for="hiredate">입사일</label>
                    <input type="text" id="hiredate" name="hiredate" value="${emp.hiredate.substring(0,10)}" readonly>
                </div>

                <button type="button" class="password-change-btn" id="openModal">비밀번호 변경</button>
            </form>
        </div>

<!-- 비밀번호 변경 모달 -->
	<div id="passwordModal" class="modal">
	    <div class="modal-content">
	        <span class="close-btn">&times;</span>
	        <h2>비밀번호 변경</h2>
	        <form id="changePasswordForm" action="changePassword" method="post">
	    <input type="hidden" name="username" value="${emp.username}">
	    <div class="form-group">
	        <label for="oldPassword">현재 비밀번호</label>
	        <input type="password" id="oldPassword" name="oldPassword" required>
	    </div>
	    <div class="form-group">
	        <label for="newPassword">새 비밀번호</label>
	        <input type="password" id="newPassword" name="newPassword" required>
	    </div>
	    <div class="form-group">
	        <label for="confirmPassword">새 비밀번호 확인</label>
	        <input type="password" id="confirmPassword" name="confirmPassword" required>
	    </div>
	    <button type="submit" class="password-change-btn">변경하기</button>
	</form>

    </div>
</div>

</body>
</html>
