<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="/../vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/../css1/sb-admin-2.min.css" rel="stylesheet">
    <link href="/../css/detail.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../../menu1.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="../../header1.jsp" %>

            <div class="detail-wrapper">

                <div class="detail-header">
                    <div>
                        <div class="detail-submenu">제품 관리 > 제품 상세</div>
                        <div class="detail-title">
                            <div></div>
                            <h1>제품 상세</h1>
                        </div>
                    </div>
                </div>
                <div class="detail-header-content">
                    <table class="detail-table">
                        <tr>
                            <th>제품 번호</th>
                            <td>${ProductPrice.product_no}</td>
                            <th>제품 이름</th>
                            <td>${ProductPrice.product_name}</td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td>${ProductPrice.status == 1 ? '활성화' : '비활성화'}</td>
                            <th>등록일</th>
                            <td><fmt:formatDate value="${ProductPrice.reg_date}" pattern="yy/MM/dd"/></td>
                        </tr>
                        <tr>
                            <th>대분류</th>
                            <td>${ProductPrice.title}</td>
                            <th>중분류</th>
                            <td>${ProductPrice.content}</td>
                        </tr>
                        <tr>
                            <th>판매가</th>
                            <td><fmt:formatNumber value="${ProductPrice.sale_price}" pattern="#,###"/></td>
                            <th>구매가</th>
                            <td><fmt:formatNumber value="${ProductPrice.pur_price}" pattern="#,###"/></td>
                        </tr>
                        <tr style="height: 200px;">
                            <th colspan="1">상세</th>
                            <td colspan="3">${ProductPrice.description}</td>
                        </tr>
                    </table>

                    <div class="detail-buttons">
                        <a href="/All/Sales/ProdList" class="btn btn-facebook">돌아가기</a>
                        <a href="/Sales/ProdModify?productNo=${ProductPrice.product_no}"
                           class="btn btn-dark">수정</a>
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal"
                                data-product-no="${ProductPrice.product_no}">
                            삭제
                        </button>
                    </div>
                    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
                         aria-labelledby="deleteModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    진짜 지울거니?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                    <!-- 삭제 확인 버튼 -->
                                    <form id="deleteForm" action="/Sales/ProdDelete" method="post"
                                          style="display:inline;">
                                        <input type="hidden" name="product_no" id="modalProductNo">
                                        <button type="submit" class="btn btn-danger">삭제</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../../footer1.jsp" %>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $('#deleteModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 클릭된 버튼
        var productNo = button.data('product-no'); // 버튼에 저장된 product_no 데이터 가져오기
        var modal = $(this);
        modal.find('#modalProductNo').val(productNo); // 모달의 hidden input에 값 설정
    });
</script>
</body>
</html>
