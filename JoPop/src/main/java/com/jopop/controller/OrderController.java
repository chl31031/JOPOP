package com.jopop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.jopop.model.OrderPageDTO;
import com.jopop.service.MemberService;
import com.jopop.service.OrderService;

@Controller
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberSerivce;
	
	
	@GetMapping("/order/{mId}")
	public String orderPageGet(@PathVariable("mId") int mId, OrderPageDTO opd, Model model) {
		
		logger.info("orderPageGet 진입");
		
		System.out.println("mId : "+mId);
		System.out.println("orders : "+ opd.getOrders());
		
		model.addAttribute("orderList", orderService.getPopsInfo(opd.getOrders()));
		model.addAttribute("memberInfo", memberSerivce.getMemberInfo(mId));
		
		
		System.out.println(orderService.getPopsInfo(opd.getOrders()));
		return "/order/order";
	}
	
}
