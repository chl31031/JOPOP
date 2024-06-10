<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome JoPoP</title>
<link rel="stylesheet" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet" />
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <div class="wrapper">
        <div class="wrap">
            <!-- Main Image Area -->
            <div class="main_slick_area">
               
             	
             	<div class="slick-list">
                <!-- 1번 -->
                <div class="popupbanner_list">
                <div class="slide-contents">
                <div class="slide_img_wrap">
                <img src="/resources/eximg/poster1.jpg"alt="">
                </div>
                </div>
                </div>
                <!-- 2번 -->
                <div class="popupbanner_list">
                <div class="slide-contents">
                <div class="slide_img_wrap">
                <img src="/resources/eximg/poster2.jpg"alt="">
                </div>
                </div>
                </div>
                
                <!-- 3번 -->
                <div class="popupbanner_list">
                <div class="slide-contents">
                <div class="slide_img_wrap">
                <img src="/resources/eximg/poster3.jpg"alt="">
                </div>
                </div>
                </div>
                
                <!-- 4번 -->
                <div class="popupbanner_list">
                <div class="slide-contents">
                <div class="slide_img_wrap">
                <img src="/resources/eximg/poster4.jpg"alt="">
                </div>
                </div>
                </div>
                
                <!-- 5번 -->
                <div class="popupbanner_list">
                <div class="slide-contents">
                <div class="slide_img_wrap">
                <img src="/resources/eximg/poster5.jpg"alt="">
                </div>
                </div>
                </div>
             	
             	</div>
             	
             	
             	
            </div>

            <!-- Navigation Bar Area -->
            <div class="navi_bar_area">
               <h2>6월 진행중인 팝업</h2>
            </div>

        
<!-- Content Area -->
<div class="content_area">
    <div class="list_search_result">
        <table class="type_list">
            <tbody id="searchList">
                <c:forEach items="${list}" var="list">
                    <tr class="list">
                        <td class="image">
                                <div class="image_wrap1"
                                    data-pId="${list.imageList[0].pId}"
                                    data-path="${list.imageList[0].uploadPath}"
                                    data-uuid="${list.imageList[0].uuid}"
                                    data-filename="${list.imageList[0].fileName}">
                                    <img>
                                </div>
                        </td>
                        <td class="detail">
                            <div class="title">
                                <a href="/pop/popsDetail?pid=${list.pId}">${list.pName}</a>
                            </div>
                            <div class="address">
                                ${list.pAddr1} ${list.pAddr2}
                            </div>
                            <div class="date">
                                <fmt:formatDate value="${list.startDate}" pattern="yyyy.MM.dd"/>
                                -
                                <fmt:formatDate value="${list.endDate}" pattern="yyyy.MM.dd"/>
                            </div>
                        </td>
                        <td class="cart">
                            <div class="cart_button">
                                <form method="post">
                                    <input type="hidden" name="pId" value="${list.pId}">
                                    <img class="btn_cart" data-pid="${list.pId}" src="/resources/img/heart.png">
                                </form>
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

                <div>
                    <a href="/nav/search" class="addlink">더보기</a>
                </div>
                
               
<div class="rt_div_subject">
    <h2>담당자 PICK! 인기팝업!</h2>
</div>
<div class="rt_div">
    <c:forEach items="${rating}" var="rating">
        <a href="/pop/popsDetail?pid=${rating.pId}">
            <div class="rt_div_content_wrap">
                <div class="rt_div_content">
                    <div class="image_wrap2"
                         data-pid="${rating.imageList[0].pId}"
                         data-path="${rating.imageList[0].uploadPath}"
                         data-uuid="${rating.imageList[0].uuid}"
                         data-filename="${rating.imageList[0].fileName}">
                        <img>
                        <div class="overlay">
                            <div class="rt_pName">${rating.pName}</div>
                            <div class="rt_startDate">
                                <fmt:formatDate value="${rating.startDate}" pattern="yyyy.MM.dd"/>
                            </div>
                            <div class="rt_endDate">
                                <fmt:formatDate value="${rating.endDate}" pattern="yyyy.MM.dd"/>
                            </div>
                            <div class="rt_adress">
                                ${rating.pAddr1} ${rating.pAddr2}
                            </div>
                            <div class="rt_rating">
                                <fmt:formatNumber value="${rating.pPrice}" pattern="#,### 원" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </c:forEach>
</div>




         
           
        </div>
        </div>
   
    <%@ include file="nav/nav.jsp" %>
    <%@ include file="includes/footer.jsp" %>
    <script type="text/javascript">
    $(document).ready(function(){
        $(".slick-list").slick({
            slidesToShow: 2,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2000,
            dots: false,
            prevArrow : "<button type='button' class='slick_list_div_content_prev'><img src='/resources/img/pre.png'></button>",		// 이전 화살표 모양 설정
			nextArrow : "<button type='button' class='slick_list_div_content_next'><img src='/resources/img/next.png'></button>"		// 다음 화살표 모양 설정
        });
        	
        
    });
	$(document).ready(function(){    
    	$(".rt_div").slick({
    	slidesToShow: 3,
    	slidesToScroll: 2,
    	autoplay: true,
        autoplaySpeed: 2000,
        dots: false,
		arrows:false,
   	 });
	});

    $(document).ready(function() {
        $('.btn_cart').each(function() {
            var button = $(this);
            var pId = button.data('pid');
            var liked = sessionStorage.getItem('liked_' + pId);
            if (liked === 'true') {
                button.attr('src', '/resources/img/heart2.png');
            }
        });

        $('.btn_cart').click(function(event) {
            event.preventDefault();
            var button = $(this);
            var pId = button.data('pid');
            var liked = sessionStorage.getItem('liked_' + pId);
            var member = "${member.mId}";
            if (!member) {
                window.location.href = '/nav/prelogin';
                return;
            }

            if (liked === 'true') {
                $.post('/nav/unlike.do', { pId: pId }, function(response) {
                    button.attr('src', '/resources/img/heart.png');
                    sessionStorage.setItem('liked_' + pId, 'false');
                });
            } else {
                $.post('/nav/like.do', { pId: pId }, function(response) {
                    button.attr('src', '/resources/img/heart2.png');
                    sessionStorage.setItem('liked_' + pId, 'true');
                });
            }
        });
    });

    $(document).ready(function(){
    	 /* 이미지 삽입 */
        $(".image_wrap1").each(function(i, obj) {
            const bobj = $(obj);
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");

            if(uploadPath && uuid && fileName) {
                const filecallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "-" + fileName);
                $(this).find("img").attr('src', 'display?fileName=' + filecallPath);
            } else {
                $(this).find("img").attr('src', '/resources/img/noimage.png');
            }
        });
    	 
        $(".image_wrap2").each(function(i, obj) {
            const bobj = $(obj);
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");

            if(uploadPath && uuid && fileName) {
                const filecallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "-" + fileName);
                $(this).find("img").attr('src', 'display?fileName=' + filecallPath);
            } else {
                $(this).find("img").attr('src', '/resources/img/noimage.png');
            }
        });
    });
    </script>
</body>
</html>
