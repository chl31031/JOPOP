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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>찜 페이지</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>찜 페이지</h1>
	
	<!-- ${cartInfo} 값이 넘어오는지 확인 : cartVO 정보 가져옴-->
	
	<!-- 검색 기능(찜 목록 내에서) : 지역, 팝업 스토어명 검색 -->
	
	<!-- 진행/사전 예약 중/오픈 예정/종료 별로 카테고리 검색 -->
	
	<!-- 마켓 정보 (대표 사진, 찜 버튼(해제/다시 찜), 제목, 위치, 팝업 기간 -->
	
	<div class="wrapper">
	
		<div class="wrap">
		
		<a href="/"><h2>내 정보</h2></a>
		<a href="/cart/cart/${member.mId}"><h2>관심 팝업</h2></a>
		<a href="/cart/orderItem"><h2>내 예약</h2></a>
		
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
							<button class="btn_cart">장바구니 버튼</button>
						</li>
					</ul>
		</c:forEach>
		
		
		</div>
		
	<%@include file="../nav/nav.jsp"%>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
<script>
	//서버로 전송할 데이터
	const form={
			mId : '${member.mId}',
			popId : 37      //pop세션 가져올 수 있게되면 '${pop.pId}' 로 변경하기
	}
	
	//찜 버튼 구현
	$(".btn_cart").on("click", function(e){
		alert("=======================");
		$.ajax({
			url: '/cart/add',
			type: 'POST',
			data: form,
			success: function(result){
				console.log("동작 확인");
				cartAlert(result);
			},
			complete: function(result){
				console.log("콘솔 로그");
			},
		})
	});
	
	function cartAlert(result){
		if(result == '0'){
			alert("장바구니에 추가를 하지 못하였습니다.");
		} else if(result == '1'){
			alert("장바구니에 추가되었습니다.");
		} else if(result == '2'){
			alert("장바구니에 이미 추가되어져 있습니다.");
		} else if(result == '5'){
			alert("로그인이 필요합니다.");	
		}
	}
	
	/*제대로된 기능
	function cartFun(result){
		if(result == '1'){    //카트 다시 추가
			alert("찜에 추가되었습니다.");
		}else if(result == '2'){   //카트에서 삭제 (찜 이미 추가되어 있음)
			alert("찜에서 삭제합니다.");  
			$.ajax({
				url: '/cart/delete',
				type: 'POST',
				data: form,
				success: function(result){
					console.log("삭제 동작 확인");
					if(result == '0'){
						alert("찜 삭제 실패");
					}else if(result == '1'){
						alert("찜 삭제 완료");
					}
				},
				complete: function(result){
					console.log("삭제 동작 로그");
				},
			})
		}
	}*/
	
</script>
</body>
</html>