package com.jopop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.jopop.model.MemberVO;

public class CartInterceptor implements HandlerInterceptor{
	
	/*
	//로그인 여부에 따라 페이지 이동하게 함
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo == null) {   //로그인 되어있지 않다면 "/prelogin"으로
			response.sendRedirect("/member/prelogin");   
			return false;
		}else {             //로그인 되어있다면 true
			return true;
		}
	}
	*/
}
