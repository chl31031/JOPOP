package com.jopop.service;

import com.jopop.model.MemberVO;

public interface MemberService {
	
		/* 회원가입 */
		public void memberJoin(MemberVO member) throws Exception;
		
		/* 아이디 중복 검사 */
		public int idCheck(String mEmail) throws Exception;
		
		/* 로그인 */
		public MemberVO memberLogin(MemberVO member) throws Exception;	

		/* 유저 삭제 */
		public int memberDrop(int mId);
		
		//주문자 정보
		public MemberVO getMemberInfo(int mId);
}
