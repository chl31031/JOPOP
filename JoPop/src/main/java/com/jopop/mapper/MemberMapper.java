package com.jopop.mapper;

import com.jopop.model.MemberVO;

public interface MemberMapper {
	
	/* 회원가입 */
	public void memberJoin(MemberVO member) throws Exception;
	
	/* 아이디 중복 검사 */
	public int idCheck(String mEmail) throws Exception;
	
	/* 로그인 */
	public MemberVO memberLogin(MemberVO member) throws Exception;
}
