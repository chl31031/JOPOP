package com.jopop.model;

public class MemberVO {
	
	private int mId; // 회원번호
	private String mEmail; // 이메일
	private String mPw; // 비밀번호
	private String mName; // 이름
	private String mNick; // 닉네임
	private String mAddr1; // 주소
	private String mAddr2;
	private String mAddr3;
	private int adminCk;   //회원 등급 
	private int memberShip; // 멤버십
	private int money;   //돈
	
	//검색을 위한 키워드
	private String keyword;
	
	public int getmId() {
		return mId;
	}
	public void setmId(int mId) {
		this.mId = mId;
	}
	public String getmEmail() {
		return mEmail;
	}
	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}
	public String getmPw() {
		return mPw;
	}
	public void setmPw(String mPw) {
		this.mPw = mPw;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getmNick() {
		return mNick;
	}
	public void setmNick(String mNick) {
		this.mNick = mNick;
	}
	public String getmAddr1() {
		return mAddr1;
	}
	public void setmAddr1(String mAddr1) {
		this.mAddr1 = mAddr1;
	}
	public String getmAddr2() {
		return mAddr2;
	}
	public void setmAddr2(String mAddr2) {
		this.mAddr2 = mAddr2;
	}
	public String getmAddr3() {
		return mAddr3;
	}
	public void setmAddr3(String mAddr3) {
		this.mAddr3 = mAddr3;
	}
	public int getAdminCk() {
		return adminCk;
	}
	public void setAdminCk(int adminCk) {
		this.adminCk = adminCk;
	}
	public int getMemberShip() {
		return memberShip;
	}
	public void setMemberShip(int memberShip) {
		this.memberShip = memberShip;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "MemberVO [mId=" + mId + ", mEmail=" + mEmail + ", mPw=" + mPw + ", mName=" + mName + ", mNick=" + mNick
				+ ", mAddr1=" + mAddr1 + ", mAddr2=" + mAddr2 + ", mAddr3=" + mAddr3 + ", adminCk=" + adminCk
				+ ", memberShip=" + memberShip + ", money=" + money + ", keyword=" + keyword + "]";
	}

}
