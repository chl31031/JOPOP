<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.nav{
	position: fixed;
    bottom: 0;
    width: 100%;
    height: 60px;
    background-color: #eee;
    padding-top: 40px;
    margin: 0 auto;
    text-align: center;
}
.nav li{
	display: inline-block;
	list-style: none;
	margin: 0 30px;
}
</style>
<nav>
			<ul class="nav">
				<li><a href="/main">홈</a></li>
				<li><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
				<li><a href="/pop/locations">내 주변</a></li>
				
				<li><a href="/nav/search">검색</a></li>
				
				<!-- 로그인 하지 않은 상태 -->
				<c:if test="${member == null}">
				<li><a href="/nav/prelogin">로그인</a></li>
				</c:if>
				
				<!-- 로그인 한 상태  -->
				<c:if test="${member != null}">
				<li><a href="/member/mypage">마이페이지</a></li>				
				<!-- 관리자 계정 -->
				<c:if test="${member.adminCk == 0 }"> 
                  <li><a href="/admin/main">관리자 페이지</a></li>
               </c:if>
			</c:if>	
			</ul>
		</nav>