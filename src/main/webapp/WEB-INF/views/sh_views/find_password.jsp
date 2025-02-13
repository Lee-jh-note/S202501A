<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>비밀번호 찾기</title>

    <!-- Custom fonts for this template-->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../css1/sb-admin-2.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
    $(document).ready(function () {
        $("#sendTempPasswordBtn").click(function () {
            var empName = $("#empName").val();
            var empEmail = $("#empEmail").val();
            var button = $("#sendTempPasswordBtn");

            if (!empName || !empEmail) {
                alert("이름과 이메일을 입력하세요.");
                return;
            }

            // 버튼을 "보내는 중..."으로 변경하고 비활성화
            button.prop("disabled", true).text("검사중...");

            $.ajax({
                type: "POST",
                url: "/sendTemporaryPassword",
                data: { empName: empName, empEmail: empEmail },
                success: function (response) {
                    alert(response.message); // ✅ 이메일 전송 성공 메시지
                    window.location.href = "/login"; // ✅ 확인 누르면 로그인 페이지 이동
                },
                error: function (xhr) {
                    alert(xhr.responseJSON.message); // ❌ 에러 메시지 출력
                },
                complete: function () {
                    // 완료 후 버튼 원래 상태로 복구
                    button.prop("disabled", false).text("임시 비밀번호 받기");
                }
            });
        });
    });
</script>


	
</head>

<body class="bg-gradient-primary">
    <div class="container">
        <!-- Outer Row -->
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">임시 비밀번호 찾기</h1>
                                        <p class="mb-4">본인의 성명과 이메일을 정확히 입력해주세요</p>
                                    </div>
                                    <form class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="empName" aria-describedby="emailHelp"
                                                placeholder="이름을 적어주세요" name="empName"><br>
                                                
                                            <input type="text" class="form-control form-control-user"
                                                id="empEmail" aria-describedby="emailHelp"
                                                placeholder="이메일을 적어주세요" name="empEmail">
                                        </div>
                                         <button type="button" id="sendTempPasswordBtn" class="btn btn-primary btn-user btn-block">임시 비밀번호 받기</button>             
                                    </form>
                                    <hr>
                        			임시 비밀번호를 받고 빠른 시일 내에 비밀 번호 변경해주세요
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>