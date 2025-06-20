<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        header {
            display: flex;
            align-items: center;
            justify-content: center; /* 내용을 수평 가운데로 정렬합니다. */
            margin: 0 auto;
            text-align: center;
            padding: 10px;
            background-color: #fff;
            width: 1080px;
        }

        .logo {
            flex: 1;
            padding-right: 100px;
        }

        .logo img {
            height: 100px;
        }

        .search {
            flex: 2;
            text-align: center;
            position: relative;
            width: 300px;
        }

        .search form {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 30px;
            padding: 10px 12px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .search input[type="text"] {
            width: 80%;
            padding: 5px;
            outline: none;
            border: none;
            flex: 1;
        }

        .search button {
            background: none;
            border: none;
            padding: 0;
            margin: 0;
            cursor: pointer;
        }

        .search button img {
            height: 24px;
            width: 24px;
        }

        .icon {
            flex: 1;
            text-align: right;
            padding-right: 40px;
        }

        .icon img {
            height: 35px;
        }
    </style>
</head>
<body>

<header>
    <!-- 로고 -->
    <div class="logo">
        <a href="/main">
            <img src="/resources/img/logo.png" alt="Logo">
        </a>
    </div>

    <!-- 검색창 -->
    <div class="search">
        <form action="/nav/search" method="get" id="searchForm">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요">
            <button class='btn search_btn'>
                <img src="/resources/img/search.png" alt="Search">
            </button>
        </form>
    </div>

    <!-- 아이콘 -->
    <div class="icon">
        <c:choose>
            <c:when test="${not empty member}">
                <a href="/member/logout">
                    <img src="/resources/img/logout.png" alt="Logout">
                </a>
            </c:when>
            <c:otherwise>
                <a href="/nav/prelogin">
                    <img src="/resources/img/login.png" alt="Login">
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

</body>
</html>
