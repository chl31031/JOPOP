<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/main.css">
<title>찜 페이지</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>찜 페이지</h1>
	
	<!-- ${cartInfo} 값이 넘어오는지 확인 : cartVO 정보 가져옴-->
	${cartInfo }
	
	<!-- 검색 기능(찜 목록 내에서) : 지역, 팝업 스토어명 검색 -->
	
	<!-- 진행/사전 예약 중/오픈 예정/종료 별로 카테고리 검색 -->
	
	<!-- 마켓 정보 (대표 사진, 찜 버튼(해제/다시 찜), 제목, 위치, 팝업 기간 -->
	
		<div class="wrapper">
		<div class="wrap">

		</div>

	<%@include file="../nav/nav.jsp"%>
	</div>

	<%@include file="../includes/footer.jsp"%>
</body>
</html>