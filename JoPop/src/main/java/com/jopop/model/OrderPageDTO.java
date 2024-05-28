package com.jopop.model;

import java.util.List;

//주문 정보 리스트로 가져오는 DTO
public class OrderPageDTO {
	
	private List<OrderPageItemDTO> orders;

	public List<OrderPageItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderPageItemDTO> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderPageDTO [orders=" + orders + "]";
	}
}
