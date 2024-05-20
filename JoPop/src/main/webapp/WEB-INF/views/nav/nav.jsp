<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="resources/css/nav/nav.css">
<nav>
			<ul class="nav">
				<li><a href="/main">홈</a></li>
				<li><a href="/cart/cart">관심 팝업</a></li>
				<li><a href="#">내 주변</a></li>
				<li><a href="#">검색</a></li>
				
				<!-- 로그인 하지 않은 상태 -->
				<c:if test="${member == null}">
				<li><a href="/nav/prelogin">로그인</a></li>
				</c:if>
				
				<!-- 로그인 한 상태  -->
				<c:if test="${member != null}">
				<li><a href="/nav/mypage">마이페이지</a></li>
				</c:if>
				
			</ul>
		</nav>