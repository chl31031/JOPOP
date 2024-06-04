<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Locations and Search</title>
    <link rel="stylesheet" href="../resources/css/pop/loc.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8miqdnp9yh"></script>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <div id="map-container">
        <div id="map"></div>
        <a href="#" id="my-location-btn" class="btn_mylct"></a>
        <div id="info-panel">
            <div class="info-wrap">
                <img src="" id="info-image" class="popup-image" alt="">
                <div>
                    <p class="popup-title" id="info-title"></p>
                    <p class="popup-address" id="info-address"></p>
                    <p class="popup-date" id="info-date"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="list-container">
        <c:forEach items="${list}" var="list">
            <div class="list-item">
                <div class="image">
                    <img src="display?fileName=${list.imageList[0].uploadPath}/s_${list.imageList[0].uuid}-${list.imageList[0].fileName}" alt="">
                </div>
                <div class="details">
                    <div class="title"><a href="/pop/popsDetail?pid=${list.pId}">${list.pName}</a></div>
                    <div class="address">${list.pAddr1} ${list.pAddr2}</div>
                    <div class="date">
                        <fmt:formatDate value="${list.startDate}" pattern="yyyy.MM.dd"/> - 
                        <fmt:formatDate value="${list.endDate}" pattern="yyyy.MM.dd"/>
                    </div>
                    <div class="price"><fmt:formatNumber value="${list.pPrice}" pattern="#,### 원" /></div>
                </div>
                <img src="/resources/img/heart.png" class="btn_cart" data-pid="${list.pId}">
            </div>
        </c:forEach>
    </div>
    <%@include file="../nav/nav.jsp"%>

