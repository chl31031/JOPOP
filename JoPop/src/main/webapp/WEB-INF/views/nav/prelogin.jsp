<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prelogin Page</title>
</head>
<body>
    <h1>Prelogin Page</h1>
    <!-- 로그인 버튼 -->
    <form action="/member/login" method="get">
        <input type="submit" value="로그인">
    </form>

    <!-- 회원가입 버튼 -->
    <form action="/member/join" method="get">
        <input type="submit" value="회원가입">
    </form>
</body>
</html>
