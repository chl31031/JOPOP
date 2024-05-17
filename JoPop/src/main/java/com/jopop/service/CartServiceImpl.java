package com.jopop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jopop.mapper.CartMapper;
import com.jopop.model.CartVO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	CartMapper cartmapper;
	
	//찜 추가
	@Override
	public int addCart(CartVO cart) {
		// TODO Auto-generated method stub
		return 0;
	}

	//찜 삭제
	@Override
	public int deleteCart(int cartId) {
		// TODO Auto-generated method stub
		return 0;
	}

	//찜 목록
	@Override
	public List<CartVO> getCart(int mId) {
		// TODO Auto-generated method stub
		return null;
	}

	//찜 확인
	@Override
	public CartVO checkCart(CartVO cart) {
		// TODO Auto-generated method stub
		return null;
	}

}
