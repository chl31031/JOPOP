package com.jopop.service;

import java.util.List;
import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;

public interface PopService {

    // 상품 상세 정보
    PopVO PopGoodsInfo(int pid) throws Exception;

    // 상품 검색
    List<PopVO> getGoodsList(Criteria cri) throws Exception;

    // 상품 총 갯수
    int goodsGetTotal(Criteria cri) throws Exception;

    // 리뷰 추가
    void addReview(ReviewVO review) throws Exception;
    
    // 리뷰 조회
    List<ReviewVO> getReviewsByPid(int pid) throws Exception;
}
