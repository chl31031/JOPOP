package com.jopop.model;

//지도정보 VO
public class MapVO {

	private int pId; //POP 테이블 기본키
	private String cateCode; //카테고리 코드
	private String pName; // 팝업 상품 명
	private String cateName; // 지역구 이름
	private String lat; // 위도
	private String lng; // 경도
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getCateCode() {
		return cateCode;
	}
	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	@Override
	public String toString() {
		return "MapVO [pId=" + pId + ", cateCode=" + cateCode + ", pName=" + pName + ", cateName=" + cateName + ", lat="
				+ lat + ", lng=" + lng + "]";
	}
	
	
}
