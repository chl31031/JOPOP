<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업/전시 정보 등록 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/popsEnroll.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<!-- 캘린더 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<style>
/*datepicker에서 사용한 이미지 버튼 style적용*/
            img.ui-datepicker-trigger {
                margin-left:5px; vertical-align:middle; cursor:pointer;
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8miqdnp9yh&submodules=geocoder" type="text/javascript"></script>
<!-- 캘린더 -->
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<style type="text/css">
   #result_card img{
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
   .imgDeleteBtn{
       position: absolute;
       top: 0;
       right: 5%;
       background-color: #ef7d7d;
       color: wheat;
       font-weight: 900;
       width: 30px;
       height: 30px;
       border-radius: 50%;
       line-height: 26px;
       text-align: center;
       border: none;
       display: block;
       cursor: pointer;   
   }
</style>
</head>
</head>
<body>
 
          <%@include file="../includes/admin/header.jsp" %>
             
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>팝업/전시 정보 등록</span></div>
                    <div class="admin_content_main">
                       <form action="/admin/popsEnroll" method="post" id="enrollForm">
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 이름</label>
                             </div>
                             <div class="form_section_content">
                                <input name="pName">
                                <span class="ck_warn pName_warn">팝업/전시 이름을 입력해주세요.</span>
                             </div>
                          </div>                            
                          
                          <div class="form_section">
                             <div class="form_section_title">
                             <label>기간</label>
                            </div>
                            <div class="form_section_content">
                                <label for="startDate">시작일</label>
                                <input type="text" name="startDate" id="startDate" placeholder="시작일" style="flex: 1; margin-right: 5px;">
                                <input id="startDate" type="button" value="날짜 선택" class="btn btn-primary" style="width: 150px; height: 40px;">
                                ~
                                <label for="endDate">종료일</label>
                                <input type="text" name="endDate" id="endDate" placeholder="종료일" style="flex: 1; margin-right: 5px;">
                                <input id="endDate" type="button" value="날짜 선택" class="btn btn-primary" style="width: 150px; height: 40px;">
                             </div>
                             <div class="form_section_content">
                                <!-- <input name="stratDate" autocomplete="off" readonly="readonly"> -->
                                <span class="ck_warn stratDate_warn">날짜를 선택해주세요.</span>
                             </div>
                          </div>                                                 							 							                                                                                                                                                                                                      	
                                 
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 가격</label>
                             </div>
                             <div class="form_section_content">
                                <input name="pPrice">원
                                <span class="ck_warn pPrice_warn">팝업/전시 가격을 입력해주세요.</span>
                             </div>
                          </div>                                                                           
                                         
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 이용 시설 안내</label>
                             </div>
                             <div class="form_section_content">
                                <textarea name="pIntro" id="pIntro_textarea"></textarea>
                                <span class="ck_warn pIntro_warn">팝업/전시 소개(상세 정보)를 입력해주세요.</span>
                             </div>
                          </div>  
                          
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 소개(상세 내용)</label>
                             </div>
                             <div class="form_section_content">
                                <textarea name="pContents" id="pContents_textarea"></textarea>
                                <span class="ck_warn pContents_warn">팝업/전시 이용 정보를 입력해주세요.</span>
                             </div>
                          </div>                                                                                                                                        
                                   
                                    <div class="form_section">
    <div class="form_section_title">
        <label>팝업/전시 지역(주소)</label>
    </div>
    <div class="form_section_content">
        <div class="cate_wrap">
            <span>시/도</span>
            <select class="cate1">
                <option selected value="none">선택</option>
            </select>
        </div>
        <div class="cate_wrap">
            <span>시/군/구</span>
            <select class="cate2">
                <option selected value="none">선택</option>
            </select>
        </div>
        <span class="ck_warn cateCode_warn">지역을 선택해주세요.</span>
    </div>
</div>
                                                                               
                          <!-- 주소 -->   
							<div class="form_section">							 
							    <div class="form_section_content">
							        <div class="container">
							            <div class="row">
							                <div class="col">						                
							 <div class="input-group mb-2">
							 
							    <!-- 검색 버튼을 입력창 오른쪽에 위치시킵니다. -->
							    <div class="search" style="display: flex; align-items: center;">
							        <input id="address" type="text" placeholder="검색할 주소" style="flex: 1; margin-right: 5px;">
							        <input id="submit" type="button" value="주소 검색" class="btn btn-primary" style="width: 150px; height: 40px;">
							    </div>
							    
							</div>
				                </div>
				            </div>
				            <!-- 지도를 좀 더 크게 표시합니다. -->
				            <div class="row">
				                <div class="col">
				                    <div id="map" style="height: 400px;"></div>
				                </div>
				            </div>
				            
				            <div class="row mt-2">
				                <div class="col">
				                    <table class="table">
				                        <thead>
				                            <tr>
				                                <th>주소</th>
				                                <th>위도</th>
				                                <th>경도</th>
				                            </tr>
				                        </thead>
				                        <tbody id="mapList"></tbody>
				                    </table>
				                </div>
				            </div>
						        </div>
						    </div>
						</div>
							<!-- 주소 끝 -->
							
                          <div class="form_section">
    <div class="form_section_title">
        <label>팝업 이미지 등록</label>
    </div>
    <div class="form_section_content">
        <input type="file" id="fileItem" name="uploadFile" multiple style="height: 30px;">
        <div id="uploadResult">
            <!-- 업로드된 이미지가 표시될 영역 -->
        </div>
    </div>
</div>
                          
                         </form>
                         
                            <div class="btn_section">
                               <button id="cancelBtn" class="btn">취 소</button>
                             <button id="enrollBtn" class="btn enroll_btn">등 록</button>
                          </div> 
                    </div>  
                </div>
                   
                
             <!--원래 footer 있었음-->
             
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script>
		
/* 캘린더 위젯 적용 */
$(function() {
   
    //datepicker 한국어로 사용하기 위한 언어설정
    $.datepicker.setDefaults($.datepicker.regional['ko']); 
    
    // 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
    // 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

    //시작일.
    $('#startDate').datepicker({
        showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)       
        buttonText: "날짜선택",             // 버튼의 대체 텍스트
        dateFormat: "yy-mm-dd",             // 날짜의 형식
        changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
        //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
        onClose: function( selectedDate ) {    
            // 시작일(fromDate) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#").datepicker( "option", "minDate", selectedDate );
        }                
    });

    //종료일
    $('#endDate').datepicker({
        showOn: "both",            
        buttonText: "날짜선택",
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        //minDate: 0, // 오늘 이전 날짜 선택 불가
        onClose: function( selectedDate ) {
            // 종료일(toDate) datepicker가 닫힐때
            // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            $("#startDate").datepicker( "option", "maxDate", selectedDate );
        }                
    });
});
<!--캘린더 끝-->

   let enrollForm = $("#enrollForm")
   
   //취소 버튼
   $("#cancelBtn").click(function(){
      location.href = "/admin/popsManage"
   });
   
   /*등록 버튼*/
   $("#enrollBtn").on("click",function(e){//"등 록" 버튼에 대한 클릭 이벤트 처리
      e.preventDefault(); //기본 이벤트 동작을(페이지 새로고침)막는다.
            
      // 체크 변수 선언(유효성 검사)
      let NameCk = false; 
      let startDateCk = false;
      let endDateCk = false;
      let cateCodeCk = false;
      let priceCk = false;
      let introCk = false;
      let contentsCk = false;
      //초기엔 모든 필드의 유효성을 거짓으로 설정
      
      //체크 대상 변수 (각 입력 필드의 값을 가져옴)
      let Name = $("input[name='pName']").val();
      //"pName"이라는 이름을 가진 input요소를 선택하는 것($("input[name='pName']")) 
      //'.val()'함수는 선택된 요소의 값(value)을 반환합니다. 
      //그렇게 가져온 값을 'Name' 변수에 저장
      let startDate = $("input[name='startDate']").val();
      let endDate = $("input[name='endDate']").val();
      let cateCode = $("select[name='cateCode']").val();
      let Price = $("input[name='pPrice']").val();   
      let Intro = $(".bit p").html();
      let Contents = $(".bct p").html();    
      //html문서에서 클래스가 'bit'인 요소와 'bct'인 요소에서 각각'<p>'태그 내의 html 내용을 가져옴.
      
      //if문을 사용하여 각 입력 필드의 값이 비어있는지 확인
      if(pName){// != null을 쓰지 않아도 되나?
         $(".pName_warn").css('display','none');//값이 비어있지 않으면 해당 필드의 경고 메세지 숨김('display','none')
         NameCk = true;
      } else {
         $(".pName_warn").css('display','block');//값이 비어있으면 해당 필드의 경고 메세지를 표시('display','block')
         NameCk = false;
      }
      
      if(startDate){
         $(".startDate_warn").css('display','none');
         startDaterCk = true;
      } else {
         $(".startDate_warn").css('display','block');
         startDateCk = false;
      } 
      
      if(endDate){
          $(".endDate_warn").css('display','none');
          endDateCk = true;
       } else {
          $(".endDate_warn").css('display','block');
          endDateCk = false;
       }            
      
      if(cateCode != 'none'){
         $(".cateCode_warn").css('display','none');
         cateCodeCk = true;
      } else {
         $(".cateCode_warn").css('display','block');
         cateCodeCk = false;
      }   
      
      if(pPrice){
         $(".pPrice_warn").css('display','none');
         priceCk = true;
      } else {
         $(".pPrice_warn").css('display','block');
         priceCk = false;
      }                          
      
      if(pIntro != '<br data-cke-filler="true">'){
         $(".pIntro_warn").css('display','none');
         introCk = true;
      } else {
         $(".pIntro_warn").css('display','block');
         introCk = false;
      }   
      
      if(pContents != '<br data-cke-filler="true">'){
         $(".pContents_warn").css('display','none');
         contentsCk = true;
      } else {
         $(".pContents_warn").css('display','block');
         contentsCk = false;
      }      
      
      if(NameCk && startDate && endDate && cateCodeCk && priceCk && introCk && contentsCk){
         enrollForm.submit();//모든 결과가 참일 때만 호출하여 양식 제출
      }else{
         return false;
      }
      
      enrollForm.submit();//호출하여 폼 제출
   });
   
