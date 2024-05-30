<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <li class="a">이름</li>
            <li class="b">${member.mName }</li>
            <li class="a">닉네임</li>
            <li class="b">${member.mNick }</li>
            <li class="a">이메일</li>
            <li class="b">${member.mEmail }</li>
            <li class="a">주소</li>
            <li class="b">${member.mAddr2} ${member.mAddr3}</li>
            <li class="a">멤버십</li>
            <li class="b">${member.memberShip }</li>
            <li class="a">머니</li>
            <li class="b">${member.money }</li>
            <li class="a">내 작성 후기</li>
            <li>
	          	<div class="section review-section">
				    <c:if test="${not empty reviews}">
				        <c:forEach var="review" items="${reviews}">
				            <div class="review">
				            	<p>팝업: ${review.pName}</p>
				                <p>내용: ${review.contents}</p>
				                <p>평점: ${review.score}</p>
				                <p>작성일: <fmt:formatDate value="${review.rDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></p>
				                <c:if test="${not empty review.imageList}">
			                <c:forEach items="${review.imageList}" var="image">
							    <img src="http://localhost:8080/pop/display?fileName=${image.uploadPath.replace("\\", "/")}/${image.uuid}_${image.fileName}" alt="이미지" style="max-width: 100px;">
							</c:forEach>
							       </c:if>
				            </div>
				            <div class="review-divider"></div>
				        </c:forEach>
				    </c:if>
				    <c:if test="${empty reviews}">
				        <p>등록된 후기가 없습니다. 첫 번째 후기를 작성해 보세요!</p>
				    </c:if>
				</div>
            </li>
         </ul>
      </div>
   </div>
      <%@include file="../nav/nav.jsp"%>

      <%@include file="../includes/footer.jsp"%>
   
</body>
</html>
