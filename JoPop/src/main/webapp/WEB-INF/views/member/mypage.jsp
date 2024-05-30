<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../resources/css/member/mypage.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="../includes/header.jsp"%>
   <div class="wrap">
      <div class="mynav">
         <ul class="nav_list">
            <li class="mypage"><a href="/member/mypage">내 정보</a></li>
            <li class="cart"><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
            <li class="booking"><a href="/cart/orderItem">사전예약</a></li>
         </ul>
      </div>
      <div class="myinfo">
         <ul class="info_list">
            <li class="a">이름</li>
            <li class="b">${member.mName }</li>
            <li class="a">닉네임</li>
            <li class="b">${member.mNick }</li>
            <li class="a">이메일</li>
            <li class="b">${member.mEmail }</li>
            <li class="a">주소</li>
            <li class="b">${member.mAddr2} ${member.mAddr3}</li>
            <li class="a">멤버십</li>
            <li class="b">${member.memberShip }</li>
            <li class="a">머니</li>
            <li class="b">${member.money }</li>
            <li class="a">내 작성 후기</li>
            <li>
	          	<div class="section review-section">
				    <c:if test="${not empty reviews}">
				        <c:forEach var="review" items="${reviews}">
				            <div class="review">
				            	<p>팝업: ${review.pName}</p>
				                <p>내용: ${review.contents}</p>
				                <p>평점: ${review.score}</p>
				                <p>작성일: <fmt:formatDate value="${review.rDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></p>
				                <c:if test="${not empty review.imageList}">
			                <c:forEach items="${review.imageList}" var="image">
							    <img src="http://localhost:8080/pop/display?fileName=${image.uploadPath.replace("\\", "/")}/${image.uuid}_${image.fileName}" alt="이미지" style="max-width: 100px;">
							</c:forEach>
							       </c:if>
				            </div>
				            <div class="review-btn">
				            	<input type="hidden" name="pName" value="${review.pName}">
				            	<input type="hidden" name="pId" value="${review.pId}">
				            	<input type="hidden" name="mId" value="${review.mId}">
				            	<button class="btn_delete">삭제</button>
				            	<button class="btn_modify">수정</button>
				            </div>
				            <div id='modify-form'>
				            	<div class="rating">
				                    <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
				                    <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
				                    <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
				                    <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
				                    <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
				                </div>
				                <div id="uploadResult"></div>
				                <form class="review-form" id="reviewForm" enctype="multipart/form-data">
				                    <input type="hidden" name="pId" value="${review.pId}">
				                    <input type="hidden" name="pName" value="${review.pName}">
				            		<input type="hidden" name="mId" value="${review.mId}">
				                    <textarea name="contents" placeholder="리뷰를 입력하세요"></textarea>
				                    <input type="hidden" name="score" value="">
				                    <div class="button-group">
				                        <button type="submit">후기 등록</button>
				                    </div>
				                </form>
				            </div>
				            <div class="review-divider"></div>
				        </c:forEach>
				    </c:if>
				    <c:if test="${empty reviews}">
				        <p>등록된 후기가 없습니다. 첫 번째 후기를 작성해 보세요!</p>
				    </c:if>
				</div>
            </li>
         </ul>
      </div>
   </div>
   
      <%@include file="../nav/nav.jsp"%>

      <%@include file="../includes/footer.jsp"%>
      
<script>
	//삭제 버튼
	$(".btn_delete").on("click", function(e){
		var result = confirm("리뷰 삭제하시겠습니까?");
		
		if(result == true){
			alert("리뷰 삭제되었습니다.");
			
			var pId = $(this).siblings('input[name="pId"]').val();   //pId 추출
			var mId = $(this).siblings('input[name="mId"]').val();   //mId 추출
			
			console.log(pId);
			console.log(mId);
			
			$.ajax({
				type: 'POST',
				url: '/member/delete',
				data: {pId: pId, mId: mId},
				success: function(response){
					//성공적 요청 보냈을 때 처리
					console.log("Ajax 요청 성공: ", response);
				},
				error: function(xhr, status, error){
					//요청 보내기 실패
					console.error("Ajax 요청 실패 : ",status, error);
				}
			});
			
		}else if(result == false){
			alert("삭제 취소되었습니다.");
		}
		
	});
	
	//수정 버튼
	$(".btn_modify").on("click", function(e){
		alert("수정 버튼");
		
		const mydiv = document.getElementById('modify-form');
		  
		if(mydiv.style.display === 'block') {
		  mydiv.style.display = 'none';
		}else {
		  mydiv.style.display = 'block';
		}
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

        var formData = new FormData(this);
        var files = $('input[name="uploadFile"]')[0].files;

        if (files.length > 0) {
            // 이미지가 있는 경우 이미지 업로드 후 리뷰 등록
            uploadImagesAndSubmitReview(files, formData);
        } else {
            // 이미지가 없는 경우 바로 리뷰 등록
            submitReviewForm([]);
        }
    });

    // 이미지 업로드 및 삭제 처리
    $("input[type='file']").on("change", function(e) {
        // 이미지를 업로드하기 전에 기존 이미지를 삭제합니다.
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
        reviewFormData.append('pName', $('input[name="pName"]').val());
        reviewFormData.append('mId', $('input[name="mId"]').val());
        reviewFormData.append('imageList', JSON.stringify(imageList)); // JSON 문자열로 변환하여 전송

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
                if (xhr.status === 401) {
                    alert("로그인이 필요합니다.");
                    window.location.href = "${pageContext.request.contextPath}/nav/prelogin";
                } else {
                    alert("후기 등록 중 오류가 발생했습니다.");
                }
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
            data: {fileName: targetFile},
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
   
</body>
</html>
