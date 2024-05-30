<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 수정 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/popsModify.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />

<!-- 캘린더 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<style>
/*datepicker에서 사용한 이미지 버튼 style적용*/
            img.ui-datepicker-trigger {
                margin-left:5px; vertical-align:middle; cursor:pointer;
</style>

<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
</head>
<body>

         <%@include file="../includes/admin/header.jsp" %>
            
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>팝업/전시 정보 수정</span></div>
                    <div class="admin_content_main">
                       <form action="/admin/popsModify" method="post" id="modifyForm">
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 이름</label>
                             </div>
                             <div class="form_section_content">
                                <input name="pName" value="${popsInfo.pName}">
                                <span class="ck_warn pName_warn">팝업/전시 이름을 입력해주세요.</span>
                             </div>
                          </div>
                         
                          <div class="form_section">
    <div class="form_section_title">
      <label>기간</label>
    </div>
    <div class="form_section_content">
      <label for="startDate">시작일</label>
      <input name="startDate" id="startDate" value="${popsInfo.startDate }">
      ~
      <label for="endDate">종료일</label>
      <input name="endDate" id="endDate" value="${popsInfo.endDate }">
      <span class="ck_warn startDate_warn">일정(시작일과 종료일)을 선택해주세요.</span>
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
                <option selected value="${popsInfo.cate1 }">선택</option>
            </select>
        </div>
        <div class="cate_wrap">
            <span>시/군/구</span>
            <select class="cate2">
                <option selected value="${popsInfo.cate }">선택</option>
            </select>
        </div>
        <span class="ck_warn cateCode_warn">지역을 선택해주세요.</span>
    </div>
</div>
                                   
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>가격</label>
                             </div>
                             <div class="form_section_content">
                                <input name="pPrice" value="${popsInfo.pPrice}">원
                                <span class="ck_warn pPrice_warn">팝업/전시 가격을 입력해주세요.</span>
                             </div>
                          </div>                                                                    
                                        
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>이용 시설 안내</label>
                             </div>
                             <div class="form_section_content bit">
                                <textarea name="pIntro" id="pIntro_textarea">${popsInfo.pIntro}</textarea>
                                <span class="ck_warn pIntro_warn">이용 시설 안내를 입력해주세요.</span>
                             </div>
                          </div>              
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 소개(상세 내용)</label>
                             </div>
                             <div class="form_section_content bct">
                                <textarea name="pContents" id="pContents_textarea">${popsInfo.pContents}</textarea>
                                <span class="ck_warn pContents_warn">팝업/전시 상세 정보를 입력해주세요.</span>
                             </div>
                          </div>
                          
                          <div class="form_section">
                             <div class="form_section_title">
                                <label>팝업/전시 이미지</label>
                             </div>
                             <div class="form_section_content">
                           		<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
                           		<div id="uploadResult">                                     
                           </div>                           
                             </div>
                          </div>
                                                    
                          <input type="hidden" name='pId' value="${popsInfo.pId}">
                        </form>
                            <div class="btn_section">
                              <button id="cancelBtn" class="btn">취 소</button>
                             <button id="modifyBtn" class="btn modify_btn">수 정</button>
                             <button id="deleteBtn" class="btn delete_btn">삭 제</button>
                          </div> 
                    </div> 
                              
                   <form id="moveForm" action="/admin/popsManage" method="get" >
                   <input type="hidden" name="pageNum" value="${cri.pageNum}">
                  <input type="hidden" name="amount" value="${cri.amount}">
                  <input type="hidden" name="keyword" value="${cri.keyword}">
                  <input type="hidden" name='pId' value="${popsInfo.pId}">
                   </form>                                
                </div>
 
             <!--원래 footer 있었음-->
                          
                 <script>
    $(function() {
      // Datepicker 한국어 설정
      $.datepicker.setDefaults($.datepicker.regional['ko']); 

      function initializeDatePickers() {
        var startDateValue = $("#startDate").val();
        var endDateValue = $("#endDate").val();

        $('#startDate').datepicker({
          showOn: "both",             
          buttonText: "날짜선택",    
          dateFormat: "yy-mm-dd",    
          changeMonth: true,        
          onClose: function(selectedDate) {    
            $("#endDate").datepicker("option", "minDate", selectedDate);
            validateDates();
          }                
        });

        $('#endDate').datepicker({
          showOn: "both",            
          buttonText: "날짜선택",
          dateFormat: "yy-mm-dd",
          changeMonth: true,
          onClose: function(selectedDate) {
            $("#startDate").datepicker("option", "maxDate", selectedDate);
            validateDates();
          }                
        });

        // 시작일과 종료일의 값이 있으면 datepicker에 설정
        if (startDateValue) {
          $('#startDate').datepicker("setDate", startDateValue);
        }
        if (endDateValue) {
          $('#endDate').datepicker("setDate", endDateValue);
        }
      }

      function validateDates() {
        var startDate = $('#startDate').datepicker('getDate');
        var endDate = $('#endDate').datepicker('getDate');
        if (startDate && endDate) {
          $('.startDate_warn').hide();
        } else {
          $('.startDate_warn').show();
        }
      }

      initializeDatePickers();
      validateDates();
    });
  </script>
                <!--캘린더 끝-->                           
<script>                         
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
         
         
         /* 위지윅 적용 */
          
            /* 이용 시설 안내 */
         ClassicEditor
            .create(document.querySelector('#pIntro_textarea'))
            .catch(error=>{
               console.error(error);
            });
            
            /* 팝업/전시 소개(상세 내용) */   
         ClassicEditor
         .create(document.querySelector('#pContents_textarea'))
         .catch(error=>{
            console.error(error);
         });                                         
         
         /* 기존 이미지 출력 */
         let pId = '<c:out value="${popsInfo.pId}"/>';
         let uploadResult = $("#uploadResult");
         
         $.getJSON("/getAttachList", {pId : pId}, function(arr){
            
            console.log(arr);
            
            if(arr.length === 0){
               
               
               let str = "";
               str += "<div id='result_card'>";
               str += "<img src='/resources/img/noimage.png'>";
               str += "</div>";
               
               uploadResult.html(str);            
               return;
            }
            
            let str = "";
            let obj = arr[0];
            
            let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
            str += "<div id='result_card'";
            str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
            str += ">";
            str += "<img src='/display?fileName=" + fileCallPath +"'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";            
            str += "</div>";
            
            uploadResult.html(str);         
            
         });// GetJSON            
         
      }); // document ready
   
