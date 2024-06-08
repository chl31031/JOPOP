package com.jopop.mapper;

import com.jopop.model.CartVO;
import com.jopop.model.MemberVO;
import com.jopop.model.OrderDTO;
import com.jopop.model.OrderItemDTO;
import com.jopop.model.OrderPageItemDTO;

public interface OrderMapper {
	
	//주문 상품 정보
	public OrderPageItemDTO getPopsInfo(int pId);
	
	//주문 상품 정보(주문 처리)
	public OrderItemDTO getOrderInfo(int pId);

	//주문 테이블 등록
	public int enrollOrder(OrderDTO ord);
	
	//주문 아이템 테이블 등록
	public int enrollOrderItem(OrderItemDTO orid);
	
	//주문 금액 차감
	public int deductMoney(MemberVO member);
}
