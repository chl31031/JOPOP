<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 예약</title>
<link rel="stylesheet" href="../resources/css/cart/orderItem.css">
</head>
<body>
<%@include file="../includes/header.jsp"%>
   <div class="wrap">
      <div class="mynav">
         <ul class="nav_list">
            <li class="mypage"><a href="/member/mypage">내 정보</a></li>
            <li class="cart"><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
            <li class="booking"><a href="/cart/orderItem">사전예약</a></li>
         </ul>
      </div>
      <div class="orderinfo">
         <ul class="info_list">
         
         	<!-- foreach문으로 예약정보 가져오기 -->
         
         </ul>
      </div>
   </div>
      <%@include file="../nav/nav.jsp"%>

      <%@include file="../includes/footer.jsp"%>
   
</body>
</html>