package com.jopop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pop")
public class PopController {
private static final Logger logger = LoggerFactory.getLogger(PopController.class);


	/*검색 페이지로 이동 */
	@GetMapping("/search")
	public void searchGET() {
		logger.info("검색 페이지로 이동");
	}
	

 
}
