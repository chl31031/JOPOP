package com.jopop.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jopop.model.CartVO;
import com.jopop.model.Criteria;
import com.jopop.model.MemberVO;
import com.jopop.model.PopVO;
import com.jopop.service.CartService;
import com.jopop.service.PopService;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private PopService popservice;
	
	@Autowired
    private CartService cartService;
	
	// 메인 페이지 이동
	// 메인 페이지 이동
	@GetMapping("/main")
	public String mainPageGET(HttpSession session, Model model, Criteria cri) {
	    try {
	        // 기존의 상품 목록 가져오기
	        List<PopVO> list = popservice.getGoodsList(cri);

	        // 가져온 목록이 비어있지 않다면 모델에 추가
	        if (list != null && !list.isEmpty()) {
	            model.addAttribute("list", list);
	            model.addAttribute("rating" , popservice.rating());
	            
	            System.out.println("rating" + popservice.rating());
	            
	        } else {
	            // 가져온 목록이 비어있다면 모델에 "empty" 속성 추가
	            model.addAttribute("goodsListEmpty", true);
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        e.printStackTrace();
	        // 에러 메시지를 모델에 추가하여 뷰에서 확인할 수 있도록 함
	        model.addAttribute("errorMessage", "상품 목록을 가져오는 도중 오류가 발생했습니다.");
	    }
	    return "main"; // 메인 페이지로 이동
	}



	
	/* 이미지 출력 */
    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        
        logger.info("getImage()......." + fileName);
        
        File file = new File("c:\\upload\\" + fileName);
        
        ResponseEntity<byte[]> result = null;
        
        try {
            HttpHeaders header = new HttpHeaders();
            
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /* 메인 페이지에서 찜 등록하기 */
    @PostMapping("/main/like")
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

        return "redirect:/main"; // 메인 페이지로 리다이렉트
    }

    /* 메인 페이지에서 찜 삭제하기 */
    @PostMapping("/main/unlike")
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

        return "redirect:/main"; // 메인 페이지로 리다이렉트
    }
	


}
