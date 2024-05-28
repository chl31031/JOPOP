package com.jopop.mapper;

import java.util.List;

import com.jopop.model.ImageVO;

/* 이미지 변환 매퍼 */

public interface AttachMapper {
	/* 이미지 데이터 반환 */
	public List<ImageVO> getImageList(int pId);
	
}
