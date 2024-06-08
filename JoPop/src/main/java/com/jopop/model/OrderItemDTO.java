package com.jopop.model;

import java.util.Date;

public class OrderItemDTO {
	
	private int orderItemId;
	private int mId;
	private String mNick;
	private String mEmail;
	private int count;
	private Date orderDate;       //예약일
	private int pId;
	private String orderTime;     //예약 방문 시간
	private int membership;       //멤버십(1: 할인율 0,  2: 5%, 3: 10%, 4: 15%)
	
	//orderItem 기본키
	private String orderId;
	
	//상품 한 개의 가격
	private int pPrice;
	
	//DB에 존재하지 않는 데이터
	private int salePrice;
	private int totalPrice;  
	private int finalTotalPrice;  //최종 가격
	private double discount;
	
	public void initSaleTotal() {
		this.salePrice = (int) (this.pPrice * discount);
		this.totalPrice = this.salePrice*this.count;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
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

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
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

	public int getFinalTotalPrice() {
		return finalTotalPrice;
	}

	public void setFinalTotalPrice(int finalTotalPrice) {
		this.finalTotalPrice = finalTotalPrice;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public int getpId() {
		return pId;
	}

	public void setpId(int pId) {
		this.pId = pId;
	}

	public int getMembership() {
		return membership;
	}

	public void setMembership(int membership) {
		this.membership = membership;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [orderItemId=" + orderItemId + ", mId=" + mId + ", mNick=" + mNick + ", mEmail=" + mEmail
				+ ", count=" + count + ", orderDate=" + orderDate + ", pId=" + pId + ", orderTime=" + orderTime
				+ ", membership=" + membership + ", orderId=" + orderId + ", pPrice=" + pPrice + ", salePrice="
				+ salePrice + ", totalPrice=" + totalPrice + ", finalTotalPrice=" + finalTotalPrice + ", discount="
				+ discount + "]";
	}
	
}
