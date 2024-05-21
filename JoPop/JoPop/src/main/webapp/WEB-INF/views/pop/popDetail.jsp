<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/nav/nav.css">
    <meta charset="UTF-8">
    <title>상세 페이지</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8miqdnp9yh"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
    <style>
	   body {
	    background-color: #f0f0f0; /* 밝은 배경색 */
	    color: #1e1e1e; /* 텍스트 색상 */
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	}
	
	.container {
	    max-width: 1200px; /* 최대 너비 설정 */
	    margin: 0 auto; /* 중앙 정렬 */
	    background-color: #ffffff; /* 내부 컨텐츠 배경색 */
	    padding: 20px; /* 내부 여백 */
	    border-radius: 8px; /* 모서리 둥글게 */
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	}
	
	header {
	    background-color: #004225;
	    color: #ffffff;
	    padding: 20px;
	    text-align: center;
	    border-radius: 8px; /* 모서리 둥글게 */
	}

  .banner {
            text-align: center;
            padding: 10px;
        }

        .slider {
            width: 80%;
            margin: auto;
        }

        .slick-slide img {
            width: 100%;
            border-radius: 8px; /* 모서리 둥글게 */
        }
	.content {
	    padding: 20px;
	}
	
	.section {
	    margin-bottom: 20px;
	    padding: 20px;
	    background-color: #ffffff;
	    border-radius: 8px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	.section h2 {
	    color: #00c73c; /* Jopop 색상 */
	}
	
	#map {
	    margin-top: 20px;
	    border: 1px solid #004225;
	}
	
	.footer {
	    margin-top: 20px;
	    text-align: center;
	    padding: 10px;
	    background-color: #004225;
	    color: #ffffff;
	    border-radius: 8px; /* 모서리 둥글게 */
	}
	
	.review-section {
	    background-color: #ffffff;
	    color: #1e1e1e;
	    padding: 20px;
	    border-radius: 8px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	.review-section h2 {
	    color: #00c73c; /* Jopop 색상 */
	}
	
	.rating {
	    display: flex;
	    justify-content: center;
	    margin: 10px 0;
	    flex-direction: row-reverse;
	}
	
	.rating input {
	    display: none;
	}
	
	.rating label {
	    font-size: 2rem;
	    color: #ccc; /* 기본 상태 빈 별 색상 */
	    cursor: pointer;
	}
	
	.rating label:hover,
	.rating label:hover ~ label,
	.rating input:checked ~ label {
	    color: #ffcc00; /* hover 및 체크된 상태의 별 색상 */
	}
	
	.rating input:checked ~ label ~ label {
	    color: #ccc; /* 선택된 별보다 오른쪽 별들은 다시 기본 색상으로 */
	}
	
	.review-form {
	    display: flex;
	    flex-direction: column;
	}
	
	.review-form textarea {
	    width: 100%;
	    height: 100px;
	    background-color: #f0f0f0;
	    color: #1e1e1e;
	    border: 1px solid #004225;
	    border-radius: 4px;
	    padding: 10px;
	    margin-bottom: 10px;
	    resize: none; /* textarea 크기 고정 */
	}
	
	.review-form .button-group {
	    display: flex;
	    justify-content: space-between;
	}
	
	.review-form .button-group button {
	    background-color: #00c73c; /* Jopop 색상 */
	    color: #ffffff;
	    border: none;
	    padding: 10px 20px;
	    cursor: pointer;
	    border-radius: 4px;
	}
	
	.review-form .button-group button:hover {
	    background-color: #008f28; /* Hover 색상 */
	}
	
	.review-section p {
	    color: #1e1e1e;
	}
	
	/* 이미지 주석 */
	#result_card img {
	    max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;
	}
	
	#result_card {
	    position: relative;
	}
	
	.imgDeleteBtn {
	    position: absolute;
	    top: 5px;
	    right: 5px;
	    background-color: #ef7d7d;
	    color: #ffffff;
	    font-weight: bold;
	    width: 50px;
	    height: 30px;
	    border-radius: 4px;
	    line-height: 30px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	    transition: background-color 0.3s ease, transform 0.3s ease;
	}
	
	.imgDeleteBtn:hover {
	    background-color: #d9534f;
	    transform: scale(1.1);
	}
	
	/* 이미지 크기 */
	#uploadResult img {
	    width: 100px; /* 원하는 너비 값 */
	    height: auto; /* 비율을 유지하면서 높이를 자동으로 조정 */
	}
	
	/* 스타일을 적용한 제목 */
	.styled-heading {
	    font-family: 'Arial', sans-serif; /* 원하는 글꼴 */
	    font-size: 2rem; /* 글자 크기 */
	    color: #00c73c; /* Jopop 색상 */
	    border-bottom: 2px solid #00c73c; /* 아래 테두리 */
	    padding-bottom: 10px; /* 아래 패딩 */
	    margin-bottom: 20px; /* 아래 마진 */
	}

    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %> <!-- 헤더 -->
    
    <div class="container">
        <div class="content">
              <div class="section banner">
                <div class="slider">
                    <div><img src="C:\image\1.png" alt="배너 이미지 1" class="banner-image"></div>
                    <div><img src="C:\image\2.png" alt="배너 이미지 2" class="banner-image"></div>
                    <div><img src="C:\image\3.png" alt="배너 이미지 3" class="banner-image"></div>
                </div>
            </div>
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
                <p>등록된 후기가 없습니다. 첫 번째 후기를 작성해 보세요!</p>
                <div class="rating">
                    <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
                </div>
                <div id="uploadResult"></div>
                <form class="review-form" method="post" action="${pageContext.request.contextPath}/pop/uploadAjaxAction" enctype="multipart/form-data">
                    <textarea placeholder="리뷰를 입력하세요"></textarea>
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
        
        $(document).ready(function(){
            $('.slider').slick({
                dots: true,
                infinite: true,
                speed: 500,
                fade: true,
                cssEase: 'linear',
                autoplay: true,
                autoplaySpeed: 2000
            });
        });
    </script>
  <%@include file="../nav/nav.jsp"%>
</body>
</html>
