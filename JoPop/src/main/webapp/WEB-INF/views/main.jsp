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
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<script type="text/javascript">
$(document).ready(function() {
    // 페이지 로드 시 세션 스토리지에서 버튼 상태를 읽어옵니다.
    $('.btn_cart').each(function() {
        var button = $(this);
        var pId = button.data('pid');
        var liked = sessionStorage.getItem('liked_' + pId);
        if (liked === 'true') {
            button.attr('src', '/resources/img/heart2.png');
        }
    });

    // 버튼 클릭 시 세션 스토리지에 상태를 저장하고 버튼 값 변경
    $('.btn_cart').click(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지
        var button = $(this);
        var pId = button.data('pid');
        var liked = sessionStorage.getItem('liked_' + pId);
        var member = "${member.mId}";
        if (!member) {
            // prelogin 페이지로 리디렉션
            window.location.href = '/nav/prelogin'; // 실제 prelogin 페이지의 URL로 변경해주세요
            return; // 더 이상의 실행을 막습니다
        }
        
        if (liked === 'true') {
            $.post('/nav/unlike.do', { pId: pId }, function(response) {
                button.attr('src', '/resources/img/heart.png'); // 성공 시 버튼 값 변경
                sessionStorage.setItem('liked_' + pId, 'false'); // 세션 스토리지에 상태 저장
            });
        } else {
            $.post('/nav/like.do', { pId: pId }, function(response) {
                button.attr('src', '/resources/img/heart2.png'); // 성공 시 버튼 값 변경
                sessionStorage.setItem('liked_' + pId, 'true'); // 세션 스토리지에 상태 저장
            });
        }
    });
});

$(document).ready(function(){
	// 검색 타입 selected
	const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
	if(selectedType != ""){
		$("select[name='type']").val(selectedType).attr("selected", "selected");	
	}
	
	/* 이미지 삽입 */
	$(".image_wrap").each(function(i, obj) {
		const bobj = $(obj);
		
		const uploadPath = bobj.data("path");
		const uuid = bobj.data("uuid");
		const fileName = bobj.data("filename");
		
		const filecallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "-" + fileName);
		
		$(this).find("img").attr('src', 'display?fileName=' + fileCallPath);
		
	});
	
});
</script>
</body>
</html>
