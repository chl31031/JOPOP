package com.jopop.service;

import java.util.List;

import com.jopop.model.CateFilterVO;
import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.RatingDTO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;

public interface PopService {

    // 상품 상세 정보
    PopVO PopGoodsInfo(int pid) throws Exception;

    // 상품 검색 및 조회
    List<PopVO> getGoodsList(Criteria cri) throws Exception;

    // 상품 총 갯수
    int goodsGetTotal(Criteria cri) throws Exception;
    
    /* 인기 있는 순 리스트 */
    public List<RatingDTO> rating() throws Exception;
    
    /* 검색 결과 카테고리 필터 정보 */
    public List<CateFilterVO> getCateInfoList(Criteria cri);


    // 리뷰 및 이미지 추가
    void addReviewAndImages(ReviewVO review, List<RimageVO> images) throws Exception;
    
    // 리뷰 조회
    List<ReviewVO> getReviewsByPid(int pid) throws Exception;
    
    // 특정 리뷰에 해당하는 이미지 리스트를 가져오는 메서드 추가
    List<RimageVO> getImagesByReviewId(int mId, int pId) throws Exception;
    
    // [마이페이지 - 리뷰] 회원정보에 맞는 상품명 출력
    public List<ReviewVO> getMyPageReivew(int mId) throws Exception;
    
    // 리뷰 내용
    public int deleteReview(int pId, int mId);
    
    // 리뷰 이미지 삭제
    public int deleteRImage(int pId, int mId);

}
