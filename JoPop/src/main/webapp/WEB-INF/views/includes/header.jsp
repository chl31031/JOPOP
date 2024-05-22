<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <form action="/nav/popsearch" method="get" id="searchForm">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요">
            <button class='btn search_btn'>
                <img src="/resources/img/search.png" alt="Search">
            </button>
        </form>
    </div>

    <!-- 아이콘 -->
    <div class="icon">
        <a href="/nav/prelogin">
            <img src="/resources/img/icon.png" alt="Icon">
        </a>
    </div>
</header>

</body>
</html>
