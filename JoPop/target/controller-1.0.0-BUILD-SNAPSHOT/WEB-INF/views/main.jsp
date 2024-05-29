<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome JoPoP</title>
<link rel="stylesheet" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>
    <%@include file="includes/header.jsp"%>
    <div class="wrapper">
        <div class="wrap">
            <div class="main_img_area">
                <div class="slide_div_wrap">
                    <div class="slide_div">
                        <div>
                            <a>
                                <img src="/resources/eximg/hell.png">
                            </a>
                        </div>
                        <div>
                            <a>
                                <img src="/resources/eximg/mokk.png">
                            </a>
                        </div>
                        <div>
                            <a>
                                <img src="/resources/eximg/mok1.png">
                            </a>
                        </div>
                        <div>
                            <a>
                                <img src="/resources/eximg/hello1.png">
                            </a>
                        </div>                
                    </div>    
                </div>
            </div>

            <div class="navi_bar_area">
                <h1>navi area</h1>
            </div>
            <div class="content_area">
                <h1>content area</h1>
                
            </div>
        </div>
    </div>

    <%@include file="nav/nav.jsp"%>

    <%@include file="includes/footer.jsp"%>
    <script type="text/javascript">
    $(document).ready(function(){
        $(".slide_div").slick({
            slidesToShow: 2,  // Shows 2 slides at a time
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2000,
            dots:true,
            arrows: true
        });
    });
    </script>
</body>
</html>
