package com.jopop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jopop.mapper.PopMapper;
import com.jopop.model.PopVO;

@Service
public class PopServiceimpl implements PopService{
    
	@Autowired
	PopMapper popMapper;
    
	//상품 상세 정보
	@Override
	public PopVO PopGoodsInfo(int pid) {
		
		PopVO popsinfo = popMapper.PopGoodsInfo(pid);
		
		
		return popsinfo;
		
	}
	
	
	
}
