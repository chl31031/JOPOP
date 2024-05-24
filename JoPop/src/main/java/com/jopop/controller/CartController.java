package com.jopop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jopop.model.CartVO;
import com.jopop.model.MemberVO;
import com.jopop.service.CartService;


@Controller
@RequestMapping(value = "/cart")
public class CartController {
private static final Logger logger = LoggerFactory.getLogger(CartController.class);

		@Autowired
		CartService cartService;
		
		//찜 페이지 이동
		@GetMapping(value = "/cart")
		public void cartGET(){
			logger.info("찜 페이지로 이동");
		}
		
		//mId를 얻기 위한 동작
		@GetMapping("/cart/{mId}")
		public String cartPageGET(@PathVariable("mId") int mId, Model model) {
			logger.info("cartPageGet 동작");
			
			model.addAttribute("cartInfo", cartService.getCart(mId));
			
			return "/cart/cart";
		}
		
		/*
		//상세페이지에서 찜 누르기 기능
		@PostMapping(value="/add")
		public String addCartPOST(CartVO cart, HttpServletRequest request) throws Exception {
			//0:등록 실패, 1: 등록 성공, 2: 등록된 데이터 존재 로 result값 반환
			//로그인 체크
			logger.info("addCartPOST 동작");
			
			HttpSession session = request.getSession();
			
			//mId 세션 가져오기
			MemberVO mvo = (MemberVO)session.getAttribute("member");
			System.out.println(mvo);
			
			if(mvo == null) {
				return "5";
			}
			
			//찜 등록
			int result = cartService.addCart(cart);
			return result + "";
		}
		*/
		
		
		//주문 페이지
		@GetMapping(value = "/orderItem")
		public void orderGET(){
			logger.info("주문 페이지로 이동");
		}
		
		//찜 검색 기능
		@GetMapping(value="/search")
		public String searchCartGET(CartVO cart, String keyword, HttpServletRequest request, Model model) {
			logger.info("searchCartGET 동작");
			
			HttpSession session = request.getSession();
			
			//mId 세션 가져오기
			MemberVO mvo = (MemberVO)session.getAttribute("member");
			
			// MemberVO가 null이 아니라면 keyword 설정
			if(mvo != null) {
				mvo.setKeyword(keyword);        	//keyword는 MemberVO에 넣음
			}
			
			System.out.println(keyword + "=======================");
			System.out.println(mvo);
			
			//검색 기능 
			model.addAttribute("cartInfo", cartService.searchCart(mvo));
			
			return "/cart/cart";
		}
		
		//찜 기능 구현
		@PostMapping(value="/modify/{mId}")
		public String modifyCartPOST(@RequestParam("pId") int pId, @PathVariable("mId") int mId, HttpServletRequest request) throws Exception {
			logger.info("modifyCartPOST 동작 "+pId +"=================");
			
			CartVO cart = new CartVO();
		    cart.setmId(mId);
		    cart.setpId(pId);
		    
		    //0:등록 실패, 1: 등록 성공, 2: 등록된 데이터 존재 로 result값 반환
		    System.out.println("카트 vo : "+cart+"================");
			
			//찜 등록
			int result = cartService.addCart(cart);
			System.out.println("=================="+result+"========================");
			
			if(result == 2) {  //찜 삭제 (찜 목록에 없는 것)
				int dresult = cartService.deleteCart(pId);      //찜 삭제 결과
				
				if(dresult == 1) {
					System.out.println("삭제 성공했습니다.");
				}else if(dresult == 0) {
					System.out.println("삭제 실패했습니다.");
				}
				
				//return "redirect:/cart/cart/"+mId;
				return null;
				
			}else{  //찜 추가 
				
				return "redirect:/cart/cart/"+mId;
				
			}
		}
		
}
