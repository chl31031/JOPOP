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
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <div class="wrapper">
        <div class="wrap">
            <!-- Main Image Area -->
            <div class="main_img_area">
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

            <!-- Navigation Bar Area -->
            <div class="navi_bar_area">
                <h1>navi area</h1>
            </div>

            <!-- Content Area -->
            <div class="content_area">
                <div class="list_search_result">
                    <table class="type_list">
                        <tbody id="searchList">
                            <c:forEach items="${list}" var="list">
                                <tr class="list">
                                    <td class="image">
                                        <div class="image_wrap"
                                            data-pId="${list.imageList[0].pId}"
                                            data-path="${list.imageList[0].uploadPath}"
                                            data-uuid="${list.imageList[0].uuid}"
                                            data-filename="${list.imageList[0].fileName}">
                                            <img>
                                        </div>
                                    </td>
                                    <td class="detail">
                                        <div class="title">
											<a href="/pop/popsDetail?pid=${list.pId}"> ${list.pName}
											</a>
										</div>
                                        <div class="adress">
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
                <div>
                    <a href="/nav/search" class="addlink">더보기</a>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="nav/nav.jsp" %>
    <%@ include file="includes/footer.jsp" %>
    <script type="text/javascript">
    $(document).ready(function(){
        $(".slide_div").slick({
            slidesToShow: 2,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2000,
            dots: true,
            arrows: true
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
        const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
        if(selectedType != ""){
            $("select[name='type']").val(selectedType).attr("selected", "selected");    
        }

        $(".image_wrap").each(function(i, obj) {
            const bobj = $(obj);
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");
            const filecallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "-" + fileName);
            $(this).find("img").attr('src', 'display?fileName=' + filecallPath);
        });
    });
    </script>
</body>
</html>
