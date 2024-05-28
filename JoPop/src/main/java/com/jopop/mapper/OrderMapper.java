package com.jopop.mapper;

import com.jopop.model.OrderPageItemDTO;

public interface OrderMapper {
	
	//주문 상품 정보
	public OrderPageItemDTO getGoodsInfo(int pId);
}
