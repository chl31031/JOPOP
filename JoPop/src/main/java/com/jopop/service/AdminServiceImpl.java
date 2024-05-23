package com.jopop.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jopop.mapper.AdminMapper;
import com.jopop.model.CateVO;
import com.jopop.model.Criteria;
import com.jopop.model.ImageVO;
import com.jopop.model.PopVO;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService{

	private static final Logger log = LoggerFactory.getLogger(AdminServiceImpl.class);
	
	@Autowired AdminMapper adminMapper;
	
	
	//팝업 정보 등록
	@Transactional
	@Override
	public void popsEnroll(PopVO pop) {
		
		log.info("(srevice)popsEnroll........");
		
		adminMapper.popsEnroll(pop);
		
		if(pop.getImageList() == null || pop.getImageList().size() <= 0) {
			return;
		}
		
		pop.getImageList().forEach(image ->{
			
			image.setpId(pop.getpId());
			adminMapper.imageEnroll(image);
			
		});
				
	}
	
    //카테고리 리스트
	@Override
	public List<CateVO> cateList() {
		log.info("(service)cateList....");
		
		return adminMapper.cateList();
	}
	
	//팝업 리스트
	@Override
	public List<PopVO> popsGetList(Criteria cri) {
		log.info("popsGetTotalList().....");
		
		return adminMapper.popsGetList(cri);
		
	}
	
	// 등록된 팝업 총 갯수 
	@Override
	public int popsGetTotal(Criteria cri) {
	    log.info("popsGetTotal().....");
	    
	    return adminMapper.popsGetTotal(cri);
	}
	
	//팝업 상세정보 조회 페이지?	
	@Override
	public PopVO popsGetDetail(int pId) {
		log.info("(service)popsGetDetail...." + pId);
		
		return adminMapper.popsGetDetail(pId);
	}
	
	//팝업 정보 수정
	@Transactional
	@Override
	public int popsModify(PopVO vo) {
		
		int result = adminMapper.popsModify(vo);
		
		if(result == 1 && vo.getImageList() != null && vo.getImageList().size() > 0) {
			
		   adminMapper.deleteImageAll(vo.getpId());
		   
		   vo.getImageList().forEach(image -> {
			   
			   image.setpId(vo.getpId());
			   adminMapper.imageEnroll(image);
			   
		   });
		}
		return result;
	}
	
	/* 팝업 정보 삭제 & 지정 팝업 이미지 삭제*/
	@Override
	@Transactional
	public int popsDelete(int pId) {
		log.info("popsDelete....");
		
		adminMapper.deleteImageAll(pId);
		
		return adminMapper.popsDelete(pId);
	}
	
	//지정 팝업 이미지 얻기 ?? 
	@Override
	public List<ImageVO> getImageInfo(int pId) {
		log.info("getAttachInfo.....");
		
		return adminMapper.getImageInfo(pId);
	}
}
