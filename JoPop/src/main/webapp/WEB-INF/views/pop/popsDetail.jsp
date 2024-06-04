<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/nav/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pop/pop.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css"/>
    <meta charset="UTF-8">
    <title>상세 페이지</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8miqdnp9yh"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
</head>
<body>
    <%@ include file="../includes/header.jsp" %> <!-- 헤더 -->

    <div class="container">
        <!-- 배너 섹션 -->
        <div class="banner">
            <div class="slider">
                <div><img src="<%=request.getContextPath()%>/resources/eximg/hell.png" alt="배너 이미지"></div>
                <div><img src="<%=request.getContextPath()%>/resources/eximg/hello.png" alt="배너 이미지1"></div>
                <div><img src="<%=request.getContextPath()%>/resources/eximg/mokk.png" alt="배너 이미지2"></div>
                <div><img src="<%=request.getContextPath()%>/resources/eximg/mok.png" alt="배너 이미지3"></div>
                <div><img src="<%=request.getContextPath()%>/resources/eximg/mok1.png" alt="배너 이미지4"></div>
                <div><img src="<%=request.getContextPath()%>/resources/eximg/hello1.png" alt="배너 이미지4"></div>
            </div>
            <!-- 찜 추가/삭제 버튼 -->
            <button id="heartIcon" class="btn_cart">
                <img src="${pageContext.request.contextPath}/resources/img/heart.png" alt="찜 아이콘" id="heartImage">
            </button>
        </div>

        <div class="content">
            <div class="section">
                <h2 class="styled-heading">운영 시간</h2>
                <p>${popsInfo.pIntro}</p>
            </div>
            <div class="section">
                <h2 class="styled-heading">안내 및 주의 사항</h2>
                <p>1인 1회 예약 가능합니다.</p>
                <p>일정 변동 시 즉시 변경 및 취소 부탁드리며, 노쇼는 자제 부탁드립니다.</p>
                <p>현장 대기 후 입장도 가능합니다. 상황에 따라 입장이 지연될 수 있는 점 참고 바랍니다.</p>
            </div>
            <div class="section">
                <h2 class="styled-heading">상품 상세 정보</h2>
                <c:if test="${not empty popsInfo}">
                    <p>내용: ${popsInfo.pContents}</p>
                </c:if>
            </div>
            <div class="section">
                <h2 class="styled-heading">찾아오시는 길</h2>
                <div id="map" style="width: 100%; height: 400px;"></div>
            </div>
            <div class="section review-section">
                <h2>후기</h2>
                <c:if test="${not empty reviews}">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review">
                            <p>작성자: 
                              <c:choose>
                                    <c:when test="${fn:length(review.mNick) > 1}">
                                        ${fn:substring(review.mNick, 0, 1)}**
                                    </c:when>
                                    <c:otherwise>
                                        ${review.mNick}
                                    </c:otherwise>
                                </c:choose>
                            </p> 
                            <p>내용: ${review.contents}</p>
                            <p>평점: 
                                <c:forEach var="i" begin="1" end="${review.score}">
                                    <span style="color: gold;">★</span>
                                </c:forEach>
                                <c:forEach var="i" begin="${review.score + 1}" end="5">
                                    <span style="color: lightgray;">★</span>
                                </c:forEach>
                            </p>
                            <p>작성일: <fmt:formatDate value="${review.rDate}" pattern="yyyy년 M월 d일 HH시 m분 ss초" /></p>
                            <c:if test="${not empty review.imageList}">
                                <c:forEach items="${review.imageList}" var="image">
                                    <img src="${pageContext.request.contextPath}/pop/display?fileName=${image.uploadPath.replace('\\', '/')}/${image.uuid}_${image.fileName}" alt="이미지" style="max-width: 100px;">
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="review-divider"></div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty reviews}">
                    <div class="login-message">
                        <p>등록된 후기가 없습니다. 첫 번째 후기를 작성해 보세요!</p>
                    </div>
                </c:if>
            </div>

            <p style="text-align: center; position: relative; top: 20px;">클릭해서 별점을 매겨주세요!</p>
            <div class="rating">
                <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
            </div>
            <div id="uploadResult"></div>
            <form class="review-form" id="reviewForm" enctype="multipart/form-data">
                <input type="hidden" name="pId" value="${popsInfo.pId}">
                <textarea name="contents" placeholder="방문하신 팝업스토어는 어떠셨나요? 후기를 통해 회원님의 멋진 경험을 다른 분들과 공유해보세요!"></textarea>
                <input type="hidden" name="score" value="">
                <input type="file" id="fileInput" name="uploadFile" style="display: none;" />
                <div class="button-group">
                    <button type="button" onclick="document.getElementById('fileInput').click();">사진 첨부하기</button>
                    <button type="submit">후기 등록</button>
                </div>
            </form>
        </div>

        <div class="footer">
            ---
        </div>
    </div>

