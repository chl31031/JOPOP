<<<<<<< HEAD
package com.jopop.model;

import java.util.Date;
import java.util.List;

public class OrderDTO {
	
	private String orderId;
	private int mId;
	private String mNick;
	private String mEmail;
	private Date orderdate;        //주문한 날짜
	 
	//회원의 충전금
	private int money;
	
	//예약 상태
	private String orderState;
	//주문 상품
	private List<OrderItemDTO> orders;
	
	/*DB테이블 존재 하지 않는 데이터*/
	private int totalPrice;       //판매가(모든 상품 비용)
	private int orderFinalSalePrice;   //최종 비용
	private int useMoney;
	
	public void getOrderPriceInfo() {
		orderFinalSalePrice = totalPrice - useMoney;
		money -= useMoney;                     //사용하고 남은 충전금
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

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public List<OrderItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderItemDTO> orders) {
		this.orders = orders;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getOrderFinalSalePrice() {
		return orderFinalSalePrice;
	}

	public void setOrderFinalSalePrice(int orderFinalSalePrice) {
		this.orderFinalSalePrice = orderFinalSalePrice;
	}

	public int getUseMoney() {
		return useMoney;
	}

	public void setUseMoney(int useMoney) {
		this.useMoney = useMoney;
	}

	@Override
	public String toString() {
		return "OrderDTO [orderId=" + orderId + ", mId=" + mId + ", mNick=" + mNick + ", mEmail=" + mEmail
				+ ", orderdate=" + orderdate + ", money=" + money + ", orderState=" + orderState + ", orders=" + orders
				+ ", totalPrice=" + totalPrice + ", orderFinalSalePrice=" + orderFinalSalePrice + ", useMoney="
				+ useMoney + "]";
	}

	
	
}
=======
package com.jopop.model;

import java.util.Date;
import java.util.List;

public class OrderDTO {
	
	private String orderId;
	private int mId;
	private String mNick;
	private String mEmail;
	private Date orderdate;        //주문한 날짜
	 
	//회원의 충전금
	private int money;
	
	//예약 상태
	private String orderState;
	//주문 상품
	private List<OrderItemDTO> orders;
	
	/*DB테이블 존재 하지 않는 데이터*/
	private int totalPrice;       //판매가(모든 상품 비용)
	private int orderFinalSalePrice;   //최종 비용
	private int useMoney;
	
	public void getOrderPriceInfo() {
		orderFinalSalePrice = totalPrice - useMoney;
		money -= useMoney;                     //사용하고 남은 충전금
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

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public List<OrderItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderItemDTO> orders) {
		this.orders = orders;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getOrderFinalSalePrice() {
		return orderFinalSalePrice;
	}

	public void setOrderFinalSalePrice(int orderFinalSalePrice) {
		this.orderFinalSalePrice = orderFinalSalePrice;
	}

	public int getUseMoney() {
		return useMoney;
	}

	public void setUseMoney(int useMoney) {
		this.useMoney = useMoney;
	}

	@Override
	public String toString() {
		return "OrderDTO [orderId=" + orderId + ", mId=" + mId + ", mNick=" + mNick + ", mEmail=" + mEmail
				+ ", orderdate=" + orderdate + ", money=" + money + ", orderState=" + orderState + ", orders=" + orders
				+ ", totalPrice=" + totalPrice + ", orderFinalSalePrice=" + orderFinalSalePrice + ", useMoney="
				+ useMoney + "]";
	}

	
	
}
>>>>>>> branch 'main' of https://github.com/rkawk775/JOPOP-Web.git
