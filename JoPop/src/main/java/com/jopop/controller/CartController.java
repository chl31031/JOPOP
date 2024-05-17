package com.jopop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jopop.model.CartVO;
import com.jopop.model.MemberVO;
import com.jopop.service.CartService;

@Controller
@RequestMapping(value = "/cart")
public class CartController {
private static final Logger logger = LoggerFactory.getLogger(CartController.class);

		@Autowired
		CartService cartService;
		
		//찜 페이지 이동
		@GetMapping(value = "/cart")
		public void cartGET(){
			logger.info("찜 페이지로 이동");
		}
		
		//상세페이지에서 찜 누르기 기능
		@PostMapping(value="/add")
		public String addCartPOST(CartVO cart, HttpServletRequest request) throws Exception {
			//0:등록 실패, 1: 등록 성공, 2: 등록된 데이터 존재 로 result값 반환
			//로그인 체크
			HttpSession session = request.getSession();
			MemberVO mvo = (MemberVO)session.getAttribute("member");
			
			if(mvo == null) {
				return "5";
			}
			
			//찜 등록
			int result = cartService.addCart(cart);
			return result + "";
		}
		
}
