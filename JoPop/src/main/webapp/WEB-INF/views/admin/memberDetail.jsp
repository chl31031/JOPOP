<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 상세 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/memberDetail.css">
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
                    
                    <div class="admin_content_subject"><span>회원 정보</span></div>

                    <div class="admin_content_main">                             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>아이디(이메일 형식)</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="mEmail" value="<c:out value="${memberInfo.mEmail}"/>" disabled>
                    			</div>
                    		</div>                   		                              		                    	                    		                    		
                    		          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>성명(닉네임)</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="mName" value="<c:out value="${memberInfo.pPrice}"/>" disabled>(
                    				<input name="mNick" value="<c:out value="${memberInfo.pPrice}"/>" disabled>)                  				
                    			</div>
                    		</div>                                		         		             
                              
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>주 소</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="mAddr1" value="<c:out value="${memberInfo.mAddr1}"/>" disabled>
                    				<input name="mAddr2" value="<c:out value="${memberInfo.mAddr2}"/>" disabled>
                    				<input name="mAddr3" value="<c:out value="${memberInfo.mAddr3}"/>" disabled>
                    			</div>
                    		</div> 
                    		               	                              	         		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>등 급</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<input name="memberShip" value="<c:out value="${memberInfo.memberShip}"/>" disabled>
                    			</div>
                    		</div>
                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>포인트</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<input name="money" value="<c:out value="${memberInfo.money}"/>" disabled>
                    			</div>
                    		</div>
                    		        		
                    		                    		
                   		
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">팝업/전시 목록</button>
	                    		<button id="modifyBtn" class="btn enroll_btn">수 정</button>
	                    	</div>  
                    </div>      

                	
                	<form id="moveForm" action="/admin/memberManage" method="get" >
 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
                	</form>
                	
                </div>
                
 				<!--원래 footer 있었음-->
 				
<script>
/* 목록 이동 버튼 */
$("#cancelBtn").on("click", function(e){
	e.preventDefault();
	$("#moveForm").submit();	
});	

/* 수정 페이지 이동 */
$("#modifyBtn").on("click", function(e){
	e.preventDefault();
	let addInput = '<input type="hidden" name="mId" value="${memberInfo.mId}">';
	$("#moveForm").append(addInput);
	$("#moveForm").attr("action", "/admin/memberModify");
	$("#moveForm").submit();
});	
</script>
</body>
</html>