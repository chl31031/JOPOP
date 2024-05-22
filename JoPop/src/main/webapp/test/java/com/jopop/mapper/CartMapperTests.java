package com.jopop.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jopop.model.CartVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTests {
	
	@Autowired
	private CartMapper mapper;
	
	/*
	//찜 추가
	@Test
	public void addCart() {
		int mId = 2;
		int pId = 2;
		
		CartVO cart = new CartVO();
		cart.setmId(mId);
		cart.setpId(pId);
		
		int result = 0;
		result = mapper.addCart(cart);
		
		System.out.println("결과 : " + result);
		
	}	
	
	//찜 삭제 
	@Test
	public void deleteCartTest() {
		int cartId=5;
		
		mapper.deleteCart(cartId);
	}
	
	//찜 목록
	@Test
	public void getCartTest() {
		int mId = 2;
		
		List<CartVO> list = mapper.getCart(mId);
		for(CartVO cart : list) {
			System.out.println(cart);
			System.out.println("init cart : "+ cart);
		}
	}
	
	//찜 확인
	@Test
	public void checkCartTest() {
		int mId = 2;
		int pId = 2;
		
		CartVO cart = new CartVO();
		cart.setmId(mId);
		cart.setpId(pId);
		
		CartVO resultCart = mapper.checkCart(cart);
		System.out.println("결과 : "+resultCart);
	}
	*/
	
	//찜 검색 테스트
	@Test
	public void getCartTest() {
		int mId = 22;
		String pName = '아무거나';
		String pAddr2 = '영등포구';
		
		List<CartVO> list = mapper.searchCart(mId, pName, pAddr2);
		for(CartVO cart : list) {
			System.out.println(cart);
			System.out.println("init cart : "+ cart);
		}
	}
	
}
