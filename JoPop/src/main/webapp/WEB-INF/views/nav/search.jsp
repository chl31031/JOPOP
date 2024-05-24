<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome JoPoP</title>
<link rel="stylesheet" href="../resources/css/nav/search.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 페이지 로드 시 세션 스토리지에서 버튼 상태를 읽어옵니다.
    $('.btn_cart').each(function() {
        var button = $(this);
        var pId = button.data('pid');
        var liked = sessionStorage.getItem('liked_' + pId);
        if (liked === 'true') {
            button.css('background-image', 'url(/resources/img/heart1.png)');
        }
    });

    // 버튼 클릭 시 세션 스토리지에 상태를 저장하고 버튼 값 변경
    $('.btn_cart').click(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지
        var button = $(this);
        var pId = button.data('pid');
        var liked = sessionStorage.getItem('liked_' + pId);
        var member = ${member.mId};
        if (!member) {
            // prelogin 페이지로 리디렉션
            window.location.href = '/nav/prelogin'; // 실제 prelogin 페이지의 URL로 변경해주세요
            return; // 더 이상의 실행을 막습니다
        }
        
        if (liked === 'true') {
            $.post('/nav/unlike.do', { pId: pId }, function(response) {
                button.css('background-image', 'url(/resources/img/heart.png)'); // 성공 시 버튼 값 변경
                sessionStorage.setItem('liked_' + pId, 'false'); // 세션 스토리지에 상태 저장
            });
        } else {
            $.post('/nav/like.do', { pId: pId }, function(response) {
                button.css('background-image', 'url(/resources/img/heart1.png)'); // 성공 시 버튼 값 변경
                sessionStorage.setItem('liked_' + pId, 'true'); // 세션 스토리지에 상태 저장
            });
        }
    });
});
</script>
<style>
.btn_cart {
    background-image: url('/resources/img/heart.png');
    width: 30px;
    height: 30px;
    border: none;
    cursor: pointer;
}
</style>
</head>
<body>
   <%@include file="../includes/header.jsp"%>
   <div class="wrapper">
      <div class="wrap">

         <div class="navi_bar_area">
            <h1>navi area</h1>
         </div>
         <div class="content_area">
         <div class="list_search_result">
               <table class="type_list">
                  <tbody id="searchList">
                     <c:forEach items="${list}" var="list">
                        <tr class="list">
                           <td class="detail">
                              <div class="title">
                                 <a href="/goodsDetail/${list.pId}">
                                    ${list.pName}
                                 </a>
                              </div>
                              <div class=adress>
                              ${list.pAddr1}  ${list.pAddr2}
                              </div>
                              <div class="date">
                                  <fmt:formatDate value="${list.startDate}" pattern="yyyy.MM.dd"/>
                                  -
                                  <fmt:formatDate value="${list.endDate}" pattern="yyyy.MM.dd"/>
                              </div>
                           </td>
                           <td class="cart">
                              <div class="cart_button">
<<<<<<< HEAD
                                <form method="post">
                                <input type="hidden" name="pId" value="${list.pId}">
                                <input class="btn_cart" type="button" data-pid="${list.pId}">
                                </form>
=======
                               <form action="/nav/like.do" method="post">
                               <input type="hidden" name="pId" value="${list.pId}">
                               <input class="btn_cart" type="submit" value="찜하기">
                               </form>
>>>>>>> branch 'main' of https://github.com/rkawk775/JOPOP-Web.git
                              </div>
                           </td>
                           <td class="price">
                              <div class="org_price">
                                    <fmt:formatNumber value="${list.pPrice}" pattern="#,### 원" />
                              </div>
                           </td>
                           <td class="option"></td>
                        </tr>
                     </c:forEach>
                  </tbody>
               
               </table>
            </div>
      </div>
      </div>
      </div>
      
   <%@include file="../nav/nav.jsp"%>
</body>
</html>