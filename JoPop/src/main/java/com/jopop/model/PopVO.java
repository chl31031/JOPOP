package com.jopop.model;

import java.util.Date;
import java.util.List;

public class PopVO {
    private int pId;   //상품 번호
    private String pName; //상품 명
    private Date startDate; //팝업 시작 일자
    private Date endDate;  //팝업 종료 일자
    private String pAddr1; // 팝업 주소
    private String pAddr2;
    private String pAddr3;
    private int pPrice;    //팝업 입장료
    private String pIntro; // 이용안내
    private String pContents; // 팝업 소개
    private MapVO mapVO; // 수정된 부분: mapVO 속성 추가
    private String cateCode;
    private List<ImageVO> imageList; //이미지 정보
    

    public List<ImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<ImageVO> imageList) {
		this.imageList = imageList;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getpAddr1() {
        return pAddr1;
    }

    public void setpAddr1(String pAddr1) {
        this.pAddr1 = pAddr1;
    }

    public String getpAddr2() {
        return pAddr2;
    }

    public void setpAddr2(String pAddr2) {
        this.pAddr2 = pAddr2;
    }

    public String getpAddr3() {
        return pAddr3;
    }

    public void setpAddr3(String pAddr3) {
        this.pAddr3 = pAddr3;
    }

    public int getpPrice() {
        return pPrice;
    }

    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }

    public String getpIntro() {
        return pIntro;
    }

    public void setpIntro(String pIntro) {
        this.pIntro = pIntro;
    }

    public String getpContents() {
        return pContents;
    }

    public void setpContents(String pContents) {
        this.pContents = pContents;
    }

    // 수정된 부분: mapVO 속성에 대한 getter 추가
    public MapVO getMapVO() {
        return mapVO;
    }

    // 수정된 부분: mapVO 속성에 대한 setter 추가
    public void setMapVO(MapVO mapVO) {
        this.mapVO = mapVO;
    }

    @Override
	public String toString() {
		return "PopVO [pId=" + pId + ", pName=" + pName + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", pAddr1=" + pAddr1 + ", pAddr2=" + pAddr2 + ", pAddr3=" + pAddr3 + ", pPrice=" + pPrice
				+ ", pIntro=" + pIntro + ", pContents=" + pContents + ", mapVO=" + mapVO + ", cateCode=" + cateCode
				+ ", imageList=" + imageList + "]";
	}
}
