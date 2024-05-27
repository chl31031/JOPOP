package com.jopop.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jopop.mapper.PopMapper;
import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;

@Service
public class PopServiceimpl implements PopService {
    @Autowired
    private PopMapper popMapper;

    // 상품 상세 정보
    @Override
    public PopVO PopGoodsInfo(int pid) throws Exception {
        return popMapper.PopGoodsInfo(pid);
    }

    // 상품 검색
    @Override
    public List<PopVO> getGoodsList(Criteria cri) throws Exception {
        return popMapper.getGoodsList(cri);
    }

    // 상품 총 갯수
    @Override
    public int goodsGetTotal(Criteria cri) throws Exception {
        return popMapper.goodsGetTotal(cri);
    }

    // 리뷰 및 이미지 추가
    @Override
    @Transactional
    public void addReviewAndImages(ReviewVO review, List<RimageVO> images) throws Exception {
        popMapper.addReview(review);
        if (images != null && !images.isEmpty()) {
            for (RimageVO image : images) {
                image.setpId(review.getpId());
                image.setmId(review.getmId());
                popMapper.addImage(image);
            }
        }
    }


    // 리뷰 조회
    @Override
    public List<ReviewVO> getReviewsByPid(int pid) throws Exception {
        return popMapper.getReviewsByPid(pid);
    }
    //특정 리뷰에 대한 이미지 조회
    @Override
    public List<RimageVO> getImagesByReviewId(int mId, int pId) throws Exception {
        return popMapper.getImagesByReviewId(mId, pId);
    }
}
