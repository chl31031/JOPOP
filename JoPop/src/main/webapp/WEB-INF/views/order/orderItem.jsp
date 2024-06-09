<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 예약</title>
<link rel="stylesheet" href="../resources/css/order/orderItem.css">
</head>
<body>
<%@include file="../includes/header.jsp"%>
   <div class="wrap">
      <div class="mynav">
         <ul class="nav_list">
            <li class="mypage"><a href="/member/mypage">내 정보</a></li>
            <li class="cart"><a href="/cart/cart/${member.mId}">관심 팝업</a></li>
            <li class="booking"><a href="/order/orderItem">사전예약</a></li>
         </ul>
      </div>
      <div class="orderinfo">
			<!-- 예약 O -->
			<div>
			<c:if test="${listCheck != 'empty' }">
				<c:forEach items="${list}" var="list">
					<tr class="list">
						<td class="image">
							<img src="/resources/img/logo.png">
						</td>
						<td class="detail">
							<div class="title"><c:out value="${list.pName}"></c:out></div>
							<div class="orderId">예약 번호 : <c:out value="${list.orderId}"></c:out></div>
							<div class="orderDate">예약 날짜 : <fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></div>
							<div class="orderTime">예약 시간 : <c:out value="${list.orderTime}"></c:out></div>
							<div class="count">예약 인원 : <c:out value="${list.count}"></c:out> 명</div>
							<div class="price">
								<div class="totalPrice">총 금액 : <c:out value="${list.totalPrice}"></c:out> 원</div>
							</div>
							<div class="delete_div">
								<button class="delete_btn">예약 취소</button>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 예약 X -->
			<c:if test="${listCheck == 'empty' }">
				<div class="table_empty">
					결제된 예약이 없습니다.
				</div>
			</c:if>
			</div>
			
			<!-- 페이지 이동 인터페이스 영역 -->
            <div class="pageMaker_wrap" >
	              <ul class="pageMaker">
		              <!-- 이전 버튼 -->
		              <c:if test="${pageMaker.prev}">
			             <li class="pageMaker_btn prev">
			                  <a href="${pageMaker.pageStart - 1}">이전</a>
			             </li>
		              </c:if>
		                    	
		              <!-- 페이지 번호 -->
		              <c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
		                 <li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
		                    	<a href="${num}">${num}</a>
		                 </li>
		              </c:forEach>
		                    	
		              <!-- 다음 버튼 -->
		                 <c:if test="${pageMaker.next}">
		                    <li class="pageMaker_btn next">
		                    	<a href="${pageMaker.pageEnd + 1 }">다음</a>
		                    </li>
		                 </c:if>
	              </ul>   
            </div>
                    
			<form id="moveForm" action="/admin/orderList" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			</form>                            
      </div>        
	</div>	
      <%@include file="../nav/nav.jsp"%>

      <%@include file="../includes/footer.jsp"%>

<script>
	/* 페이지 이동 버튼 */
	const moveForm = $('#moveForm');
	
	$(".pageMaker_btn a").on("click", function(e) {
	
		e.preventDefault();
	
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	
		moveForm.submit();
	
	});
	
	$(document).ready(function() {
			/* 이미지 삽입 */
			$(".image_wrap").each(function(i, obj) {
					const bobj = $(obj);
					const uploadPath = bobj.data("path");
					const uuid = bobj.data("uuid");
					const fileName = bobj.data("filename");
					const filecallPath = encodeURIComponent(uploadPath+ "/s_"+ uuid+ "-"+ fileName);
	
			$(this).find("img").attr('src','display?fileName='+ fileCallPath);
			});
	});
</script>
</body>
</html>