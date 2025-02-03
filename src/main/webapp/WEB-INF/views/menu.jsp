<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<c:url value='/css/menu.css' />">
<link rel="stylesheet" href="<c:url value='/js/menu.js' />">
<div class="sidebar">
    <div class="logo">로고 자리</div>
    <div class="search-bar">
        <input id="search" type="text" placeholder="필터 메뉴 검색" placeholder="필터 메뉴 검색" onfocus="clearPlaceholder()" onblur="restorePlaceholder()">
        <img src="../image/search.png" alt="아이콘3" class="icon1">
    </div>

    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer1">
        <label for="answer1">게시판<em></em></label>
        <div class="submenu">
            <p>공지사항</p>
            <p>자유게시판</p>
        </div>
    </div>
    <hr>
    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer2">
        <label for="answer2">물류 관리<em></em></label>
        <div class="submenu">
            <p>입고 조회</p>
            <p>입고 예정 리스트</p>
            <p>출고 조회</p>
            <p>출고 예정 리스트</p>
        </div>
    </div>

    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer3">
        <label for="answer3">발주 / 수주 관리<em></em></label>
        <div class="submenu">
            <p>발주 조회</p>
            <p>발주 등록</p>
            <p>수주 조회</p>
            <p>수주 등록</p>
        </div>
    </div>
    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer4">
        <label for="answer4">거래처 관리<em></em></label>
        <div class="submenu">
            <p><a href="listClient">거래처 조회</a></p>
            <p><a href="writeFormClient">거래처 등록</a></p>
        </div>
    </div>
    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer5">
        <label for="answer5">제품 관리<em></em></label>
        <div class="submenu">
            <p>제품 조회</p>
            <p>제품 등록</p>
        </div>
    </div>
    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer6">
        <label for="answer6">인사 관리<em></em></label>
        <div class="submenu">
            <p><a href="listEmp">직원 조회</a></p>
            <p><a href="writeFormEmp">직원 등록</a></p>
        </div>
    </div>

    <hr>

    <div class="menu-item">
        <input type="checkbox" name="menu-item" id="answer7">
        <label for="answer7">채팅<em></em></label>
        <div class="submenu">
            <p><a href="chat">1:1 채팅</a></p>
        </div>
    </div>
</div>