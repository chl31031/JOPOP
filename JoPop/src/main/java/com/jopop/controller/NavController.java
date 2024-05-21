package com.jopop.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/nav")
public class NavController {

	private static final Logger logger = LoggerFactory.getLogger(NavController.class);

	// 로그인 or 회원가입 선택 페이지 이동
	@GetMapping("/prelogin")
	public void preloginGET() {

		logger.info("로그인 or 회원가입 선택 페이지 진입");
	}
}
