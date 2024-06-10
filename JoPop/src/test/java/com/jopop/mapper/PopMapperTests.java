package com.jopop.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jopop.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PopMapperTests {

    @Autowired
    private PopMapper mapper;
    
    @Test
    public void getCateInfoTest1() {
        
        Criteria cri = new Criteria();
      
        String keyword = "라코스테 1933 팝업";
        String cateCode = "112";
        
        
       
        cri.setKeyword(keyword);
        cri.setCateCode(cateCode);
        
        mapper.getCateInfo(cri);
        
        System.out.println("lllllllllllllllllll");
        System.out.println(mapper.getCateInfo(cri));
       
    }
}