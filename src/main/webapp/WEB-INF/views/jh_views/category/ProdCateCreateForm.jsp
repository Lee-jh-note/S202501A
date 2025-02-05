<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Form</title>

    <!-- Bootstrap CSS for modal and dropdown -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery (required for Bootstrap's JavaScript) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .bt1 {
            padding: 8px 12px;
            font-size: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4e73df;
            color: white;
        }
        .bt{
            padding: 8px 12px;
            font-size: 12px;
            background-color: #1c294e;
            border: none;

        }
    </style>
</head>
<body>

<div class="container">
    <h2>분류 등록</h2>
    <form action="/Prod/Category/Create" method="post">
        <!-- 대분류 입력 필드 -->
        <div class="form-group">
            <label for="category">대분류 선택</label>
            <select id="category" name="top_category" class="form-control" onchange="updateTitle()">
                <!-- 대분류 목록 동적으로 추가 -->
                <c:forEach var="category" items="${top_list}">
                    <!-- value는 top_category, data-title에 category.title을 저장 -->
                    <option value="${category.top_category}" data-title="${category.title}">${category.title}</option>
                </c:forEach>
            </select>
            <!-- hidden 필드에 선택된 title을 저장 -->
            <input type="hidden" id="category_title" name="title">
        </div>

        <div class="form-group">
            <label for="mid_category">중분류 입력</label>
            <input type="text" class="form-control" id="mid_category" name="content" required="">
        </div>

        <div class="form-group mt-3">
            <button type="submit" class="bt btn btn-primary">저장</button>
<button type="button" class="bt1 btn btn-secondary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">대분류 및 중분류 등록</button>
        </div>
    </form>
</div>

<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">대분류 및 중분류 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <label for="newTopCategory">대분류 입력</label>
                <input type="text" class="form-control" id="newTopCategory" name="newTopCategory" required="">

                <label for="newMidCategoryModal" class="mt-2">중분류 입력</label>
                <input type="text" class="form-control" id="newMidCategoryModal" name="newMidCategoryModal" required="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="saveCategoryBtn">저장</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 새로운 대분류 및 중분류 저장
        $('#saveCategoryBtn').click(function(event) {
            event.preventDefault();  // 폼 제출 막기 (AJAX로만 처리)

            var newTopCategory = $('#newTopCategory').val();
            var newMidCategory = $('#newMidCategoryModal').val(); // 모달에서 가져오는 중분류 이름

            // 값이 비어있는지 체크
            if (!newTopCategory || !newMidCategory) {
                alert('대분류와 중분류 이름을 모두 입력해주세요.');
                return;
            }

            $.ajax({
                type: 'POST',
                url: '/Prod/Category/add',
                data: {
                    newTopCategory: newTopCategory,
                    newMidCategory: newMidCategory
                },
                success: function(response) {
                    alert("추가되었습니다");

                    // 새로 추가된 대분류를 드롭다운에 추가
                    var newOption = $('<option>', { value: newTopCategory, text: newTopCategory });
                    $('#category').append(newOption);

                    // 입력 필드 초기화
                    $('#newTopCategory').val('');
                    $('#newMidCategoryModal').val(''); // 모달의 중분류 필드 초기화
                    $('#addCategoryModal').modal('hide');  // 모달 닫기

                    // 리스트 페이지로 리다이렉션
                    window.location.href = '/Prod/Category/Create';  // 리스트 페이지로 이동
                },
                error: function(xhr, status, error) {
                    alert("오류 발생: " + error);
                }
            });
        });
    });

    // onchange 이벤트로 선택된 항목의 title을 hidden 필드에 저장
    function updateTitle() {
        var selectedOption = document.querySelector('#category option:checked');
        document.getElementById('category_title').value = selectedOption.getAttribute('data-title');
    }

    // 페이지 로드 시에도 선택된 title을 초기화
    document.addEventListener('DOMContentLoaded', function () {
        updateTitle();
    });
</script>

</body>
</html>
