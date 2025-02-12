<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto d-flex align-items-center">
        <li class="nav-item">
            반갑습니다.&nbsp;<span class="nav-item" id="userName" style="font-weight: bold; color: black"></span>&nbsp;님
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/chat" role="button">
                <i class="fas fa-comment-dots fa-fw"></i>
            </a>
        </li>
        <li class="nav-item" style="border-right: 2px solid #ddd; height: 1.5em; display: flex; align-items: center;">
            <a href="/mypage" class="nav-link">
                <i class="fas fa-user"></i>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-toggle="modal" data-target="#logoutModal">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </li>
    </ul>

</nav>

<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">로그아웃 확인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                정말 로그아웃 하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 12px;">취소
                </button>
                <a href="/logout" type="button" class="btn btn-danger" style="font-size: 12px;">로그아웃</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $.ajax({
        url: '/headerData',
        type: 'GET',
        success: function (data) {
            $('#userName').text(data);
        },
        error: function (xhr, status, error) {
            console.error('데이터를 가져오는 중 오류 발생:', error);
        }
    });
</script>
