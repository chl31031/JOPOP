package com.jopop.model;

import java.util.Date;
import java.util.List;

public class RatingDTO {

	/* 상품번호 */
	private int pId;
	
	/* 상품 명*/
	private String pName;
	
	private Date startDate;
	
	private Date endDate;
	
	private String pAddr1;
	
	private String pAddr2;
	
	private int  pPrice;
	
	private  int rating;
	
	/* 상품 이미지 */
	private List<ImageVO> imageList;

	
	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public List<ImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<ImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "RatingDTO [pId=" + pId + ", pName=" + pName + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", pAddr1=" + pAddr1 + ", pAddr2=" + pAddr2 + ", pPrice=" + pPrice + ", rating=" + rating
				+ ", imageList=" + imageList + "]";
	}
	
	
}