<script>
$(document).ready(function() {
    // 배너 슬라이더 초기화
    $('.slider').slick({
        slidesToShow: 2,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 1500,
        dots: true,
        arrows: true,
        prevArrow: '<button type="button" class="custom-prev">&#10094;</button>',
        nextArrow: '<button type="button" class="custom-next">&#10095;</button>'
    });

    // 지도 초기화 함수
    function initMap() {
        var lat = ${popsInfo.mapVO.lat};
        var lng = ${popsInfo.mapVO.lng};
        var address = "${popsInfo.pAddr1} ${popsInfo.pAddr2} ${popsInfo.pAddr3}";

        var mapOptions = {
            center: new naver.maps.LatLng(lat, lng),
            zoom: 14
        };

        var map = new naver.maps.Map('map', mapOptions);

        var iconUrl = '<%=request.getContextPath()%>/resources/img/map.png';

        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lng),
            map: map,
            icon: {
                url: iconUrl,
                size: new naver.maps.Size(50, 52),
                scaledSize: new naver.maps.Size(30, 32),
                origin: new naver.maps.Point(0, 0),
                anchor: new naver.maps.Point(15, 16)
            }
        });

        var infoWindow = new naver.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:10px;">' + address + '</div>'
        });

        naver.maps.Event.addListener(marker, "click", function(e) {
            if (infoWindow.getMap()) {
                infoWindow.close();
            } else {
                infoWindow.open(map, marker);
            }
        });
    }

    // 페이지 로드 후 지도 초기화
    initMap();

    // 페이지 로드 시 찜 상태 확인
    function checkLikeStatus() {
        var pId = ${popsInfo.pId};
        $.ajax({
            url: '${pageContext.request.contextPath}/pop/checkCart',
            type: 'GET',
            data: { pId: pId },
            dataType: 'json',
            success: function(response) {
                if (response.isLiked) {
                    $('#heartImage').attr('src', '${pageContext.request.contextPath}/resources/img/heart2.png');
                    $('#heartIcon').data('liked', true);
                } else {
                    $('#heartImage').attr('src', '${pageContext.request.contextPath}/resources/img/heart.png');
                    $('#heartIcon').data('liked', false);
                }
            },
        });
    }

    checkLikeStatus();

    // 찜 추가/삭제 기능
    $('#heartIcon').click(function() {
        var liked = $(this).data('liked');
        var pId = ${popsInfo.pId};
        var actionUrl = liked ? '${pageContext.request.contextPath}/pop/deletelike' : '${pageContext.request.contextPath}/pop/addlike';

        $.post(actionUrl, { pId: pId }, function(response) {
            if (liked) {
                $('#heartImage').attr('src', '${pageContext.request.contextPath}/resources/img/heart.png');
                $('#heartIcon').data('liked', false);
                alert("찜이 삭제되었습니다.");
            } else {
                $('#heartImage').attr('src', '${pageContext.request.contextPath}/resources/img/heart2.png');
                $('#heartIcon').data('liked', true);
                alert("찜이 추가되었습니다.");
            }
        }).fail(function(xhr) {
            alert('로그인이 필요합니다.');
            window.location.href = '${pageContext.request.contextPath}/nav/prelogin';
        });
    });

    // 평점 선택 기능
    document.querySelectorAll('.rating label').forEach(label => {
        label.addEventListener('click', function() {
            let value = this.previousElementSibling.value;
            document.querySelector('input[name="score"]').value = value;
            highlightStars(value);
        });
    });

    function highlightStars(rating) {
        document.querySelectorAll('.rating label').forEach(label => {
            label.style.color = label.previousElementSibling.value <= rating ? '#ffcc00' : '#ccc';
        });
    }

    let selectedRating = document.querySelector('.rating input:checked');
    if (selectedRating) {
        highlightStars(selectedRating.value);
    }

    // 리뷰 폼 제출 처리
    $('#reviewForm').submit(function(e) {
        e.preventDefault();

        if (!isLoggedIn) {
            alert('로그인이 필요합니다.');
            window.location.href = '${pageContext.request.contextPath}/nav/prelogin';
            return;
        }

        var formData = new FormData(this);
        var files = $('input[name="uploadFile"]')[0].files;

        if (files.length > 0) {
            uploadImagesAndSubmitReview(files, formData);
        } else {
            submitReviewForm([]);
        }
    });

    // 이미지 업로드 및 삭제 처리
    $("input[type='file']").on("change", function(e) {
        if ($(".imgDeleteBtn").length > 0) {
            deleteFile();
        }

        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files;
        let fileObj = fileList[0];

        if (!fileCheck(fileObj.name, fileObj.size)) {
            return false;
        }

        formData.append("uploadFile", fileObj);

        $.ajax({
            url: '${pageContext.request.contextPath}/pop/uploadAjaxAction',
            processData: false,
            contentType: false,
            data: formData,
            type: 'POST',
            dataType: 'json',
            success: function(result) {
                showUploadImage(result);
            },
            error: function(xhr, status, error) {
                alert("이미지 업로드 중 오류가 발생했습니다.");
            }
        });
    });

    var maxSize = 5242880; // 5MB
    var regex = new RegExp("(.*?)\\.(jpg|jpeg|png|gif|bmp)$");

    function uploadImagesAndSubmitReview(files, formData) {
        let uploadFormData = new FormData();

        $.each(files, function(i, file) {
            uploadFormData.append('uploadFile', file);
        });

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/pop/uploadAjaxAction',
            data: uploadFormData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(response) {
                var imageList = [];
                $.each(response, function(i, image) {
                    var imageInfo = {
                        uuid: image.uuid,
                        fileName: image.fileName,
                        uploadPath: image.uploadPath
                    };
                    imageList.push(imageInfo);
                });

                submitReviewForm(imageList);
            },
            error: function(xhr, status, error) {
                alert("이미지 업로드 중 오류가 발생했습니다.");
            }
        });
    }

    function submitReviewForm(imageList) {
        var reviewFormData = new FormData();
        reviewFormData.append('pId', $('input[name="pId"]').val());
        reviewFormData.append('contents', $('textarea[name="contents"]').val());
        reviewFormData.append('score', $('input[name="score"]').val());
        reviewFormData.append('imageList', JSON.stringify(imageList));

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/pop/addReview',
            data: reviewFormData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(response) {
                alert(response.message);
                location.reload();
            },
            error: function(xhr, status, error) {
                alert("후기는 한번만 등록할 수 있습니다.");
            }
        });
    }

    $("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
        deleteFile();
    });

    function deleteFile() {
        let targetFile = $(".imgDeleteBtn").data("file");
        let targetDiv = $("#result_card");

        $.ajax({
            url: '/pop/deleteFile',
            data: { fileName: targetFile },
            dataType: 'text',
            type: 'POST',
            success: function(result) {
                if (result === 'success') {
                    targetDiv.remove();
                    $("input[type='file']").val("");
                } else {
                    alert("파일을 삭제하지 못하였습니다.");
                }
            },
            error: function(result) {
                alert("파일을 삭제하지 못하였습니다.");
            }
        });
    }

    function showUploadImage(uploadResultArr) {
        if (!uploadResultArr || uploadResultArr.length == 0) {
            return;
        }

        let uploadResult = $("#uploadResult");

        let obj = uploadResultArr[0];

        let str = "";

        let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);

        str += "<div id='result_card'>";
        str += "<img src='${pageContext.request.contextPath}/pop/display?fileName=" + fileCallPath + "' style='width: 100px; height: auto;'>";
        str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>삭제</div>";
        str += "<input type='hidden' name='imageList[0].fileName' value='" + obj.fileName + "'>";
        str += "<input type='hidden' name='imageList[0].uuid' value='" + obj.uuid + "'>";
        str += "<input type='hidden' name='imageList[0].uploadPath' value='" + obj.uploadPath + "'>";
        str += "</div>";

        uploadResult.empty();
        uploadResult.append(str);
    }

    function fileCheck(fileName, fileSize) {
        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if (!regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }

        return true;
    }
});

</script>

<%@ include file="../nav/nav.jsp" %>

<script>
    var isLoggedIn = <%= (session.getAttribute("member") != null) %>;
</script>

</body>
</html>