/* 위지윅 적용 */
    
   // 팝업/전시 이용 시설 안내
   ClassicEditor
      .create(document.querySelector('#pIntro_textarea'))
      .catch(error=>{
         console.error(error);
      });
      
   // 팝업/전시 소개(상세 내용)
   ClassicEditor
   .create(document.querySelector('#pContents_textarea'))
   .catch(error=>{
      console.error(error);
   });
   
//카테고리(지역)
   let cateList = JSON.parse('${cateList}');

let cate1Array = [];
let cate2Array = [];

let cateSelect1 = $(".cate1");
let cateSelect2 = $(".cate2");

// 카테고리(지역) 배열 초기화 메서드
function makeCateArray(array, cateList, tier) {
    for (let i = 0; i < cateList.length; i++) {
        if (cateList[i].tier === tier) {
            let obj = {
                cateName: cateList[i].cateName,
                cateCode: cateList[i].cateCode,
                cateParent: cateList[i].cateParent
            };
            array.push(obj);
        }
    }
}

// 배열 초기화
makeCateArray(cate1Array, cateList, 1);
makeCateArray(cate2Array, cateList, 2);

// 시/도(대분류) <option> 태그 추가
$(document).ready(function() {
    for (let i = 0; i < cate1Array.length; i++) {
        cateSelect1.append("<option value='" + cate1Array[i].cateCode + "'>" + cate1Array[i].cateName + "</option>");
    }
});

