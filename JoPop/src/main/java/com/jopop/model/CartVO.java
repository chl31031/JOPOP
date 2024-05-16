package com.jopop.model;

// 관심팝업 VO
public class CartVO {
	
	private int cartId;
	private String mId;
	private int pId;
	
	//pop
	
	
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
	@Override
	public String toString() {
		return "CartVO [cartId=" + cartId + ", mId=" + mId + ", pId=" + pId + "]";
	}
	
	
}
