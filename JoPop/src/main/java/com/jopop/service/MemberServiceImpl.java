package com.jopop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.jopop.mapper.MemberMapper;
import com.jopop.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

		@Autowired
		MemberMapper membermapper;
		
		//회원가입
		@Override
		public void memberJoin(MemberVO member) throws Exception{
			membermapper.memberJoin(member);
		}
		
	
		
}
