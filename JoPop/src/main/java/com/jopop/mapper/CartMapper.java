package com.jopop.mapper;

import java.util.List;

import com.jopop.model.CartVO;
import com.jopop.model.MemberVO;

public interface CartMapper {

	//찜 추가
	public int addCart(CartVO cart) throws Exception;
	
	//찜 삭제
	public int deleteCart(int pId);
	
	//찜 목록
	public List<CartVO> getCart(int mId);
	
	//찜 확인
	public CartVO checkCart(CartVO cart);
	
	//찜 검색
	public List<CartVO> searchCart(MemberVO cart);
	
	//찜 목록에서 제거(주문)
	public int deleteOrderCart(CartVO dto);
	
}
