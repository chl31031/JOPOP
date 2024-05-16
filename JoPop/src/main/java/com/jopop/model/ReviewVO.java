package com.jopop.model;

import java.util.Date;

//리뷰 VO
public class ReviewVO {
	private int rId;
	private String mId;
	private String mNick;
	private String pId;
	private String pName;
	private String contents;
	private int score;
	private Date rDate;
	
	
	
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getmNick() {
		return mNick;
	}
	public void setmNick(String mNick) {
		this.mNick = mNick;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Date getrDate() {
		return rDate;
	}
	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}
	@Override
	public String toString() {
		return "ReviewVO [rId=" + rId + ", mId=" + mId + ", mNick=" + mNick + ", pId=" + pId + ", pName=" + pName
				+ ", contents=" + contents + ", score=" + score + ", rDate=" + rDate + "]";
	}
	
	
	
	
}
