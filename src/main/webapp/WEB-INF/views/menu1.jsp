<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 메뉴바 시작 -->
<!-- Sidebar -->
<ul class="navbar-nav sidebar sidebar-dark accordion" style="background-color: #395B7F;" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/mainPage">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-fw fa-box"></i>
        </div>
        <div class="sidebar-brand-text mx-3">erp <sup>a</sup></div>
    </a>

<%--    메뉴 : 게시판/ 물류관리,발주 수주관리, 거래처관리, 제품관리, 인사관리/채팅 --%>
    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- 게시판 메뉴 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseBoard"
           aria-expanded="true" aria-controls="collapseBoard">
            <i class="fas fa-fw fa-clipboard"></i>
            <span>게시판</span>
        </a>
        <div id="collapseBoard" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">게시판:</h6>
                <a class="collapse-item" href="/All/Management/NoticeList">공지 게시판</a>
                <a class="collapse-item" href="/All/Management/BoardList">자유 게시판</a>
            </div>
        </div>
    </li>

    <!-- 구분선 -->
    <hr class="sidebar-divider">

    <!-- 물류관리 메뉴 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePurSalDetail"
           aria-expanded="true" aria-controls="collapsePurSalDetail">
            <i class="fas fa-fw fa-truck"></i>
            <span>물류 관리</span>
        </a>
        <div id="collapsePurSalDetail" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">입고:</h6>
                <a class="collapse-item" href="/All/Logistics/listPurchaseDetailPlan">입고 예정 리스트</a>
                <a class="collapse-item" href="/All/Logistics/listPurchaseDetail">입고 조회</a>
                <a class="collapse-item" href="/All/Logistics/listPurchaseDetailNo">미입고 조회</a>
                <div class="collapse-divider"></div>
                <h6 class="collapse-header">출고:</h6>
                <a class="collapse-item" href="/All/Logistics/listPreSalesDetails">출고 예정 리스트</a>
                <a class="collapse-item" href="/All/Logistics/listGoSalesDetails">출고 조회</a>
                <a class="collapse-item" href="/All/Logistics/listNoSalesDetails">미출고 조회</a>
            </div>
        </div>
    </li>

    <!-- 발주/수주 관리 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePurSal"
           aria-expanded="true" aria-controls="collapsePurSal">
            <i class="fas fa-fw fa-calendar-check"></i>
            <span>발주/수주 관리</span>
        </a>
        <div id="collapsePurSal" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">발주:</h6>
                <a class="collapse-item" href="/Sales/insertFormPurchase">발주 등록</a>
                <a class="collapse-item" href="/All/Sales/listPurchase">발주 조회</a>
                <div class="collapse-divider"></div>
                <h6 class="collapse-header">수주:</h6>
                <a class="collapse-item" href="/Sales/createSales">수주 등록</a>
                <a class="collapse-item" href="/All/Sales/listSales">수주 조회</a>
            </div>
        </div>
    </li>

    <!-- 거래처 관리 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseClient"
           aria-expanded="true" aria-controls="collapseClient">
            <i class="fas fa-fw fa-city"></i>
            <span>거래처 관리</span>
        </a>
        <div id="collapseClient" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">거래처:</h6>
                <a class="collapse-item" href="/All/Sales/listClient">거래처 조회</a>
                <a class="collapse-item" href="/Sales/writeFormClient">거래처 등록</a>
            </div>
        </div>
    </li>

    <!-- 제품관리 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProduct"
           aria-expanded="true" aria-controls="collapseProduct">
            <i class="fas fa-fw fa-box"></i>
            <span>제품 관리</span>
        </a>
        <div id="collapseProduct" class="collapse" aria-labelledby="headingUtilities"
             data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">제품:</h6>
                <a class="collapse-item" href="/All/Sales/ProdList">제품 조회</a>
                <a class="collapse-item" href="/Sales/ProdCreate">제품 등록</a>
                <a class="collapse-item" href="/All/Sales/PriceList">가격 변동 내역</a>
                <a class="collapse-item" href="/All/Logistics/InvenList">재고 관리</a>
                <a class="collapse-item" href="/All/Recodes/List">실적 관리</a>
            </div>
        </div>
    </li>

    <!-- 인사관리 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEmp"
           aria-expanded="true" aria-controls="collapseEmp">
            <i class="fas fa-fw fa-user-tie"></i>
            <span>인사 관리</span>
        </a>
        <div id="collapseEmp" class="collapse" aria-labelledby="headingUtilities"
             data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">인사:</h6>
                <a class="collapse-item" href="/All/HR/listEmp">직원 조회</a>
                <a class="collapse-item" href="/HR/writeFormEmp">직원 등록</a>
                <a class="collapse-item" href="/All/HR/listDept3">부서 조회</a>
                <a class="collapse-item" href="/HR/writeFormDept">부서 등록</a>

            </div>
        </div>
    </li>

    <!-- 구분선 -->
    <hr class="sidebar-divider">

    <!-- 채팅 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseChat"
           aria-expanded="true" aria-controls="collapseChat">
            <i class="fas fa-fw fa-comments"></i>
            <span>채팅</span>
        </a>
        <div id="collapseChat" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">채팅:</h6>
                <a class="collapse-item" href="/chat">채팅</a>
            </div>
        </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- 화살표 버튼. 누르면 메뉴바 축소 -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->
<!-- 메뉴바 끝 -->
