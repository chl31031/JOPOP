package com.jopop.model;

import java.util.Date;
import java.util.List;

// 관심팝업 VO
public class CartVO {
   
   private int cartId;
   private int mId;
   private int pId;
   
   //pop
   private String pName;         //팝업 이름
   private int pPrice;           //팝업 가격
   private String pAddr1;        //팝업 위치(시)
   private String pAddr2;        //팝업 위치(구)
   private Date startDate;       //팝업 시작 일시
   private Date endDate;         //팝업 종료 일시
   
   //상품 이미지
   private List<ImageVO> imageList;
   
   //검색을 위한 키워드
   private String keyword;

	public int getCartId() {
		return cartId;
	}
	
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	
	public int getmId() {
		return mId;
	}
	
	public void setmId(int mId) {
		this.mId = mId;
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
	
	public int getpPrice() {
		return pPrice;
	}
	
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
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
	
	public List<ImageVO> getImageList() {
		return imageList;
	}
	
	public void setImageList(List<ImageVO> imageList) {
		this.imageList = imageList;
	}
	
	@Override
	public String toString() {
		return "CartVO [cartId=" + cartId + ", mId=" + mId + ", pId=" + pId + ", pName=" + pName + ", pPrice=" + pPrice
				+ ", pAddr1=" + pAddr1 + ", pAddr2=" + pAddr2 + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", imageList=" + imageList + "]";
	}
   
}