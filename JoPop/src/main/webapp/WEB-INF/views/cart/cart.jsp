<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="/resources/css/nav/nav.css">
<link rel="stylesheet" href="/resources/css/pop/cart.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>찜 페이지</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<div class="mynav">
         <ul class="nav_list">
            <li class="info"><a href="/member/mypage">내 정보</a></li>
            <li class="cart"><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
            <li class="booking"><a href="/cart/orderItem">사전예약</a></li>
         </ul>
      </div>
	<h1>찜 페이지</h1>
	
	<div class="wrapper">
	
		<div class="wrap">
		
		<!-- 찜 내의 검색창 기능 -->
	    <div class="search">
	        <form action="/cart/search" method="get" id="searchForm">
	            <input type="text" name="keyword" placeholder="지역, 팝업스토어명 키워드 검색">
	            <button class='btn search_btn'>
	                <img src="/resources/img/search.png" alt="Search">
	            </button>
	        </form>
	    </div>
		
		<!-- 찜 리스트 -->
		<div class="content_middle_section"></div>
		
		<form action="/cart/modify/${member.mId}" method="post">
		<c:forEach items="${cartInfo}" var="ci">
					<ul>
						<li><input type="hidden" value="${ci.pId}"></li>
						<li>이미지</li>
						<li class="popup-name"><a href="/pop/popsDetail?pid=${ci.pId}">${ci.pName}</a></li>
						<li class="popup-addr">${ci.pAddr1} ${ci.pAddr2}</li>
						<li class="popup-date">
							<fmt:formatDate pattern="yyyy.MM.dd" value="${ci.startDate}"/> ~
							<fmt:formatDate pattern="yyyy.MM.dd" value="${ci.endDate}"/>
						</li>
						<li class="popup-cart">
							<input type="hidden" name="pId" value="${ci.pId}">
							<button class="btn_cart" value="heart2">
								<img alt="찜 버튼" src="/resources/img/heart2.png">
							</button>
						</li>
					</ul>
		</c:forEach>
		</form>
		
		</div>
		
	<%@include file="../nav/nav.jsp"%>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
<script>
	//서버로 전송할 데이터
	const form={
			mId : '${member.mId}',
			pId : '${ci.pId}'      //pop세션 가져올 수 있게되면 '${pop.pId}' 로 변경하기
	}
	
	//찜 버튼 구현
	$(".btn_cart").on("click", function(e){
		alert("찜에서 삭제됩니다.");
		/*
		//찜 버튼의 value 값을 가져옴
		var value = $(this).val();
		
		//value값이 heart2 일때, 버튼 누르면 버튼 이미지 빈 하트 됨
		if(value == "heart2"){
			//이미지 변경 (빈 하트 이미지로)
			$(this).attr("src", "/resources/img/heart.png");
			$(this).val("heart");
		}else{
			$(this).attr("src", "/resources/img/heart2.png");
			$(this).val("heart2");
		}*/

	});
</script>
</body>
</html>