package com.jopop.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jopop.model.CartVO;
import com.jopop.model.Criteria;
import com.jopop.model.MemberVO;
import com.jopop.model.PageDTO;
import com.jopop.model.PopVO;
import com.jopop.service.CartService;
import com.jopop.service.PopService;

@Controller
@RequestMapping(value = "/nav")
public class NavController {

	@Autowired
	private PopService popService;
	
	@Autowired
	private CartService cartService;

	private static final Logger logger = LoggerFactory.getLogger(NavController.class);

	// 로그인 or 회원가입 선택 페이지 이동
	@GetMapping("/prelogin")
	public void preloginGET() {

		logger.info("로그인 or 회원가입 선택 페이지 진입");
		
	}

	/* 검색 페이지로 이동 */
	@GetMapping("/search")
	public String searchPageGET(Criteria cri, Model model, HttpSession session)throws Exception{
	    
	    logger.info("검색페이지로 이동");
	   
	    
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    System.out.println("dddd : " + member);
	    
	    List<PopVO> list = popService.getGoodsList(cri);
	    
	    if (!list.isEmpty()) {
	        model.addAttribute("list", list);
	    } else {
	        model.addAttribute("listcheck", "empty");
	        return "/nav/search";
	    }
	    
	    model.addAttribute("pageMaker", new PageDTO(cri, popService.goodsGetTotal(cri)));

	    return "/nav/search";
	}

	/* 검색 페이지에서 찜 등록하기 */
	@PostMapping("like.do")
	public String addCart(@RequestParam("pId") String pId, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    if (member == null) {
	        return "redirect:/nav/prelogin"; // 로그인 페이지로 리다이렉트
	    }
	    
	    CartVO cart = new CartVO();
	    cart.setmId(member.getmId());
	    cart.setpId(Integer.parseInt(pId));
	    
	    try {
	        cartService.addCart(cart);
	        logger.info("상품 {}이(가) 찜되었습니다.", pId);
	    } catch (Exception e) {
	        logger.error("찜하기 중 오류 발생: {}", e.getMessage());
	        // 오류 처리
	    }
	    
	    return "redirect:/nav/search"; // 검색 페이지로 리다이렉트
	}

	/* 검색 페이지에서 찜 삭제하기 */
	@PostMapping("unlike.do")
	public String deleteCart(@RequestParam("pId") int pId, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    if (member == null) {
	        return "redirect:/nav/prelogin"; // 로그인 페이지로 리다이렉트
	    }
	    
	    try {
	        cartService.deleteCart(pId);
	        logger.info("상품 {}이(가) 찜 목록에서 삭제되었습니다.", pId);
	    } catch (Exception e) {
	        logger.error("찜 삭제 중 오류 발생: {}", e.getMessage());
	        // 오류 처리
	    }
	    
	    return "redirect:/nav/search"; // 검색 페이지로 리다이렉트
	}
}