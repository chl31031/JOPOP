package com.jopop.service;

import java.util.List;

import com.jopop.model.Criteria;
import com.jopop.model.OrderDTO;
import com.jopop.model.OrderItemDTO;
import com.jopop.model.OrderPageItemDTO;

public interface OrderService {
	
	//주문 정보
	public List<OrderPageItemDTO> getPopsInfo(List<OrderPageItemDTO> orders);

	//주문
	public void order(OrderDTO ord);
	
	//예약 조회 리스트
	public List<OrderItemDTO> getOrderList(Criteria cri);
	
	//예약 조회 총 갯수
	public int getOrderTotal(Criteria cri);
	
}
