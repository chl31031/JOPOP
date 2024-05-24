<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/nav/nav.css">
    <link rel="stylesheet" href="/resources/css/pop/pop.css">
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
        </div>

        <div class="content">
            <div class="section">
                <h2 class="styled-heading">운영 시간</h2>
                <p>${popsInfo.pIntro}</p> <!-- pIntro 데이터를 여기에 출력 -->
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
                <p>작성자: ${review.mId}</p>
                <p>내용: ${review.contents}</p>
                <p>평점: ${review.score}</p>
               <p>작성일: <fmt:formatDate value="${review.rDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></p>
            </div>
            <div class="review-divider"></div> <!-- 구분선 추가 -->
        </c:forEach>
    </c:if>
    <c:if test="${empty reviews}">
        <p>등록된 후기가 없습니다. 첫 번째 후기를 작성해 보세요!</p>
    </c:if>
    <div class="rating">
        <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
        <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
        <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
        <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
        <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
    </div>
    <div id="uploadResult"></div>
    <form class="review-form" method="post" action="${pageContext.request.contextPath}/pop/addReview" enctype="multipart/form-data">
        <input type="hidden" name="pId" value="${popsInfo.pId}">
        <textarea name="contents" placeholder="리뷰를 입력하세요"></textarea>
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
    </div>
    <script>
        // EL을 사용하여 JSP에서 JavaScript 변수로 위도와 경도를 전달
        var lat = ${popsInfo.mapVO.lat};
        var lng = ${popsInfo.mapVO.lng};
        var address = "${popsInfo.pAddr1} ${popsInfo.pAddr2} ${popsInfo.pAddr3}";

        // 페이지 로드 후 지도 초기화
        window.onload = function() {
            var mapOptions = {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 14
            };
            var map = new naver.maps.Map('map', mapOptions);
            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map
            });

            // 정보창 생성
            var infoWindow = new naver.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:10px;">' + address + '</div>'
            });

            // 마커에 클릭 이벤트 추가
            naver.maps.Event.addListener(marker, "click", function(e) {
                if (infoWindow.getMap()) {
                    infoWindow.close();
                } else {
                    infoWindow.open(map, marker);
                }
            });
        }

        // 별점 기능 스크립트
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

        // 초기 상태에서 선택된 별점 하이라이트
        let selectedRating = document.querySelector('.rating input:checked');
        if (selectedRating) {
            highlightStars(selectedRating.value);
        }

        $(document).ready(function(){
            $("input[type='file']").on("change", function(e){

                /* 이미지 존재시 삭제 */
                if($(".imgDeleteBtn").length > 0){
                    deleteFile();
                }

                let formData = new FormData();
                let fileInput = $('input[name="uploadFile"]');
                let fileList = fileInput[0].files;
                let fileObj = fileList[0];

                console.log("fileObj : " + fileObj);
                console.log("fileList: ", fileList);
                console.log("fileName : " + fileObj.name);
                console.log("fileSize : " + fileObj.size);
                console.log("fileType(MimeType) : " + fileObj.type);

                // 파일 체크 함수 호출
                if(!fileCheck(fileObj.name, fileObj.size)){
                    return false;
                }

                formData.append("uploadFile", fileObj);

                $.ajax({
                    url: '/pop/uploadAjaxAction',
                    processData : false,
                    contentType : false,
                    data : formData,
                    type : 'POST',
                    dataType : 'json',
                    success: function(result){
                        console.log(result);
                        showUploadImage(result);
                    }
                });
            });

            $('.slider').slick({
                slidesToShow: 2,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 1500, // 재생 시간 단축
                dots: true,
                arrows: true,
                prevArrow: '<button type="button" class="custom-prev">&#10094;</button>',
                nextArrow: '<button type="button" class="custom-next">&#10095;</button>'
            });
        });

        // 파일 체크 함수
        let regex = new RegExp("(.*?)\.(jpg|png|jpeg|gif)$");
        let maxSize = 1048576; //1MB

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

        /* 이미지 출력 */
        function showUploadImage(uploadResultArr){
            /* 전달받은 데이터 검증 */
            if(!uploadResultArr || uploadResultArr.length == 0){ return; }

            let uploadResult = $("#uploadResult");

            let obj = uploadResultArr[0];

            let str = "";

            // 변경 후
            let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);

            console.log("File path: ", fileCallPath);  // 경로 확인용 콘솔 출력

            str += "<div id='result_card'>";
            str += "<img src='/pop/display?fileName=" + fileCallPath + "' style='width: 100px; height: auto;'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>삭제</div>"
            str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
            str += "</div>";

            uploadResult.empty();  // 기존 이미지 제거
            uploadResult.append(str);
        }

        /* 이미지 삭제 버튼 동작 */
        $("#uploadResult").on("click", ".imgDeleteBtn", function(e){
            deleteFile();
        });

        /* 파일 삭제 메서드 */
        function deleteFile(){
            let targetFile = $(".imgDeleteBtn").data("file");
            let targetDiv = $("#result_card");

            $.ajax({
                url: '/pop/deleteFile',
                data : {fileName : targetFile},
                dataType : 'text',
                type : 'POST',
                success : function(result){
                    console.log(result);

                    if(result === 'success'){
                        targetDiv.remove();
                        $("input[type='file']").val("");
                    } else {
                        alert("파일을 삭제하지 못하였습니다.");
                    }
                },
                error : function(result){
                    console.log(result);
                    alert("파일을 삭제하지 못하였습니다.");
                }
            });
        }
    </script>
  <%@include file="../nav/nav.jsp"%>
</body>
</html>
