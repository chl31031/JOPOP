<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.nav {
	position: fixed;
	bottom: 0;
	width: 100%;
	height: 60px;
	background-color: #eee;
	padding-top: 40px;
	margin: 0 auto;
	text-align: center;
}

.nav li {
	display: inline-block;
	list-style: none;
	margin: 0 30px;
}
</style>
<nav>
	<ul class="nav">
		<li><a href="/main">메인 페이지</a></li>
		<li><a href="/member/logout.do">로그아웃</a></li>
	</ul>
</nav>