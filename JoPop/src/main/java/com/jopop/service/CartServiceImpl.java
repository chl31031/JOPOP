package com.jopop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jopop.mapper.CartMapper;
import com.jopop.model.CartVO;
import com.jopop.model.ImageVO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	CartMapper cartMapper;
	
	
	
	//찜 추가
	@Override
	public int addCart(CartVO cart) throws Exception {
		//0:등록 실패, 1: 등록 성공, 2: 등록된 데이터 존재, 5: 로그인 필요
		
		//찜 데이터 체크
		CartVO checkCart = cartMapper.checkCart(cart);
		System.out.println(checkCart);
		
		if(checkCart != null) {
			return 2;
		}
		
		//찜 등록 & 에러 시 0 반환
		try {
			return cartMapper.addCart(cart);
		}catch(Exception e) {
			return 0;
		}
	}

	//찜 삭제
	@Override
	public int deleteCart(int cartId) {
		return cartMapper.deleteCart(cartId);
	}

	//찜 목록
	@Override
	public List<CartVO> getCart(int mId) {
		
		List<CartVO> cart = cartMapper.getCart(mId);
		
		return cart;
	}

	//찜 확인
	@Override
	public CartVO checkCart(CartVO cart) {
		// TODO Auto-generated method stub
		return null;
	}

}
