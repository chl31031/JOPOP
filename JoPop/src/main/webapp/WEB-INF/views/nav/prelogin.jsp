<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prelogin Page</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

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

body {
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

h1 {
	padding: 10px;
}

.wrap {
	width: 1080px;
	margin: auto;
}

.join {
	width: 100%;
	height: 130px;
	/* background-color: #4682b4; */
	padding: 70px 0;
}

.login {
	width: 100%;
	height: 130px;
	/* background-color: #e6e6fa; */
	padding: 70px 0;
}
.jBtn{
	width: 300px;
	height: 50px;
	border-radius: 15px;
	border-width: thin; 
	cursor: pointer;
	background-color: #1ed760;
	text: ;
}
.lBtn{
	width: 300px;
	height: 50px;
	border-radius: 15px;
	border-width: thin;
	cursor: pointer;
}
</style>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<%--<h1>Prelogin Page</h1> --%>

	<div class="wrap">


		<!-- 회원가입 버튼 -->
		<form action="/member/join" method="get" class="join">
			<h5>회원이 아니시라면,</h5><br>
			<input type="submit" value="회원가입" class="jBtn">
		</form>

		<!-- 로그인 버튼 -->
		<form action="/member/login" method="get" class="login">
			<h5>이미 가입한 아이디가 있다면,</h5><br>
			<input type="submit" value="로그인" class="lBtn">
		</form>


	</div>

	<%@include file="../nav/nav.jsp"%>

	<%@include file="../includes/footer.jsp"%>
</body>
</html>
