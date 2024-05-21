
package com.jopop.model;

import lombok.Data;

@Data
public class RimageVO {

	
	
	    //경로 
		private String uploadPath;
		
		//uuid 
		private String uuid;
		
		//파일 이름ㅁ 
		private String fileName;
		
		//상품 id 
		private int pId;

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

		public String getFileName() {
			return fileName;
		}

		public void setFileName(String fileName) {
			this.fileName = fileName;
		}

		public int getBookId() {
			return pId;
		}

		public void setBookId(int bookId) {
			this.pId = bookId;
		}

		@Override
		public String toString() {
			return "AttachImageVO [uploadPath=" + uploadPath + ", uuid=" + uuid + ", fileName=" + fileName + ", bookId="
					+ pId + "]";
		}
	
}
