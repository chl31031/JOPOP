package com.jopop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jopop.mapper.OrderMapper;
import com.jopop.model.OrderPageItemDTO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	//주문 정보
	@Override
	public List<OrderPageItemDTO> getPopsInfo(List<OrderPageItemDTO> orders) {
		
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO orderInfo = orderMapper.getPopsInfo(ord.getpId());
			
			//goodsInfo.setBookCount(ord.getBookCount());
			//goodsInfo.initSaleTotal();
			
			result.add(orderInfo);
		}
		
		return result;
	}
}
