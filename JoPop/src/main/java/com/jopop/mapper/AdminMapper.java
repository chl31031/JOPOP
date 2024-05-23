package com.jopop.mapper;

import java.util.List;

import com.jopop.model.CateVO;
import com.jopop.model.Criteria;
import com.jopop.model.ImageVO;
import com.jopop.model.PopVO;

public interface AdminMapper {
	
		//팝업 정보 등록 
		public void popsEnroll(PopVO pop);
		
		//카테고리 리스트
		public List<CateVO> cateList();
		
		//팝업 정보 리스트 
		public List<PopVO> popsGetList(Criteria cri);
		
		//등록된 팝업 총 개수 
		public int popsGetTotal(Criteria cri);
		
		//팝업 상세정보 조회 페이지?
		public PopVO popsGetDetail(int pId);
		
		//팝업 정보 수정 
		public int popsModify(PopVO vo);
				
		//팝업 정보 삭제 
		public int popsDelete(int pId);
		
		//팝업 이미지 등록 
		public void imageEnroll(ImageVO vo);
		
		//지정 팝업 이미지 삭제
		public void deleteImageAll(int pId);
		
		//어제자 날짜 이미지 리스트 
		//public List<ImageVO> checkFileList();
		
		//지정 팝업 이미지 정보 얻기 ???
		public List<ImageVO> getImageInfo(int pId);
}
