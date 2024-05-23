<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../resources/css/member/mypage.css">
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
      <div class="myinfo">
         <ul class="info_list">
            <li>이름</li>
            <li class="b">${member.mName }</li>
            <li>닉네임</li>
            <li class="b">${member.mNick }</li>
            <li>이메일</li>
            <li class="b">${member.mEmail }</li>
            <li>주소</li>
            <li class="b">${member.mAddr1 }</li>
            <li>멤버십</li>
            <li class="b">${member.memberShip }</li>
            <li>머니</li>
            <li class="b">${member.money }</li>
            <li>내 작성 후기</li>
            <li class="b">${review.contents }</li>
         </ul>
      </div>
   </div>
      <%@include file="../nav/nav.jsp"%>

      <%@include file="../includes/footer.jsp"%>
   
</body>
</html>
