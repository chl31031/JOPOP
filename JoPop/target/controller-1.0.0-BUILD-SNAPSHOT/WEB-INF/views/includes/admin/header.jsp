<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.
* {
	margin: 0;
	padding: 0;
}

.wrapper{
	width: 900p;
}

.admin_top {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 50px;
}

.admin_top a {
	display: flex;
	align-items: center;
	text-decoration: none; /* 밑줄 제거 */
	font-size: 20px; /* 글자 크기 조절 */
	border-bottom: 2px solid #1ed760;
}

.admin_top img {
	margin-right: 10px; /* 로고와 텍스트 사이 간격 조절 */
	width: 150px;
	padding-top: 10px;
}

.admin_wrap {
	width: 900px;
	display: flex;
	flex-wrap: wrap;
}

.admin_navi_wrap {
	flex: 0 0 auto; /* 네비게이션 영역이 너비를 유지하도록 설정 */
}

.admin_navi_wrap ul {
	list-style-type: none; /* 리스트 스타일 제거 */
	padding: 0;
}

.admin_navi_wrap ul li {
	margin-bottom: 10px; /* 각 항목 사이 간격 조절 */
}

.admin_navi_wrap ul li a {
	display: block;
	padding: 15px; /* 각 링크의 패딩 조절 */
	margin: 10px;
	text-decoration: none; /* 밑줄 제거 */
	font-size: 20px; /* 글자 크기 조절 */
}

.admin_list_01 {
	border-radius: 50px;
	background-color: #ccc;
}

.admin_list_02 {
	border-radius: 50px;
	background-color: #ccc;
}

.admin_list_03 {
	border-radius: 50px;
	background-color: #ccc;
}
</style>
<div class="wrapper">
	<div class="wrap">
		<div class="admin_top">
			<a href="/admin/main"><img src="/resources/img/logo.png"
				alt="Logo">관리자 페이지</a>
		</div>
		<!-- contents-area -->
		<div class="admin_wrap">
			<!-- 네비영역 -->
			<div class="admin_navi_wrap">
				<ul>
					<li><a class="admin_list_01" href="/admin/popsEnroll">팝업/전시
							정보 등록</a></li>
					<li><a class="admin_list_02" href="/admin/popsManage">팝업/전시
							정보 관리</a></li>
					<li><a class="admin_list_03" href="/admin/memberManage">회원
							관리</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>