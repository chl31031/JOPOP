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
		
		<!-- 장바구니 리스트 -->
		<div class="content_middle_section"></div>
		
		<!-- 표 내용 부분 -->
		<table class="cart_table">
			<tbody>
				<c:forEach items="${cartInfo}" var="ci">
					<tr>
						<td class="td_width_1">이미지</td>
						<td class="td_width_2">${ci.pName}</td>
						<td class="td_width_3">${ci.pAddr1} ${ci.pAddr2}</td>
						<td class="td_width_4">
							<fmt:formatDate pattern="yyyy.MM.dd" value="${ci.startDate}"/> ~
							<fmt:formatDate pattern="yyyy.MM.dd" value="${ci.endDate}"/>
						</td>
						<td class="td_width_5">
							<button class="btn_cart">장바구니 버튼</button>
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		</div>
		
	<%@include file="../nav/nav.jsp"%>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
<script>
	//서버로 전송할 데이터
	const form={
			mId : "${member.mId}",
			popId : "${pop.pId}"
	}
	
	//찜 버튼 구현
	$(".btn_cart").on("click", function(e){
		$.ajax({
			url: '/cart/add/{mId}',
			type: 'POST',
			data: form,
			success: function(result){
				cartAlert(result);
			}
		})
	});
	
	function cartAlert(result){
		if(result == 0){
			alert("장바구니에 추가를 하지 못하였습니다.");
		} else if(result == 1){
			alert("장바구니에 추가되었습니다.");
		} else if(result == 2){
			alert("장바구니에 이미 추가되어져 있습니다.");
		} else if(result == 5){
			alert("로그인이 필요합니다.");	
		}
	}
	
</script>
</body>
</html>