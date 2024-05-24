<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업/전시 관리자 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/goodsDetail.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
 <style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
</head>
<body>
				<%@include file="../includes/admin/header.jsp" %>
                
                <div class="admin_content_wrap">
                    
                    <div class="admin_content_subject"><span>팝업/전시 정보</span></div>

                    <div class="admin_content_main">
                    
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 이미지</label>
                    			</div>
                    			
                    			<div class="form_section_content">
									<div id="uploadResult">																		
									</div>
                    			</div>
                    		</div>

                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 이름</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="pName" value="<c:out value="${popsInfo.pName}"/>" disabled>
                    			</div>
                    		</div>
                    		  
                    		<!--<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 기간</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input value="<fmt:formatDate value='${popsInfo.startDate}' pattern='yyyy-MM-dd'/>" disabled>~
                    				<input value="<fmt:formatDate value='${popsInfo.endDate}' pattern='yyyy-MM-dd'/>" disabled>
                    			</div>
                    		</div>-->                    		                    	                    		                    		
                    		          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 기간</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="startDate" autocomplete="off" readonly="readonly" value="<c:out value="${popsInfo.startDate}"/>" disabled> ~
                    				<input name="endDate" autocomplete="off" readonly="readonly" value="<c:out value="${popsInfo.endDate}"/>" disabled>                  				
                    			</div>
                    		</div>                                		         		             
                              
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="pPrice" value="<c:out value="${popsInfo.pPrice}"/>" disabled>
                    			</div>
                    		</div> 
                    		               	                              	         		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 이용 시설 안내</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="pIntro" id="pIntro_textarea" disabled>${popsInfo.pIntro}</textarea>
                    			</div>
                    		</div>
                    		        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>팝업/전시 소개(상세 내용)</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="pContents" id="pContents_textarea" disabled>${popsInfo.pContents}</textarea>
                    			</div>
                    		</div>                    		
                   		
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">팝업/전시 목록</button>
	                    		<button id="modifyBtn" class="btn enroll_btn">수 정</button>
	                    	</div>  
                    </div>      

                	
                	<form id="moveForm" action="/admin/popsManage" method="get" >
 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
                	</form>
                	
                </div>
 				<%@include file="../includes/admin/footer.jsp" %>

	<script>
	
		$(document).ready(function(){							
			
			/* 팝업/전시 이용 시설 안내 */
			ClassicEditor
				.create(document.querySelector('#pIntro_textarea'))
				.then(editor => {
					console.log(editor);
					editor.isReadOnly = true;
				})
				.catch(error=>{
					console.error(error);
				});
				
			/* 팝업/전시 소개(상세 내용) */
			ClassicEditor
			.create(document.querySelector('#pContents_textarea'))
			.then(editor => {
				console.log(editor);
				editor.isReadOnly = true;
			})
			.catch(error=>{
				console.error(error);
			});														
			
			/* 팝업/전시 이미지 정보 호출 */
			let pId = '<c:out value="${popsInfo.pId}"/>';
			let uploadResult = $("#uploadResult");			
			
			$.getJSON("/getAttachList", {pId : pId}, function(arr){	
				
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
				str += "</div>";		
				
				uploadResult.html(str);						
				
			});					
			
			
		}); // $(document).ready
	
		/* 목록 이동 버튼 */
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			$("#moveForm").submit();	
		});	
		
		/* 수정 페이지 이동 */
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			let addInput = '<input type="hidden" name="pId" value="${popsInfo.pId}">';
			$("#moveForm").append(addInput);
			$("#moveForm").attr("action", "/admin/popsModify");
			$("#moveForm").submit();
		});			
		
	</script>

</body>
</html>