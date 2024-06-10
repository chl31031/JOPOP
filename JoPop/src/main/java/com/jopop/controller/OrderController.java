package com.jopop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jopop.model.Criteria;
import com.jopop.model.MemberVO;
import com.jopop.model.OrderDTO;
import com.jopop.model.OrderItemDTO;
import com.jopop.model.OrderPageDTO;
import com.jopop.model.OrderPageItemDTO;
import com.jopop.model.PageDTO;
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
		
		model.addAttribute("orderList", orderService.getPopsInfo(opd.getOrders()));
		model.addAttribute("memberInfo", memberSerivce.getMemberInfo(mId));
		
		return "/order/order";
	}
	
	@PostMapping("/order")
	public String orderPagePost(OrderDTO od, HttpServletRequest request) {
		logger.info("orderPagePOST 진입");
		
		orderService.order(od);
		
		System.out.println("oderService.order 실행");
		
		MemberVO member = new MemberVO();
		member.setmId(od.getmId());
		
		HttpSession session = request.getSession();
		
		try {
			MemberVO memberLogin = memberSerivce.memberLogin(member);
			memberLogin.setmPw("");
			session.setAttribute("member", memberLogin);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/main";
	}
	
	//예약 조회 페이지
	@GetMapping("/order/orderItem")
	public String orderListGet(Criteria cri, Model model, HttpServletRequest request) {
		logger.info("주문 페이지로 이동");
		
		HttpSession session = request.getSession();

		MemberVO member = (MemberVO) session.getAttribute("member");
		int mId = member.getmId();
		String mIdString = String.valueOf(mId);            //mId값 형변환
		
		cri.setKeyword(mIdString);
		
		List<OrderItemDTO> list = orderService.getOrderList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			System.out.println(list);
			model.addAttribute("pageMaker", new PageDTO(cri, orderService.getOrderTotal(cri)));
		} else {
			model.addAttribute("listCheck", "empty");
		}
		
		return "/order/orderItem";
	}
	
}
