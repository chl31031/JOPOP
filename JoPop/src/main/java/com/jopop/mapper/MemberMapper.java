package com.jopop.mapper;

import com.jopop.model.MemberVO;

public interface MemberMapper {
	
	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
}