</script>          
   
<script>
   
/*카테고리(지역)*/
let cateList = JSON.parse('${cateList}');

let cate1Array = [];
let cate2Array = [];

let cateSelect1 = $(".cate1");
let cateSelect2 = $(".cate2");

//카테고리(지역) 배열 초기화 메서드
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

//배열 초기화
makeCateArray(cate1Array, cateList, 1);
makeCateArray(cate2Array, cateList, 2);

//시/도(대분류) <option> 태그 추가
$(document).ready(function() {
 for (let i = 0; i < cate1Array.length; i++) {
     cateSelect1.append("<option value='" + cate1Array[i].cateCode + "'>" + cate1Array[i].cateName + "</option>");
 }
});

//시/도 선택 시 시/군/구(중분류) <option> 태그 추가
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
      
            
   /* 취소 버튼 */
   $("#cancelBtn").on("click", function(e){
      e.preventDefault();
      $("#moveForm").submit();
   });
   
   /* 삭제 버튼 */
   $("#deleteBtn").on("click", function(e){
      e.preventDefault();
      let moveForm = $("#moveForm");
      moveForm.find("input").remove();
      moveForm.append('<input type="hidden" name="pId" value="${popsInfo.pId}">');
      moveForm.attr("action", "/admin/popsDelete");
      moveForm.attr("method", "post");
      moveForm.submit();
   });   
   
   /* 수정 버튼 */
   $("#modifyBtn").on("click",function(e){      
      e.preventDefault();
      
      /*/ 체크 변수 
      let pNameCk = false;
      let startDateCk = false;
      let endtDateCk = false;
      let cateCodeCk = false;
      let priceCk = false;
      let introCk = false;
      let contentsCk = false;   
      
      // 체크 대상 변수 
      let pName = $("input[name='pName']").val();
      let startDate = $("input[name='startDate']").val();
      let endtDate = $("input[name='endDate']").val();
      let cateCode = $("select[name='cateCode']").val();
      let pPrice = $("input[name='pPrice']").val();          
      let pIntro = $(".bit p").html();
      let pContents = $(".bct p").html();   
      
      // 공란 체크 
      if(pName){
         $(".pName_warn").css('display','none');
         pNameCk = true;
      } else {
         $(".pName_warn").css('display','block');
         pNameCk = false;
      }
          
      if(startDate){
         $(".startDate_warn").css('display','none');
        startDateCk = true;
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
      
      if(pPrice != 0){
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
      
      // 최종 확인 
      if(pNameCk && startDateCk && endDateCk && cateCodeCk && priceCk && introCk && contentsCk ){
         $("#modifyForm").submit();
      } else {
         return false;
      }*/
      
   
  
      // 필드 유효성 검사 함수
      function validateField(selector, warningSelector, invalidValue = "") {
        let value = $(selector).val();
        if (value && value !== invalidValue) {
          $(warningSelector).hide();
          return true;
        } else {
          $(warningSelector).show();
          return false;
        }
      }
      
      // 폼 데이터 유효성 검사
      let pNameCk = validateField("input[name='pName']", ".pName_warn");
      let startDateCk = validateField("input[name='startDate']", ".startDate_warn");
      let endDateCk = validateField("input[name='endDate']", ".endDate_warn");
      let cateCodeCk = validateField("select[name='cateCode']", ".cateCode_warn", "none");
      let priceCk = validateField("input[name='pPrice']", ".pPrice_warn", "0");
      let introCk = validateField("#pIntro_textarea", ".pIntro_warn", "<br data-cke-filler='true'>");
      let contentsCk = validateField("#pContents_textarea", ".pContents_warn", "<br data-cke-filler='true'>");
      
      // 최종 확인
      if (pNameCk && startDateCk && endDateCk && cateCodeCk && priceCk && introCk && contentsCk) {
        $("#modifyForm").submit();
      }
    });
      
   });   
   
   /* 이미지 삭제 버튼 동작 */
   $("#uploadResult").on("click", ".imgDeleteBtn", function(e){
      
      deleteFile();
      
   });
   
   /* 파일 삭제 메서드 }안에 넣음*/
   function deleteFile(){

      $("#result_card").remove();

   }   
   
   /* 이미지 업로드 */
   $("input[type='file']").on("change", function(e){
      
      /* 이미지 존재시 삭제 */
      if($("#result_card").length > 0){
         deleteFile();
      }
            
      let formData = new FormData();
      let fileInput = $('input[name="uploadFile"]');
      let fileList = fileInput[0].files;
      let fileObj = fileList[0];
      
      if(!fileCheck(fileObj.name, fileObj.size)){
         return false;
      }
      
      formData.append("uploadFile", fileObj);
      
      $.ajax({
         url: '/admin/uploadAjaxAction',
          processData : false,
          contentType : false,
          data : formData,
          type : 'POST',
          dataType : 'json',
          success : function(result){
             console.log(result);
             showUploadImage(result);
          },
          error : function(result){
             alert("이미지 파일이 아닙니다.");
          }
      });      

      
   });
      
   /* var, method related with attachFile */
   let regex = new RegExp("(.*?)\.(jpg|png)$");
   let maxSize = 1048576; //1MB   
   
   function fileCheck(fileName, fileSize){

      if(fileSize >= maxSize){
         alert("파일 사이즈 초과");
         return false;
      }
           
      if(!regex.test(fileName)){
         alert("해당 종류의 파일은 업로드할 수 없습니다.");
         return false;
      }
      
      return true;      
      
   }
   
   //이미지 출력
   function showUploadImage(uploadResultArr){
      
      /* 전달받은 데이터 검증 */
      if(!uploadResultArr || uploadResultArr.length == 0){return}
      
      let uploadResult = $("#uploadResult");
      
      let obj = uploadResultArr[0];
      
      let str = "";
      
      let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
      //같은 기능
      
      str += "<div id='result_card'>";
      str += "<img src='/display?fileName=" + fileCallPath +"'>";
      str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
      str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
      str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
      str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";      
      str += "</div>";      
      
         uploadResult.append(str);     
        
   }         
   </script>   
</body>
</html>