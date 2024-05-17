<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="resources/css/main.css">
</head>
<body>
	<%@include file="includes/header.jsp"%>
	<div class="wrapper">
		<div class="wrap">
			<div class="main_img_area">
				<h1>img area</h1>
			</div>

			<div class="navi_bar_area">
				<h1>navi area</h1>
			</div>
			<div class="content_area">
				<h1>content area</h1>
			</div>
		</div>

		<nav>
			<ul class="nav">
				<li><a href="/main">홈</a></li>
				<li><a href="/cart/cart">관심 팝업</a></li>
				<li><a href="#">내 주변</a></li>
				<li><a href="#">검색</a></li>
				<li><a href="/nav/prelogin">마이페이지</a></li>
			</ul>
		</nav>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>