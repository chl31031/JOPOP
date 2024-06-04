package com.jopop.mapper;

import com.jopop.model.OrderPageItemDTO;

public interface OrderMapper {
	
	//주문 상품 정보
	public OrderPageItemDTO getPopsInfo(int pId);
	
	//주문 인원 수 수정
	public int modifyCont(OrderPageItemDTO order);
}
