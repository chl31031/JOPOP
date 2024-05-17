package com.jopop.model;

// 관심팝업 VO
public class CartVO {
   
   private int cartId;
   private String mId;
   private int pId;
   
   //pop
   private String pName;         //팝업 이름
   private int pPrice;           //팝업 가격
   
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
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
	@Override
	public String toString() {
		return "CartVO [cartId=" + cartId + ", mId=" + mId + ", pId=" + pId + ", pName=" + pName + ", pPrice=" + pPrice
				+ "]";
	}
   
   
}