package com.jopop.service;

import java.util.List;

import com.jopop.model.CartVO;

public interface CartService {
	
	//찜 추가
	public int addCart(CartVO cart) throws Exception;
	
	//찜 삭제
	public int deleteCart(int cartId);
	
	//찜 목록
	public List<CartVO> getCart(int mId);
	
	//찜 확인
	public CartVO checkCart(CartVO cart);
	
	//찜 검색
	public List<CartVO> searchCart(CartVO cart);

	
		
	}


