<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/order/order.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
						<input type="hidden" class="individaul_pPrice_input" value="${ol.pPrice}">
						<input type="hidden" class="individaul_salePrice_input" value="${ol.salePrice}">
						<input type="hidden" class="individaul_count_input" value="${ol.count}">
						<input type="hidden" class="individaul_totalPrice_input" value="${ol.salePrice * ol.count}">
 					</li>
					<li><img src="/resources/eximg/mokk.png" style="width: 100px;"></li>
					<li class="popup-name">${ol.pName}</li>
					<li class="popup-price">${ol.pPrice}</li>
					<li class="button_quantity">
						예약 인원
						<input type="text" class="quantity_input" value="1">
						<span>
							<button class="plus_btn">+</button>
							<button class="minus_btn">-</button>
						</span>
					</li>
					<li class="delete_btn">
						<button>삭제</button>
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
					<td class="totalPrice_text"><strong>총 결제 금액</strong></td>
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
				<li>
					<button>전액 사용</button>
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
	</div>

<script>
	//서버로 전송할 데이터
	const form = {
			mId : '${member.mId}',
			pId : '${ol.pId}',
			Count : ''
	}
	
	$(document).ready(function(){
		let totalPrice = 0;        //총 가격 
		let totalCount = 0;        //총 갯수
		let totalKind = 0;         //총 종류
		let finalTotalPrice = 0;   //최종 가격 (총 가격 - 멤버십별 할인)
		
		$(".order_info_li").each(function(index, element){
			
			//총 가격
			totalPrice += parseInt($(element).find(".individaul_totalPrice_input").val());
			//총 갯수
			totalCount += parseInt($(element).find(".individaul_count_input").val());
			//총 종류
			totalKind += 1;
		});
		
		//최종 가격
		//finalTotalPrice = totalPrice - salePrice;
		
		console.info(totalPrice);
		
		//값 삽입
		//총 가격
		$(".totalPrice_span").text(totalPrice.toLocaleString());
		//총 갯수
		$(".totalCount_span").text(totalCount);
		//총 종류
		$(".totalKind_span").text(totalKind);
		//최종 가격(총 가격 - 멤버십별 할인)
		//$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
	});

	//수량 버튼 조작
	let quantity = $(".quantity_input").val();
	$(".plus_btn").on("click", function(){
		alert("수량이 +1 올라갑니다.");
		$(".quantity_input").val(++quantity);
	});
	$(".minus_btn").on("click", function(){
		alert("수량이 -1 내려갑니다.");
		if(quantity > 1){
			$(".quantity_input").val(--quantity);	
		}
	});
	
	/* 충전금 입력 */
	//0 이상 & 최대 충전금 이하
	$(".order_money_input").on("propertychange change keyup paste input", function(){
		const maxMoney = parseInt('${memberInfo.money}');
		
		let inputValue = parseInt($(this).val());
		
		if(inputValue < 0){
			$(this).val(0);
		} else if(inputValue > maxMoney){
			$(this).val(maxMoney);
		}	
	});
	
	//적립금 모두 사용 취소 버튼 (Y: 모두 사용 / N: 모두 취소)
	$(".order_money_input_btn").on("click", function(){
		const maxMoney = parseInt('${memberInfo.money}');	
		
		let state = $(this).data("state");	
		
		if(state == 'N'){
			console.log("n동작");
			/* 모두사용 */
			//값 변경
			$(".order_money_input").val(maxMoney);
			//글 변경
			$(".order_money_input_btn_Y").css("display", "inline-block");
			$(".order_money_input_btn_N").css("display", "none");
		} else if(state == 'Y'){
			console.log("y동작");
			/* 취소 */
			//값 변경
			$(".order_money_input").val(0);
			//글 변경
			$(".order_money_input_btn_Y").css("display", "none");
			$(".order_money_input_btn_N").css("display", "inline-block");		
		}		
	});

</script>
</body>
</html>