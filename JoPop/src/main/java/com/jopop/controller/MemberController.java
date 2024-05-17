package com.jopop.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jopop.model.MemberVO;
import com.jopop.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private JavaMailSender mailSender;
	
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
	
	//아이디 중복검사
	@PostMapping("/memberIdChk")
	@ResponseBody
	public String memberIdChkPOST(String mEmail) throws Exception{
		
		logger.info("memberIdChk() 진입");
		
		int result = memberservice.idCheck(mEmail);
		
		logger.info("결과값 = " + result);
		
		if(result != 0) {
			
			return "fail";	// 중복 아이디가 존재
			
		} else {
			
			return "success";	// 중복 아이디 x
			
		}
	}// memberIdChkPOST() 종료
	
	/* 이메일 인증 */
	@GetMapping("/emailCheck")
	@ResponseBody
	public String emailCheckGET(String mEmail) throws Exception{
		
		/* 뷰(View)로부터 넘어온 데이터 확인 */
        logger.info("이메일 데이터 전송 확인");
        logger.info("인증번호 : " + mEmail);
        
        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        logger.info("인증번호 " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "code_07@naver.com";
        String toMail = mEmail;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
		String num = Integer.toString(checkNum);
		
		return num;
	}
	
}
