package com.jopop.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.jopop.model.MemberVO;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	// 메인 페이지 이동
	@GetMapping("/main")
	public void mainPageGET(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		if (member == null) {
			// 사용자가 로그인하지 않은 경우 로그인 페이지로 리다이렉트합니다.
			
		}
		logger.info("메인 페이지 진입");
	}

}
