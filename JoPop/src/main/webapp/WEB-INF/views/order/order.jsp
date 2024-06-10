<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/order/order.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<title>예약 페이지</title>
</head>
<body>
<header>
    <!-- 로고 -->
    <div class="logo">
        <a href="/main">
            <img src="/resources/img/logo.png" alt="Logo">
        </a>
    </div>
    
    <!-- 사용자 정보 변화 테스트 
    <div>
    	<span>회원 : ${member.mName}</span>
		<span>충전금액 : <fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>
    </div>
    -->
    
    <!-- 예약하기 -->
    <div class="orderLogo">
    	<h1>예약하기</h1>
    </div>
</header>

	<div class="wrap">
		<h2>예약자 정보</h2>
		<div class="resPerson">
			<ul class="resPerson_list">
				<li><strong>${memberInfo.mName}</strong></li>
				<li>${memberInfo.mEmail}</li>
				<li>${memberInfo.mAddr2} ${memberInfo.mAddr3}  ( ${memberInfo.mAddr1} )</li>
				<li>* 이메일로 예약 정보가 발송됩니다.</li>
			</ul>
		</div>
		
		<h2>예약 팝업</h2>
		<div class="orderPop">
			<c:forEach items="${orderList}" var="ol">
				<ul class="list_pop">
					<li class="order_info_li">
						<input type="hidden" class="individaul_pId_input" value="${ol.pId}">
						<input type="hidden" class="individaul_pPrice_input" value="${ol.pPrice}">
						<input type="hidden" class="individaul_count_input" value="${empty ol.count ? 1 : ol.count}">
						<input type="hidden" class="individaul_totalPrice_input" value="${ol.pPrice * ol.count}">
						<input type="hidden" class="individaul_discount_input" value="${ol.discount}">
 						<input type="hidden" class="individaul_salePrice_input" value="${ol.salePrice}">
 						<input type="hidden" class="individaul_finalTotalPrice_input" value="${ol.finalTotalPrice}">
 						<input type="hidden" class="individaul_orderDate_input" value="${ol.orderDate}">
 						<input type="hidden" class="individaul_orderTime_input" value="${ol.orderTime}">
 					</li>
 					<li> 
						<div class="image_wrap" data-bookid="${ol.imageList[0].pId}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
							<img>
						</div>
					</li>
					<li>
						<div class="popup_details">
							<div class="popup_name">${ol.pName}</div>
							<div class="popup_price">예약금 : ${ol.pPrice}</div>
							<div class="button_quantity">
								예약 인원
								<span>
									<input type="text" class="quantity_input" value="${ol.count}">
									<button class="plus_btn">+</button>
									<button class="minus_btn">-</button>
								</span>
							</div>
							<div class="popup_orderDate">
								<label>예약 날짜</label>
								<input name="orderDate" autocomplete="off" readonly="readonly">
								<span class="ck_warn publeYear_warn"></span>
							</div>
							<div class="popup_orderTime">
								<label>예약 시간</label>
								<select class="orderTime" name="orderTime" size="1">
									<option value="선택하세요.">선택하세요.</option>
									<option value="10:00">10:00</option>
									<option value="11:00">11:00</option>
									<option value="12:00">12:00</option>
									<option value="13:00">13:00</option>
									<option value="14:00">14:00</option>
									<option value="15:00">15:00</option>
									<option value="16:00">16:00</option>
									<option value="17:00">17:00</option>
								</select>
							</div>
						</div>
					</li>
					<li>
						<button class="btn_delete">삭제</button>
					</li>
				</ul>
			</c:forEach>
		</div>
		
		<!-- 예약 가격 -->
		<div class="orderPrice">
			<table>
				<tr>
					<td>총 팝업 예약금</td>
					<td><span class="totalPrice_span"></span>원</td>
				</tr>
				<tr>
					<td>총 예약 건수</td>
					<td>
						<span class="totalKind_span"></span>팝업
						<span class="totalCount_span"></span>개
					</td>
				</tr>
			</table>
		</div>
		<div class="totalPrice">
			<table>
				<tr>
					<td class="finalTotalPrice_text"><strong>총 결제 금액</strong></td>
					<td><span class="finalTotalPrice_span"></span>원</td>
				</tr>
			</table>
		</div>
		
		<!-- 카드/머니(충전금) -->
		<h2>카드/머니</h2>
		<div class="money">
			<ul>
				<li>보유</li>
				<li>${memberInfo.money}</li>
				<li>
					<input class="order_money_input" value="0">원
					<a class="order_money_input_btn order_money_input_btn_N" data-state="N">모두사용</a>
					<a class="order_money_input_btn order_money_input_btn_Y" data-state="Y" style="display: none;">사용취소</a>
				</li>
				<div class="boundary_div"></div>
				<li>
					<input type="radio" value="카카오 페이 결제" name="paymentMethod">
					<label for="카카오 페이 결제">카카오 페이 결제</label>
				</li>
				<div class="boundary_div"></div>
				<li>
					<input type="radio" value="계좌 간편 결제" name="paymentMethod">
					<label for="카카오 페이 결제">계좌 간편 결제</label>
				</li>
				<div class="boundary_div"></div>
				<li>
					<input type="radio" value="카드 간편 결제" name="paymentMethod">
					<label for="카드 간편 결제">카드 간편 결제</label>
				</li>
			</ul>
		</div>
		
		<!-- 예약 버튼 -->
		<div class="button_set">
			<h5>예약 주문 내용을 확인하였으며 정보 제공 등에 동의합니다.</h5>
			<a class="btn_order">예약 결제하기</a>
		</div>
		
		<form class="order_form" action="/order" method="post">
			<!-- 예약자 회원 번호 -->
			<input name="mId" class="order_mId" value="${memberInfo.mId}" type="hidden">
			<!-- 사용 충전금 -->
			<input name="useMoney" class="order_useMoney" type="hidden" value="0">
			<!-- 상품 정보 -->
		</form>
	</div>

