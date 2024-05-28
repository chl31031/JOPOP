package com.jopop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;

public interface PopMapper {
    // 상품 상세 정보
    public PopVO PopGoodsInfo(int pid) throws Exception;

    // 상품 검색
    public List<PopVO> getGoodsList(Criteria cri) throws Exception;

    // 상품 총 갯수
    public int goodsGetTotal(Criteria cri) throws Exception;

    // 리뷰 추가
    public void addReview(ReviewVO review) throws Exception;
    
    // 이미지 추가 메서드
    void addImage(RimageVO image) throws Exception;

    // 리뷰 조회
    public List<ReviewVO> getReviewsByPid(int pid) throws Exception;
    
    // 특정 리뷰에 해당하는 이미지 리스트를 가져오는 메서드 추가
    List<RimageVO> getImagesByReviewId(@Param("mId") int mId, @Param("pId") int pId) throws Exception;


    
    
}