<script>
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

    /* 이미지 삽입 */
    $(".image_wrap").each(function(i, obj) {
        const bobj = $(obj);
        
        const uploadPath = bobj.data("path");
        const uuid = bobj.data("uuid");
        const fileName = bobj.data("filename");
        
        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "-" + fileName);
        
        $(this).find("img").attr('src', 'display?fileName=' + fileCallPath);
    });

    var cityhall = new naver.maps.LatLng(37.51912, 127.051937),
    map = new naver.maps.Map('map', {
        center: cityhall,
        zoom: 13,
        mapTypeControl: true,
        zoomControl: true
    });

    // 장소 정보
    var locations = [
        <c:forEach var="location" items="${locations}">
            {
                pid: '${location.pId}',
                pname: '${location.pName}',
                lat: '${location.mapVO.lat}',
                lng: '${location.mapVO.lng}',
                paddr1: '${location.pAddr1}',
                paddr2: '${location.pAddr2}',
                paddr3: '${location.pAddr3}',
                startDate: '<fmt:formatDate value="${location.startDate}" pattern="yyyy-MM-dd" />',
                endDate: '<fmt:formatDate value="${location.endDate}" pattern="yyyy-MM-dd" />',
                imagePath: '/resources/eximg/hello.png'
            },
        </c:forEach>
    ];

    // 날짜 형식 변환 함수
    function formatDate(dateString) {
        var date = new Date(dateString);
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return year + '.' + month + '.' + day;
    }

    // 마커 아이콘 설정
    function createMarkerIcon(imagePath) {
        return {
            url: imagePath,
            size: new naver.maps.Size(30, 30),
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(15, 15),
            scaledSize: new naver.maps.Size(30, 30)
        };
    }

    // 마커 및 정보창 추가
    var activeMarker = null; // 현재 활성화된 마커를 추적하기 위한 변수

    for (var i = 0; i < locations.length; i++) {
        var loc = locations[i];
        var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(loc.lat, loc.lng),
            title: loc.pname,
            icon: createMarkerIcon('/resources/img/map.png')
        });

        var startDateFormatted = formatDate(loc.startDate);
        var endDateFormatted = formatDate(loc.endDate);

        var contentString = {
            title: loc.pname,
            address: loc.paddr1 + ' ' + loc.paddr2 + ' ' + loc.paddr3,
            date: startDateFormatted + ' - ' + endDateFormatted,
            imagePath: loc.imagePath
        };

        var infoWindow = new naver.maps.InfoWindow({
            content: '<img src="' + contentString.imagePath + '" class="popup-image" alt="">',
            borderWidth: 0,
            disableAnchor: true,
            backgroundColor: 'transparent'
        });

        // 마커 클릭 이벤트
        naver.maps.Event.addListener(marker, 'click', (function(marker, contentString, infoWindow) {
            return function() {
                if (activeMarker && activeMarker !== marker) {
                    // 다른 마커 클릭 시 활성화된 마커의 정보창 닫기
                    activeMarker.infoWindow.close();
                    document.getElementById('info-panel').style.display = 'none';
                    activeMarker = null;
                }

                if (activeMarker === marker) {
                    // 이미 활성화된 마커 클릭 시 정보창 닫기
                    infoWindow.close();
                    document.getElementById('info-panel').style.display = 'none';
                    activeMarker = null;
                } else {
                    // 마커 클릭 시 정보창 열기
                    document.getElementById('info-image').src = contentString.imagePath;
                    document.getElementById('info-title').innerText = contentString.title;
                    document.getElementById('info-address').innerText = contentString.address;
                    document.getElementById('info-date').innerText = contentString.date;
                    document.getElementById('info-panel').style.display = 'block';

                    // 지도를 마커 위치로 매끄럽게 이동
                    map.panTo(marker.getPosition(), {
                        duration: 500
                    });

                    infoWindow.open(map, marker);
                    activeMarker = marker;
                    marker.infoWindow = infoWindow; // 마커 객체에 정보창 객체를 저장
                }
            };
        })(marker, contentString, infoWindow));
    }

    // 작은 원과 큰 원을 전역 변수로 선언
    var smallCircle, circle;
    var animationInterval; // 애니메이션을 제어할 전역 변수

    // 사용자 위치 가져오기 및 지도 이동
    function moveToUserLocation(isInitialLoad) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var userLatLng = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);

                // 사용자 위치로 지도 이동
                map.panTo(userLatLng, {
                    duration: 500,
                    easing: 'easeOutCubic',
                    complete: function() {
                        if (isInitialLoad) {
                            // 애니메이션이 끝난 후 원을 추가 또는 업데이트
                            circle = new naver.maps.Circle({
                                map: map,
                                center: userLatLng,
                                radius: 200, // 초기 반경
                                strokeColor: '#FF0000', // 테두리 색상을 빨간색으로 설정
                                strokeOpacity: 0.8,
                                strokeWeight: 2,
                                fillColor: '#CFE7FF',
                                fillOpacity: 0.6
                            });

                            // 애니메이션 효과 추가
                            var growing = true;
                            var maxRadius = 300;
                            var minRadius = 200;

                            animationInterval = setInterval(function() {
                                var currentRadius = circle.getRadius();
                                if (growing) {
                                    circle.setRadius(currentRadius + 10);
                                    if (currentRadius >= maxRadius) growing = false;
                                } else {
                                    circle.setRadius(currentRadius - 10);
                                    if (currentRadius <= minRadius) growing = true;
                                }
                            }, 65); // 반경을 조절하는 주기 (밀리초 단위)
                        } else if (circle) {
                            circle.setCenter(userLatLng);
                        }
                    }
                });

                // 사용자 위치에 작은 원 추가 또는 업데이트
                if (!smallCircle) {
                    smallCircle = new naver.maps.Circle({
                        map: map,
                        center: userLatLng,
                        radius: 50, // 작은 원의 반경
                        strokeColor: '#FF0000', // 테두리 색상을 빨간색으로 설정
                        strokeOpacity: 0.8,
                        strokeWeight: 2,
                        fillColor: '#FF0000', // 작은 원을 빨간색으로 가득 채우기
                        fillOpacity: 0.6
                    });
                } else {
                    smallCircle.setCenter(userLatLng);
                }
            }, function(error) {
                console.error('내 위치를 가져올 수 없습니다:', error);
                alert('내 위치를 가져올 수 없습니다.');
            });
        } else {
            alert('이 브라우저는 Geolocation을 지원하지 않습니다.');
        }
    }

    // 페이지 로드 시 사용자의 위치로 이동
    window.onload = function() {
        moveToUserLocation(true);
    };

    // 내 위치 버튼 이벤트 처리
    var myLocationBtn = document.getElementById('my-location-btn');
    myLocationBtn.addEventListener('click', function() {
        moveToUserLocation(false);
    });
</script>
</body>
</html>
