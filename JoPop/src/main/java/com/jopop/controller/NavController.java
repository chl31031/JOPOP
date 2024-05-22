package com.jopop.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jopop.model.Criteria;
import com.jopop.model.PageDTO;
import com.jopop.model.PopVO;
import com.jopop.service.PopService;


@Controller
@RequestMapping(value = "/nav")
public class NavController {
	
	@Autowired
	private PopService popService;
	

	private static final Logger logger = LoggerFactory.getLogger(NavController.class);

	// 로그인 or 회원가입 선택 페이지 이동
	@GetMapping("/prelogin")
	public void preloginGET() {

		logger.info("로그인 or 회원가입 선택 페이지 진입");
	}
	
	/* 검색 페이지로 이동 */
	@GetMapping("/search")
	public void searchPageGET() {
		logger.info("검색페이지로 이동");
	}
	
	
	/* 상품 검색 */
	@GetMapping("/popsearch")
	public String searchGoodsGET(Criteria cri, Model model)throws Exception {
		
		logger.info("cri : " + cri);
		
		List<PopVO> list = popService.getGoodsList(cri);
		logger.info("pre list : " + list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			logger.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "/nav/search";
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, popService.goodsGetTotal(cri)));
		
		
		return "/nav/search";
		
	}
	
	

	
}
