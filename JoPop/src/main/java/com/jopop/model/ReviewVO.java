package com.jopop.model;

import java.util.Date;
import java.util.List;

public class ReviewVO {
    private int rId;
    private int mId;
    private String mNick;
    private int pId;
    private String pName;
    private String contents;
    private int score;
    private Date rDate;
    
    private List<RimageVO> imageList; // 후기 이미지 등록 정보

    // Getters와 Setters
    public int getrId() {
        return rId;
    }

    public void setrId(int rId) {
        this.rId = rId;
    }

    public int getmId() {
        return mId;
    }

    public void setmId(int mId) {
        this.mId = mId;
    }

    public String getmNick() {
        return mNick;
    }

    public void setmNick(String mNick) {
        this.mNick = mNick;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Date getrDate() {
        return rDate;
    }

    public void setrDate(Date rDate) {
        this.rDate = rDate;
    }

    public List<RimageVO> getImageList() {
        return imageList;
    }

    public void setImageList(List<RimageVO> imageList) {
        this.imageList = imageList;
    }

    @Override
    public String toString() {
        return "ReviewVO [rId=" + rId + ", mId=" + mId + ", mNick=" + mNick + ", pId=" + pId + ", pName=" + pName
                + ", contents=" + contents + ", score=" + score + ", rDate=" + rDate + ", imageList=" + imageList
                + "]";
    }
}
