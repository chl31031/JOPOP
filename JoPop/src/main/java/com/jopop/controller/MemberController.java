package com.jopop.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jopop.model.MemberVO;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;
import com.jopop.service.MemberService;
import com.jopop.service.PopService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	private PopService popService;

	
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {
		logger.info("회원가입 페이지 진입");
	}

	// 마이페이지 이동 - 리뷰 조회
	@GetMapping("/mypage")
	public String mypageGET(HttpServletRequest request,Model model) throws Exception {
		logger.info("마이페이지로 이동");
		
		HttpSession session = request.getSession();
		
		//mId 세션 가져오기
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		int mId = mvo.getmId();
		
		List<ReviewVO> reviews = popService.getMyPageReivew(mId);
		
        for (ReviewVO review : reviews) {
        	
            List<RimageVO> images = popService.getImagesByReviewId(review.getmId(), review.getpId());
            review.setImageList(images);
            model.addAttribute(popService.getImagesByReviewId(review.getmId(), review.getpId()));
        }
		
        model.addAttribute("reviews", reviews);

        return "/member/mypage";
	}
	
	// 마이페이지 - 리뷰 삭제
	@PostMapping("/delete")
	public String reviewDeletePOST(@RequestParam("pId") int pId, @RequestParam("mId") int mId) {
		logger.info("리뷰 삭제");
		
		System.out.println("pId : "+pId+" , mId: "+mId);
		
		PopVO pop = new PopVO();
		pop.setmId(mId);
		pop.setpId(pId);
		
		System.out.println(pop);
		
		popService.deleteReview(pop);
		popService.deleteRImage(pop);
		
		return "/member/mypage";
	}
	
	//마이페이지 - 리뷰 수정
    @PostMapping("/modifyReview")
    @ResponseBody
    public Map<String, String> addReview(@RequestParam("pId") int pId, @RequestParam("contents") String contents, @RequestParam("score") int score, @RequestParam(value = "imageList", required = false) String imageListJson, HttpSession session, Model model) throws Exception {
        Map<String, String> result = new HashMap<>();
        MemberVO member = (MemberVO) session.getAttribute("member");

        if (member == null) {
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        int mId = member.getmId();

        ReviewVO review = new ReviewVO();
        review.setpId(pId);
        review.setmId(mId);
        review.setContents(contents);
        review.setScore(score);

        List<RimageVO> imageList = null;
        if (imageListJson != null && !imageListJson.isEmpty()) {
            imageList = new ObjectMapper().readValue(imageListJson, new TypeReference<List<RimageVO>>() {});
        }

        popService.modifyReviewAndImages(review, imageList);

        result.put("message", "후기 등록이 완료되었습니다!");
        return result;
    }

	// 회원 가입
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = member.getmPw(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		member.setmPw(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장

		/* 회원가입 쿼리 실행 */
		memberservice.memberJoin(member);

		return "redirect:/main";
	}

	// 로그인 페이지 이동
	@GetMapping("login")
	public void joinGET() {

		logger.info("로그인 페이지 진입");
	}

	// 아이디 중복검사
	@PostMapping("/memberIdChk")
	@ResponseBody
	public String memberIdChkPOST(String mEmail) throws Exception {

		logger.info("memberIdChk() 진입");

		int result = memberservice.idCheck(mEmail);

		logger.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {

			return "success"; // 중복 아이디 x

		}
	}// memberIdChkPOST() 종료

	/* 이메일 인증 */
	@GetMapping("/emailCheck")
	@ResponseBody
	public String emailCheckGET(String mEmail) throws Exception {

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
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

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

	/* 로그인 */
	@PostMapping("login")
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO lvo = memberservice.memberLogin(member); // 제출한아이디와 일치하는 아이디 있는지

		if (lvo != null) { // 일치하는 아이디 존재시

			rawPw = member.getmPw(); // 사용자가 제출한 비밀번호
			encodePw = lvo.getmPw(); // 데이터베이스에 저장한 인코딩된 비밀번호

			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단

				lvo.setmPw(""); // 인코딩된 비밀번호 정보 지움
				session.setAttribute("member", lvo); // session에 사용자의 정보 저장
				return "redirect:/main"; // 메인페이지 이동

			} else {

				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login"; // 로그인 페이지로 이동

			}

		} else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)

			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login"; // 로그인 페이지로 이동

		}

	}
	   // 로그아웃 메서드 추가
		@GetMapping("/logout")
		public String logout(HttpServletRequest request) {
			HttpSession session = request.getSession();
			session.invalidate(); // 세션 무효화
			return "redirect:/nav/prelogin"; // 로그아웃 후 메인 페이지로 리디렉션
		}
}
