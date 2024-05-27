package com.jopop.service;

import java.util.List;
import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;

public interface PopService {

    // 상품 상세 정보
    PopVO PopGoodsInfo(int pid) throws Exception;

    // 상품 검색 및 조회
    List<PopVO> getGoodsList(Criteria cri) throws Exception;

    // 상품 총 갯수
    int goodsGetTotal(Criteria cri) throws Exception;

    // 리뷰 및 이미지 추가
    void addReviewAndImages(ReviewVO review, List<RimageVO> images) throws Exception;
    
    // 리뷰 조회
    List<ReviewVO> getReviewsByPid(int pid) throws Exception;
    
    // 특정 리뷰에 해당하는 이미지 리스트를 가져오는 메서드 추가
    List<RimageVO> getImagesByReviewId(int mId, int pId) throws Exception;
}
