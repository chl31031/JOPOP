<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 수정 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/goodsModify.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>팝업/전시 정보 수정</span>
		</div>
		<div class="admin_content_main">
			<form action="/admin/popsModify" method="post" id="modifyForm">
				<div class="form_section">
					<div class="form_section_title">
						<label>팝업/전시 이름</label>
					</div>
					<div class="form_section_content">
						<input name="pName" value="${popsInfo.pName}"> <span
							class="ck_warn pName_warn">팝업/전시 이름을 입력해주세요.</span>
					</div>
				</div>

				<div class="form_section">
					<div class="form_section_title">
						<label>기간</label>
					</div>
					<div class="form_section_content">
						<input name="startDate" value="${popInfo.startDate }">~ <input
							name="endDate" value="${popInfo.endDate }"> <span
							class="ck_warn startDate_warn">일정(시작일과 종료일)을 선택해주세요.</span>
					</div>
				</div>

				<div class="form_section">
					<div class="form_section_title">
						<label>지역 카테고리</label>
					</div>
					<div class="form_section_content">
						<div class="cate_wrap">
							<span>대분류</span> <select class="cate1">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>중분류</span> <select class="cate2">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>소분류</span> <select class="cate3" name="cateCode">
								<option selected value="none">선택</option>
							</select>
						</div>
						<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>
					</div>
				</div>

				<div class="form_section">
					<div class="form_section_title">
						<label>가격</label>
					</div>
					<div class="form_section_content">
						<input name="pPrice" value="${popsInfo.pPrice}">원 <span
							class="ck_warn pPrice_warn">팝업/전시 가격을 입력해주세요.</span>
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
						<input type="file" id="fileItem" name='uploadFile'
							style="height: 30px;">
						<div id="uploadResult"></div>
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

		<form id="moveForm" action="/admin/popsManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
				type="hidden" name="amount" value="${cri.amount}"> <input
				type="hidden" name="keyword" value="${cri.keyword}"> <input
				type="hidden" name='pId' value="${popsInfo.pId}">
		</form>
	</div>

	<script>
                /* 캘린더 위젯 적용 */
                $(function() {
                   
                    //datepicker 한국어로 사용하기 위한 언어설정
                    $.datepicker.setDefaults($.datepicker.regional['ko']); 
                    
                    // 시작일(startDate)은 종료일(endDate) 이후 날짜 선택 불가
                    // 종료일(endDate)은 시작일(startDate) 이전 날짜 선택 불가

                    //시작일.
                    $('#startDate').datepicker({
                        showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)       
                        buttonText: "날짜선택",             // 버튼의 대체 텍스트
                        dateFormat: "yy-mm-dd",             // 날짜의 형식
                        changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
                        //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
                        onClose: function( selectedDate ) {    
                            // 시작일(startDate) datepicker가 닫힐때
                            // 종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                            $("#endDate").datepicker( "option", "minDate", selectedDate );
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
                            // 종료일(startDate) datepicker가 닫힐때
                            // 시작일(endDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                            $("#startDate").datepicker( "option", "maxDate", selectedDate );
                        }                
                    });
                });
                <!--캘린더 끝-->                           
         
         /* 카테고리 */
         let cateList = JSON.parse('${cateList}');

         let cate1Array = new Array();
         let cate2Array = new Array();
         let cate3Array = new Array();
         let cate1Obj = new Object();
         let cate2Obj = new Object();
         let cate3Obj = new Object();
         
         let cateSelect1 = $(".cate1");      
         let cateSelect2 = $(".cate2");
         let cateSelect3 = $(".cate3");
         
         /* 카테고리 배열 초기화 메서드 */
         function makeCateArray(obj,array,cateList, tier){
            for(let i = 0; i < cateList.length; i++){
               if(cateList[i].tier === tier){
                  obj = new Object();
                  
                  obj.cateName = cateList[i].cateName;
                  obj.cateCode = cateList[i].cateCode;
                  obj.cateParent = cateList[i].cateParent;
                  
                  array.push(obj);            
                  
               }
            }
         }   
         
            /* 배열 초기화 */
         makeCateArray(cate1Obj,cate1Array,cateList,1);
         makeCateArray(cate2Obj,cate2Array,cateList,2);
         makeCateArray(cate3Obj,cate3Array,cateList,3);
         
         
         let targetCate2 = '';
         let targetCate3 = '${goodsInfo.cateCode}';
         
            /* 소분류 */
         for(let i = 0; i < cate3Array.length; i++){
            if(targetCate3 === cate3Array[i].cateCode){
               targetCate3 = cate3Array[i];
            }
         }// for         
         
         for(let i = 0; i < cate3Array.length; i++){
            if(targetCate3.cateParent === cate3Array[i].cateParent){
               cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
            }
         }            
         
         $(".cate3 option").each(function(i,obj){
            if(targetCate3.cateCode === obj.value){
               $(obj).attr("selected", "selected");
            }
         });         
         
            /* 중분류 */
         for(let i = 0; i < cate2Array.length; i++){
            if(targetCate3.cateParent === cate2Array[i].cateCode){
               targetCate2 = cate2Array[i];   
            }
         }// for      
         
         for(let i = 0; i < cate2Array.length; i++){
            if(targetCate2.cateParent === cate2Array[i].cateParent){
               cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
            }
         }      
         
         $(".cate2 option").each(function(i,obj){
            if(targetCate2.cateCode === obj.value){
               $(obj).attr("selected", "selected");
            }
         });            
         
         
            /* 대분류 */
         for(let i = 0; i < cate1Array.length; i++){
            cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
         }   
         
         $(".cate1 option").each(function(i,obj){
            if(targetCate2.cateParent === obj.value){
               $(obj).attr("selected", "selected");
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
   
   /* 카테고리 */
   let cateList = JSON.parse('${cateList}');

   let cate1Array = new Array();
   let cate2Array = new Array();
   let cate3Array = new Array();
   let cate1Obj = new Object();
   let cate2Obj = new Object();
   let cate3Obj = new Object();
   
   let cateSelect1 = $(".cate1");      
   let cateSelect2 = $(".cate2");
   let cateSelect3 = $(".cate3");
   
   /* 카테고리 배열 초기화 메서드 */
   function makeCateArray(obj,array,cateList, tier){
      for(let i = 0; i < cateList.length; i++){
         if(cateList[i].tier === tier){
            obj = new Object();
            
            obj.cateName = cateList[i].cateName;
            obj.cateCode = cateList[i].cateCode;
            obj.cateParent = cateList[i].cateParent;
            
            array.push(obj);            
            
         }
      }
   }   
   
      /* 배열 초기화 */
   makeCateArray(cate1Obj,cate1Array,cateList,1);
   makeCateArray(cate2Obj,cate2Array,cateList,2);
   makeCateArray(cate3Obj,cate3Array,cateList,3);

   
      /* 중분류 <option> 태그 */
   $(cateSelect1).on("change",function(){
      
      let selectVal1 = $(this).find("option:selected").val();   
      
      cateSelect2.children().remove();
      cateSelect3.children().remove();
      
      cateSelect2.append("<option value='none'>선택</option>");
      cateSelect3.append("<option value='none'>선택</option>");
      
      for(let i = 0; i < cate2Array.length; i++){
         if(selectVal1 === cate2Array[i].cateParent){
            cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");   
         }
      }// for
      
   });
   
      /* 소분류 <option>태그 */
   $(cateSelect2).on("change",function(){
      
      let selectVal2 = $(this).find("option:selected").val();
      
      cateSelect3.children().remove();
      
      cateSelect3.append("<option value='none'>선택</option>");      
      
      for(let i = 0; i < cate3Array.length; i++){
         if(selectVal2 === cate3Array[i].cateParent){
            cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");   
         }
      }// for      
      
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
      
      /* 체크 변수 */
      let pNameCk = false;
      let startDateCk = false;
      let endtDateCk = false;
      let cateCodeCk = false;
      let priceCk = false;
      let introCk = false;
      let contentsCk = false;   
      
      /* 체크 대상 변수 */
      let pName = $("input[name='bookName']").val();
      let startDate = $("input[name='startDate']").val();
      let endtDate = $("input[name='endDate']").val();
      let cateCode = $("select[name='cateCode']").val();
      let pPrice = $("input[name='pPrice']").val();          
      let pIntro = $(".bit p").html();
      let pContents = $(".bct p").html();   
      
      /* 공란 체크 */
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
      
      /* 최종 확인 */
      if(pNameCk && startDateCk && endDateCk && cateCodeCk && priceCk && introCk && contentsCk ){
         $("#modifyForm").submit();
      } else {
         return false;
      }
      
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