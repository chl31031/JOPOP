package com.jopop.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;
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

	
	// ȸ������ ������ �̵�
	@GetMapping("/join")
	public void loginGET() {
		logger.info("ȸ������ ������ ����");
	}

	// ���������� �̵� - ���� ��ȸ
	@GetMapping("/mypage")
	public String mypageGET(HttpServletRequest request,Model model) throws Exception {
		logger.info("������������ �̵�");
		
		HttpSession session = request.getSession();
		
		//mId ���� ��������
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
	
	// ���������� - ���� ����
	@PostMapping("/delete")
	public String reviewDeletePOST(@RequestParam("pId") int pId, @RequestParam("mId") int mId) {
		logger.info("���� ����");
		
		System.out.println("pId : "+pId+" , mId: "+mId);
		
		PopVO pop = new PopVO();
		pop.setmId(mId);
		pop.setpId(pId);
		
		int result = popService.deleteReview(pId, mId);
		
		if(result == 1) {
			System.out.println("���� �����߽��ϴ�.");
		}else if(result == 0) {
			System.out.println("���� �����߽��ϴ�.");
		}
		
		return "member/mypage";
	}

	// ȸ�� ����
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; // ���ڵ� �� ��й�ȣ
		String encodePw = ""; // ���ڵ� �� ��й�ȣ

		rawPw = member.getmPw(); // ��й�ȣ ������ ����
		encodePw = pwEncoder.encode(rawPw); // ��й�ȣ ���ڵ�
		member.setmPw(encodePw); // ���ڵ��� ��й�ȣ member��ü�� �ٽ� ����

		/* ȸ������ ���� ���� */
		memberservice.memberJoin(member);

		return "redirect:/main";
	}

	// �α��� ������ �̵�
	@GetMapping("login")
	public void joinGET() {

		logger.info("�α��� ������ ����");
	}

	// ���̵� �ߺ��˻�
	@PostMapping("/memberIdChk")
	@ResponseBody
	public String memberIdChkPOST(String mEmail) throws Exception {

		logger.info("memberIdChk() ����");

		int result = memberservice.idCheck(mEmail);

		logger.info("����� = " + result);

		if (result != 0) {

			return "fail"; // �ߺ� ���̵� ����

		} else {

			return "success"; // �ߺ� ���̵� x

		}
	}// memberIdChkPOST() ����

	/* �̸��� ���� */
	@GetMapping("/emailCheck")
	@ResponseBody
	public String emailCheckGET(String mEmail) throws Exception {

		/* ��(View)�κ��� �Ѿ�� ������ Ȯ�� */
		logger.info("�̸��� ������ ���� Ȯ��");
		logger.info("������ȣ : " + mEmail);

		/* ������ȣ(����) ���� */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("������ȣ " + checkNum);

		/* �̸��� ������ */
		String setFrom = "code_07@naver.com";
		String toMail = mEmail;
		String title = "ȸ������ ���� �̸��� �Դϴ�.";
		String content = "Ȩ�������� �湮���ּż� �����մϴ�." + "<br><br>" + "���� ��ȣ�� " + checkNum + "�Դϴ�." + "<br>"
				+ "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���.";

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

	/* �α��� */
	@PostMapping("login")
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO lvo = memberservice.memberLogin(member); // �����Ѿ��̵�� ��ġ�ϴ� ���̵� �ִ���

		if (lvo != null) { // ��ġ�ϴ� ���̵� �����

			rawPw = member.getmPw(); // ����ڰ� ������ ��й�ȣ
			encodePw = lvo.getmPw(); // �����ͺ��̽��� ������ ���ڵ��� ��й�ȣ

			if (true == pwEncoder.matches(rawPw, encodePw)) { // ��й�ȣ ��ġ���� �Ǵ�

				lvo.setmPw(""); // ���ڵ��� ��й�ȣ ���� ����
				session.setAttribute("member", lvo); // session�� ������� ���� ����
				return "redirect:/main"; // ���������� �̵�

			} else {

				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login"; // �α��� �������� �̵�

			}

		} else { // ��ġ�ϴ� ���̵� �������� ���� �� (�α��� ����)

			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login"; // �α��� �������� �̵�

		}

	}
}
