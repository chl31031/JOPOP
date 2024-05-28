package com.jopop.model;

//상품 데이터 담는 클래스
public class OrderPageItemDTO {
	
	//뷰로부터 전달받은 값
	private int pId; 
	private int Count;
	
	//DB로부터 꺼내올 값
	private String pName;
	private int pPrice;
	private int memberShip;          //멤버십 별로 할인율 적용하게 하기
	
	//만들어 낼 값
	private int salePrice;
	private int totalPrice;
	private double Discount;
	
	public void initSaleTotal() {
		this.salePrice = (int)(this.pPrice * (1-this.Discount));
		this.totalPrice = this.salePrice*this.Count;
	}
	
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public int getCount() {
		return Count;
	}
	public void setCount(int count) {
		Count = count;
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
	public int getMemberShip() {
		return memberShip;
	}
	public void setMemberShip(int memberShip) {
		this.memberShip = memberShip;
	}
	public int getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "OrderPageItemDTO [pId=" + pId + ", Count=" + Count + ", pName=" + pName + ", pPrice=" + pPrice
				+ ", memberShip=" + memberShip + ", salePrice=" + salePrice + ", totalPrice=" + totalPrice
				+ ", Discount=" + Discount + "]";
	}
	
	
}