// 시/도 선택 시 시/군/구(중분류) <option> 태그 추가
$(cateSelect1).on("change", function() {
    let selectVal1 = $(this).find("option:selected").val();
    cateSelect2.children().remove();
    cateSelect2.append("<option value='none'>선택</option>");
    for (let i = 0; i < cate2Array.length; i++) {
        if (selectVal1 === cate2Array[i].cateParent) {
            cateSelect2.append("<option value='" + cate2Array[i].cateCode + "'>" + cate2Array[i].cateName + "</option>");
        }
    }
});   
       
//이미지 업로드
$("input[type='file']").on("change", function(e) {

     /* 기존 이미지 삭제 */
    if($(".imgDeleteBtn").length > 0) {
        deleteAllFiles();
    }
    
    let formData = new FormData();
    let fileInput = $('input[name="uploadFile"]');
    let fileList = fileInput[0].files;
    let fileObj = fileList[0];
    
    for (let i = 0; i < fileList.length; i++) {
        let fileObj = fileList[i];

        /*if (!fileCheck(fileObj.name, fileObj.size)) {
            return false;
        }*/

        formData.append("uploadFile", fileObj);
    }
    
    $.ajax({
        url: '/admin/uploadAjaxAction', //서버로 요청을 보낼 url
        processData: false, //서버로 전송할 데이터를 queryString 형태로 변환할지 여부
        contentType: false, //서버로 전송되는 데이터의 conttent-type
        data: formData, //서버로 전송할 데이터
        type: 'POST', //서버 요청 타입(GET, POST)
        dataType: 'json', //서버로부터 반환받을 데이터 타입
        success: function(result) {
            console.log(result);
            showUploadImages(result);
        },
        error: function(result) {
            alert("이미지 파일이 아닙니다.");
        }
    });
});


// 파일 유효성 검사
let regex = new RegExp("(.*?)\.(jpg|png)$");
let maxSize = 1048576; // 1MB

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

