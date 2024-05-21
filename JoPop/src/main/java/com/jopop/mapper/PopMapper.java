package com.jopop.mapper;

import java.util.List;

import com.jopop.model.Criteria;
import com.jopop.model.PopVO;

public interface PopMapper {
    
	//상품 상세 정보 
	public PopVO PopGoodsInfo(int pid) throws Exception;
	
	/* 상품 검색 */
	public List<PopVO> getGoodsList(Criteria cri) throws Exception;
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri) throws Exception;
}
