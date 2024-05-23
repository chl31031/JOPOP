package com.jopop.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jopop.mapper.PopMapper;
import com.jopop.model.Criteria;
import com.jopop.model.PopVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PopServiceimpl implements PopService{
    
	private static final Logger log = LoggerFactory.getLogger(PopServiceimpl.class);
	
	@Autowired
	PopMapper popMapper;
    
	//상품 상세 정보
	@Override
	public PopVO PopGoodsInfo(int pid) throws Exception {
		
		PopVO popsinfo = popMapper.PopGoodsInfo(pid);
		
		
		return popsinfo;
		
	}
	
	/* 상품 검색 */
	@Override
	public List<PopVO> getGoodsList(Criteria cri) throws Exception {
		
		log.info("getGoodsList().......");
		
		return popMapper.getGoodsList(cri);
	}

	/* 상품 총 갯수 */
	@Override
	public int goodsGetTotal(Criteria cri) throws Exception {
		
		log.info("goodsGetTotal().......");
		
		return popMapper.goodsGetTotal(cri);
		
	}
	
	
	
}
