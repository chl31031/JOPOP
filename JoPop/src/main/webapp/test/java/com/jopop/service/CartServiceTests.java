package com.jopop.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jopop.model.CartVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartServiceTests {
	
	@Autowired
	private CartService service;
	
	//등록 테스트
	@Test
	public void addCartTest() throws Exception {
		//0:등록 실패, 1: 등록 성공, 2: 등록된 데이터 존재 로 result값이 뜨게 된다.
		//given
			int mId = 4;
			int pId = 6;
			
			CartVO vo = new CartVO(); 
			vo.setmId(mId);
			vo.setpId(pId);
		
		//when
			int result = service.addCart(vo);
		
		//then
			System.out.println("** result : " + result);
	}
}
