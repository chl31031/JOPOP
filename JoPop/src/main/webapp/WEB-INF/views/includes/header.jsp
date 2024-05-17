<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
               <div class="clearfix"></div>
            </div>

<header style="display: flex; align-items: center; padding: 10px; background-color: #f8f9fa;">
    <!-- 로고 -->
    <div style="flex: 1;">
        <a href="home.jsp">
            <img src="/resources/img/logo.png" alt="JoPop Logo" style="height: 50px;">
        </a>
    </div>

    <!-- 검색창 -->
    <div style="flex: 2; text-align: center;">
        <form action="search.jsp" method="get" style="display: inline-block; width: 100%;">
            <input type="text" name="query" placeholder="검색어를 입력하세요" style="width: 80%; padding: 5px;">
            <button type="submit" style="padding: 5px 10px;">Search</button>
        </form>
    </div>

    <!-- 아이콘 -->
    <div style="flex: 1; text-align: right;">
        <a href="profile.jsp">
            <img src="/resources/img/icon.png" alt="Icon" style="height: 40px;">
        </a>
    </div>
</header>