<script>
	<!-- 캘린더 위젯 설정 및 초기화 -->
    const config = {
            dateFormat: 'yy-mm-dd',
            showOn: "button",
            buttonText: "날짜 선택",
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            yearSuffix: '년'
    };

    $(function(){
        $("input[name='orderDate']").datepicker(config);
    });
    
    $("input[name='orderDate']").datepicker({
        ...config,
        onSelect: function(dateText) {
            var selectedDate = dateText;
            console.log("선택한 날짜:", selectedDate);
            
            // 예약 날짜를 ${ol.orderDate}에 할당
            $(".individaul_orderDate_input").val(selectedDate);
        }
    });

	//예약 요청
	$(".btn_order").on("click", function(){
		alert("결제 버튼 눌림");

		//사용한 금액
		//$(".input[name='useMoney']").val($(".order_money_input").val());
		let moneyInput = $(".order_money_input").val();
		$(".order_useMoney").val(moneyInput);
		
		let useMoney = $(".order_useMoney").val();
		let mId = $(".order_mId").val();
		
		//상품 정보
		let form_contents = '';
		$(".order_info_li").each(function(index, element){
			let pId = $(element).find(".individaul_pId_input").val();
			let count = $(element).find(".individaul_count_input").val();
			let orderDateString = $(element).find(".individaul_orderDate_input").val();
			let orderTime = $(element).find(".individaul_orderTime_input").val();
			
			// 주문 날짜 문자열을 Date 객체로 변환
		    let orderDate = new Date(orderDateString);
			
			let pId_input = "<input name='orders["+index+"].pId' type='hidden' value='"+pId+"'>";
			form_contents += pId_input;
			let count_input = "<input name='orders["+index+"].count' type='hidden' value='"+count+"'>";
			form_contents += count_input;
			let orderDate_input = "<input name='orders["+index+"].orderDate' type='hidden' value='"+orderDate+"'>";
			form_contents += orderDate_input;
			let orderTime_input = "<input name='orders["+index+"].orderTime' type='hidden' value='"+orderTime+"'>";
			form_contents += orderTime_input;
		});
		$(".order_form").append(form_contents);
		
		//서버 전송
		$(".order_form").submit();
	});
	
	$(document).ready(function(){
		
	   // 이미지 삽입
	   $(".image_wrap").each(function(i, obj){
	      const pobj = $(obj);
	      
	      if(pobj.data("pId")){
	         const uploadPath = pobj.data("path");
	         const uuid = pobj.data("uuid");
	         const fileName = pobj.data("filename");
	         
	         const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
	         
	         $(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
	      } else {
	         $(this).find("img").attr('src', '/resources/img/logo.png');
	      }
	   });
	   
	   let totalKind = 0;     //총 종류
	   
	   $(".order_info_li").each(function(index, element){
		  //총 종류
		  totalKind += 1;
	   });
	   
	   //총 종류 삽입
	   $(".totalKind_span").text(totalKind);

	});
	
	// 인원 버튼 조작
	$(document).on("click", ".plus_btn", function(){
	   let $quantityInput = $(this).siblings(".quantity_input");
	   let quantity = parseInt($quantityInput.val());
	   $quantityInput.val(++quantity);
	
	   updateTotalCount();
	   updateIndividualTotalPrice($(this).closest("ul"));
	});
	
	$(document).on("click", ".minus_btn", function(){
	   let $quantityInput = $(this).siblings(".quantity_input");
	   let quantity = parseInt($quantityInput.val());
	   if(quantity > 1){
	      $quantityInput.val(--quantity);
	   }
	
	   updateTotalCount();
	   updateIndividualTotalPrice($(this).closest("ul"));
	});
	
	/* 충전금 입력 */
	// 0 이상 & 최대 충전금 이하
	$(".order_money_input").on("propertychange change keyup paste input", function(){
	   const maxMoney = parseInt('${memberInfo.money}');
	   
	   let inputValue = parseInt($(this).val());
	   
	   if(inputValue < 0){
	      $(this).val(0);
	   } else if(inputValue > maxMoney){
	      $(this).val(maxMoney);
	   }   
	});
	
	// 충전금 모두 사용 취소 버튼 (Y: 모두 사용 / N: 모두 취소)
	$(".order_money_input_btn").on("click", function(){
	   const maxMoney = parseInt('${memberInfo.money}');   
	   
	   let state = $(this).data("state");   
	   
	   if(state == 'N'){
	      console.log("n동작");
	      /* 모두사용 */
	      // 값 변경
	      $(".order_money_input").val(maxMoney);
	      // 글 변경
	      $(".order_money_input_btn_Y").css("display", "inline-block");
	      $(".order_money_input_btn_N").css("display", "none");
	   } else if(state == 'Y'){
	      console.log("y동작");
	      /* 취소 */
	      // 값 변경
	      $(".order_money_input").val(0);
	      // 글 변경
	      $(".order_money_input_btn_Y").css("display", "none");
	      $(".order_money_input_btn_N").css("display", "inline-block");      
	   }      
	});
	
	// totalCount를 업데이트하는 함수
	function updateTotalCount() {
	   let totalCount = 0;
	   $(".quantity_input").each(function() {
	      totalCount += parseInt($(this).val());
	   });
	   $(".totalCount_span").text(totalCount);
	}
	
	// individaul_totalPrice_input 값을 업데이트하는 함수
	function updateIndividualTotalPrice($ul) {
		
	   const $orderInfoLi = $ul.find(".order_info_li");
	   const pPrice = parseInt($orderInfoLi.find(".individaul_pPrice_input").val());
	   const count = parseInt($ul.find(".quantity_input").val());
	   const totalPrice = pPrice * count;
	   //const discount = parseDouble($orderInfoLi.find(".individaul_discount_input").val());
	   const discount = 0.3;          //임의의 할인율
	   const salePrice = pPrice*discount*count;
	   const finalTotalPrice = totalPrice - salePrice;
	   $orderInfoLi.find(".individaul_totalPrice_input").val(totalPrice);
	   $orderInfoLi.find(".individaul_count_input").val(count);
	   $orderInfoLi.find(".individaul_discount_input").val(discount);
	   $orderInfoLi.find(".individaul_salePrice_input").val(salePrice);
	   $orderInfoLi.find(".individaul_finalTotalPrice_input").val(finalTotalPrice);
	   
		$(".orderTime").on("change", function(){
			//선택한 시간 값 가져오기
			var selectedTime = $(this).val();
			
			console.log(selectedTime);
			
			$orderInfoLi.find(".individaul_orderTime_input").val(selectedTime);
		});
		
	   updateTotalPrice();
	}
	
	// 전체 totalPrice를 업데이트하는 함수
	function updateTotalPrice() {
	   let totalPrice = 0;
	   let finalTotalPrice = 0;
	   $(".individaul_totalPrice_input").each(function() {
	      totalPrice += parseInt($(this).val());
	   });
	   $(".individaul_finalTotalPrice_input").each(function(){
		   finalTotalPrice += parseInt($(this).val());
	   });
	   $(".totalPrice_span").text(totalPrice);
	   $(".finalTotalPrice_span").text(finalTotalPrice);
	}
</script>
</body>
</html>