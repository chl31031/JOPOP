package com.jopop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jopop.model.MemberVO;
import com.jopop.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberservice;
	
	//회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {
		logger.info("회원가입 페이지 진입");
	}
	
	//회원 가입
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception{
		
		logger.info("join 진입");
		
		//회원 가입 서비스 실행
		memberservice.memberJoin(member);
		
		logger.info("회원가입 성공");
		
		return "redirect:/main";
	}
	
	//로그인 페이지 이동
	@GetMapping("login")
	public void joinGET() {
		
		logger.info("로그인 페이지 진입");
	}
	
}
