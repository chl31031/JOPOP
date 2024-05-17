<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    header {
        display: flex;
        align-items: center;
        padding: 10px;
        background-color: #fff;
    }

    .logo {
        flex: 1;
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
    }

    .icon img {
        height: 25px;
    }
</style>

<header>
    <!-- 로고 -->
    <div class="logo">
        <a href="home.jsp">
            <img src="/resources/img/logo.png" alt="Logo">
        </a>
    </div>

    <!-- 검색창 -->
    <div class="search">
        <form action="search.jsp" method="get">
            <input type="text" name="query" placeholder="검색어를 입력하세요">
            <button type="submit">
                <img src="/resources/img/search.png" alt="Search">
            </button>
        </form>
    </div>

    <!-- 아이콘 -->
    <div class="icon">
        <a href="profile.jsp">
            <img src="/resources/img/icon.png" alt="Icon">
        </a>
    </div>
</header>
