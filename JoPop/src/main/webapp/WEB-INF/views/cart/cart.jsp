<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/cart/cart.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>관심 목록</title>
</head>
<body>
   <%@include file="../includes/header.jsp"%>
   <div class="wrap">
      <div class="mynav">
         <ul class="nav_list">
            <li class="mypage"><a href="/member/mypage">내 정보</a></li>
            <li class="cart"><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
            <li class="booking"><a href="/order/orderItem">사전예약</a></li>
         </ul>
      </div>

      <!-- 찜 내의 검색창 기능 -->
      <div class="search_like">
         <form action="/cart/search" method="get" id="searchForm">
            <input type="text" name="keyword" placeholder="지역, 팝업스토어명 키워드 검색">
            <button class="search_btn">
               <img src="/resources/img/search.png" alt="Search">
            </button>
         </form>
      </div>

      <form action="/cart/modify/${member.mId}" method="post">
         <c:choose>
            <c:when test="${empty cartInfo}">
               <h1>찜을 등록한게 없군요!</h1>
            </c:when>
            <c:otherwise>
               <div class="list_container">
                  <c:forEach items="${cartInfo}" var="ci">

                     <ul class="list_like">
                        <li class="image_wrap" data-pId = "${ci.imageList[0].pId}" data-path="${ci.imageList[0].uploadPath}" data-uuid="${ci.imageList[0].uuid}" data-filename="${ci.imageList[0].filename}">
                        	<img>
                        </li>
                        <li class="popup-name"><a
                           href="/pop/popsDetail?pid=${ci.pId}">${ci.pName}</a></li>
                        <li class="popup-addr">${ci.pAddr1}${ci.pAddr2}</li>
                        <li class="popup-date"><fmt:formatDate pattern="yyyy.MM.dd"
                              value="${ci.startDate}" /> ~ <fmt:formatDate
                              pattern="yyyy.MM.dd" value="${ci.endDate}" /></li>
                        <li class="popup-cart">
                           <input type="hidden" name="pId" value="${ci.pId}">
                           <button class="btn_cart" value="heart2">
                              <img alt="찜 버튼" src="/resources/img/heart2.png">
                           </button>
                        </li>
                        <li class="popup_li">
                            <input type="checkbox" class="individual_cart_checkbox" checked="checked">
                        	<input type="hidden" class="individual_pId_input" value="${ci.pId}"> 
                        </li>
                     </ul>

                  </c:forEach>
               </div>
               </c:otherwise>
         </c:choose>
         
         <!-- 예약/결제 버튼 -->
         <div>
            <a class="order_btn">
               <img src="/resources/img/reserve.png" style="width: 150px; float: right;">
            </a>
         </div>
      </form>

      <!-- 주문 form -->
      <form action="/order/${member.mId}" method="get" class="order_form">
   
      </form>      
      

   </div>

   <%@include file="../nav/nav.jsp"%>

   <%@include file="../includes/footer.jsp"%>

   <script>
      //서버로 전송할 데이터
      const form = {
         mId : '${member.mId}',
         pId : '${ci.pId}' //pop세션 가져올 수 있게되면 '${pop.pId}' 로 변경하기
      }
      
      $(document).ready(function(){
    	 //이미지 삽입
    	 $(".image_wrap").each(function(i,obj){
    			const bobj = $(obj);
    			
    			if(bobj.data("bookid")){
    				const uploadPath = bobj.data("path");
    				const uuid = bobj.data("uuid");
    				const fileName = bobj.data("filename");
    				
    				const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
    				
    				$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
    			} else {
    				$(this).find("img").attr('src', '/resources/img/logo.png');
    			}
    	 });
      });

      //찜 버튼 구현
      $(".btn_cart").on("click", function(e) {
         alert("찜에서 삭제됩니다.");

         //찜 버튼의 value 값을 가져옴
         var value = $(this).val();

         //value값이 heart2 일때, 버튼 누르면 버튼 이미지 빈 하트 됨
         if (value == "heart2") {
            //이미지 변경 (빈 하트 이미지로)
            $(this).attr("src", "/resources/img/heart.png");
            $(this).val("heart");
         } else {
            $(this).attr("src", "/resources/img/heart2.png");
            $(this).val("heart2");
         }

      });
      
      /* 주문 페이지 이동 */   
      $(".order_btn").on("click", function(){
         
         let form_contents ='';
         let orderNumber = 0;
         
         $(".popup_li").each(function(index, element){
        	 //alert("pop-li 되는지 보기");
            
            if($(element).find(".individual_cart_checkbox").is(":checked") === true){   //체크여부
               
               let pId = $(element).find(".individual_pId_input").val();
               
               let pId_input = "<input name='orders[" + orderNumber + "].pId' type='hidden' value='" + pId + "'>";
               form_contents += pId_input;
               
               orderNumber += 1;
            }
         });   

         $(".order_form").html(form_contents);
         $(".order_form").submit();
         
      });
   </script>
</body>
</html>