// 이미지 출력
function showUploadImages(uploadResultArr) {
    if (!uploadResultArr || uploadResultArr.length == 0) {
        return;
    }
    
    let uploadResult = $("#uploadResult");
    uploadResult.empty(); // 기존 내용을 초기화
    
    for (let obj of uploadResultArr) {
        let str = "";
        let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
        
        str += "<div class='result_card'>";
        str += "<img src='/display?fileName=" + fileCallPath + "'>";
        str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
        str += "<input type='hidden' name='imageList[0].fileName' value='" + obj.fileName + "'>";
        str += "<input type='hidden' name='imageList[0].uuid' value='" + obj.uuid + "'>";
        str += "<input type='hidden' name='imageList[0].uploadPath' value='" + obj.uploadPath + "'>";      
        str += "</div>";
        
        uploadResult.append(str);
    }
}

// 이미지 삭제 버튼 동작
$("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
    let targetDiv = $(this).closest(".result_card");
    let targetFile = $(this).data("file");
    
    $.ajax({
        url: '/admin/deleteFile',
        data: {fileName: targetFile},
        dataType: 'text',
        type: 'POST',
        success: function(result) {
            console.log(result);
            targetDiv.remove();
        },
        error: function(result) {
            console.log(result);
            alert("파일을 삭제하지 못하였습니다.");
        }
    });
});

// 모든 파일 삭제 메서드
function deleteAllFiles() {
    $(".imgDeleteBtn").each(function() {
        let targetFile = $(this).data("file");
        let targetDiv = $(this).closest(".result_card");

        $.ajax({
            url: '/admin/deleteFile',
            data: {fileName: targetFile},
            dataType: 'text',
            type: 'POST',
            success: function(result) {
                console.log(result);
                targetDiv.remove();
            },
            error: function(result) {
                console.log(result);
                alert("파일을 삭제하지 못하였습니다.");
            }
        });
    });
}
   
 //지도를 그려주는 함수 실행
   selectMapList();
// 검색한 주소의 정보를 저장할 전역 변수
   var searchResult = null;

   // 주소 검색 함수
   function searchAddressToCoordinate(address) {
       // 주소가 비어있는지 확인
       if (address.trim() === "") {
           alert('주소를 입력해주세요.');
           return;
       }

       naver.maps.Service.geocode({
           query: address
       }, function(status, response) {
           if (status === naver.maps.Service.Status.ERROR) {
               return alert('Something Wrong!');
           }

           if (response.v2.meta.totalCount === 0) {
               return alert('올바른 주소를 입력해주세요.');
           }

           // 검색 결과 저장
           searchResult = response.v2.addresses[0];

           // 검색한 주소의 정보를 지도에 표시
           showSearchResult(searchResult);
       });
   }

   // 검색 결과를 지도에 표시하는 함수
   function showSearchResult(result) {
    var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(result.y, result.x),
        zoom: 14
    });
          
    var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(result.y, result.x), // 검색한 주소의 좌표 사용
        map: map,
        icon: {
            url: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png' // 빨간색 마커 아이콘 URL
        }
    });
       

 // 인포윈도우 생성
    var infowindow = new naver.maps.InfoWindow({
        content: '<h5>' + result.roadAddress + '</h5>'
    });

    // 마커 클릭 시 인포윈도우 표시
    naver.maps.Event.addListener(marker, "click", function(e) {
        if (infowindow.getMap()) {
            infowindow.close();
        } else {
            infowindow.open(map, marker);
        }
    });

    // 검색 결과를 테이블에 추가
    var mapList = "";
    mapList += "<tr>"
    mapList += " <td>" + result.roadAddress + "</td>"
    mapList += " <td>" + result.x + "</td>"
    mapList += " <td>" + result.y + "</td>"
    mapList += "</tr>"

    $('#mapList').html(mapList);
   }

   // 주소 검색 버튼 클릭 이벤트
   $('#submit').on('click', function(e) {
       e.preventDefault();
       var address = $('#address').val();
       searchAddressToCoordinate(address);
   });

   // 초기화 버튼 클릭 이벤트
   $('#clear').on('click', function(e) {
       e.preventDefault();
       // 검색 결과 초기화
       searchResult = null;
       // 지도 초기화
       selectMapList();
       // 테이블 초기화
       $('#mapList').html("");
   });

   // 지도를 그리는 함수
   function selectMapList() {
       var map = new naver.maps.Map('map', {
           center: new naver.maps.LatLng(37.3595704, 127.105399),
           zoom: 10
       });
   }

</script>
</body>
</html>