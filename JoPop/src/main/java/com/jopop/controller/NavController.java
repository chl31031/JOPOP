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
	public void searchPageGET(){
		logger.info("검색페이지로 이동");
	}

	

	/* 상품 검색 */
	@GetMapping("/popsearch")
	public String searchGoodsGET(Criteria cri, Model model) throws Exception {

		logger.info("cri : " + cri);

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
	
	@PostMapping("/like.do")
	public String addCart(@RequestParam("pId") String pId, HttpSession session) {
	    // 세션에서 사용자 정보를 가져옵니다.
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    if (member == null) {
	        // 사용자가 로그인하지 않은 경우 로그인 페이지로 리다이렉트합니다.
	        return "redirect:/nav/prelogin";
	    }
	    
	    // CartVO 객체를 생성하고 사용자 ID와 상품 ID를 설정합니다.
	    CartVO cart = new CartVO();
	    cart.setmId(member.getmId());
	    cart.setpId(Integer.parseInt(pId));
	    
	    
	    // CartService를 통해 찜 정보를 추가합니다.
	    try {
	        cartService.addCart(cart);
	        logger.info("상품 {}이(가) 찜되었습니다.", pId);
	    } catch (Exception e) {
	        logger.error("찜하기 중 오류 발생: {}", e.getMessage());
	        // 오류 발생 시 처리할 내용을 추가할 수 있습니다.
	    }
	    
	    // 찜하기 후에는 검색 페이지로 리다이렉트합니다.
	    return "redirect:/nav/popsearch";
	}
}
