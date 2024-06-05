<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.nav {
	position: fixed;
	bottom: 0;
	width: 100%;
	height: 80px;
	background-color: #eee;
	margin: 0 auto;
	text-align: center;
	padding: 20px;
	display: flex; /* 아이템을 행으로 배치합니다 */
	justify-content: space-around; /* 아이템 사이의 공간을 균등하게 배분합니다 */
	align-items: center;
	height: 80px; /* 아이템을 수직으로 정렬합니다 */
}

.nav a {
	width: 100px;
	margin: 0 10px;
	display: block;
	text-decoration: none;
	margin-left: -50px;
}

.nav_list {
	display: flex;
	justify-content: space-around; /* 아이템 사이의 공간을 균등하게 배분합니다 */
	align-items: center;
	list-style: none;
	padding: 0;
	margin: 0;
	max-width: 900px; /* 네비게이션 리스트의 최대 너비를 900px로 설정합니다 */
	width: 100%; /* 네비게이션 리스트의 너비를 100%로 설정합니다 */
}

.nav img {
	width: 30px; /* 이미지 너비 설정 */
	height: auto; /* 이미지 높이를 자동으로 조정하여 원래 비율 유지 */
}

.nav span {
	display: block; /* 텍스트를 블록 요소로 변경하여 각 요소를 새로운 줄에 표시합니다 */
	color: black;
}
</style>
<nav>
	<div class="nav">
		<ul class="nav_list">
			<li><a href="/main"><img src="/resources/img/home.png"><span>홈</span></a></li>
			<li><a href="/cart/cart/${member.mId}"><img
					src="/resources/img/cart.png"><span>관심팝업</span></a></li>
			<li><a href="/pop/locations"><img src="/resources/img/map.png"><span>내
						주변</span></a></li>
			<li><a href="/nav/search"><img
					src="/resources/img/search.png"><span>팝업 찾기</span></a></li>

			<!-- 로그인 하지 않은 상태 -->
			<c:if test="${member == null}">
				<li><a href="/nav/prelogin"><img
						src="/resources/img/icon.png"><span>로그인</span></a></li>
			</c:if>
			<!-- 로그인 한 상태 -->
			<c:if test="${member != null}">
				<!-- 관리자 계정 확인 -->
				<c:choose>
					<c:when test="${member.adminCk == 0}">
						<!-- 관리자일 경우 -->
						<li><a href="/admin/main"><img
								src="/resources/img/system.png"><span>관리자페이지</span></a></li>
					</c:when>
					<c:otherwise>
						<!-- 일반 회원일 경우 -->
						<li><a href="/member/mypage"><img
								src="/resources/img/icon.png"><span>마이페이지</span></a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</div>
</nav>