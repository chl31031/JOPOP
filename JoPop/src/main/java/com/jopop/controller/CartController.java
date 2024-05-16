package com.jopop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/cart")
public class CartController {
private static final Logger logger = LoggerFactory.getLogger(CartController.class);
		
		//찜 페이지 이동
		@GetMapping(value="/cart")
		public void cartGET(){
			logger.info("찜 페이지로 이동");
		}
		
		
}
