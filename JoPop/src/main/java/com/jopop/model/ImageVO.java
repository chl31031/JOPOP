package com.jopop.model;

import lombok.Data;

@Data
public class ImageVO {
	
	private int pId; // 팝업id
	private String fileName; // 파일 이름
	private String uploadPath; //경로
	private String uuid; //uuid
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	@Override
	public String toString() {
		return "ImageVO [pId=" + pId + ", fileName=" + fileName + ", uploadPath=" + uploadPath + ", uuid=" + uuid + "]";
	}
	
	
	
}
