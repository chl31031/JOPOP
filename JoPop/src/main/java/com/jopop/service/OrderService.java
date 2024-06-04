package com.jopop.service;

import java.util.List;

import com.jopop.model.OrderPageItemDTO;

public interface OrderService {
	
	//주문 정보
	public List<OrderPageItemDTO> getPopsInfo(List<OrderPageItemDTO> orders);

}
