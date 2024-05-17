package com.jopop.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jopop.mapper.PopMapper;
import com.jopop.model.PopVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PopMappertests {
	@Autowired
	private PopMapper popMapper;
      
	
	
	/* 상품 정보 */
	@Test
	public void  PopgoodsInfo() {
		int pid =2;
		PopVO PopsInfo =  popMapper.PopGoodsInfo(pid);
		System.out.println("====결과====");
		System.out.println( "전체 :" + PopsInfo);
		System.out.println("pid :" + PopsInfo.getpId() );

	}
	
	
}
