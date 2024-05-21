package com.jopop.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jopop.model.Criteria;
import com.jopop.model.PopVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PopMappertests {
	
	@Autowired
	private PopMapper mapper;
      
	
	
	@Test
	public void getGoodsListTest() throws Exception {
		
		Criteria cri = new Criteria();
		// 테스트 키워드
		//cri.setKeyword("test");
		System.out.println("cri : " + cri);
		
		List<PopVO> list = mapper.getGoodsList(cri);
		System.out.println("list : " + list);
		
		System.out.println("==========");
		int goodsTotal = mapper.goodsGetTotal(cri);
		System.out.println("totla : " + goodsTotal);
		
	}
	
	
}
