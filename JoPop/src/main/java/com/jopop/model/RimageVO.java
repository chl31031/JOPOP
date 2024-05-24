package com.jopop.model;

import lombok.Data;

@Data
public class RimageVO {
    // 경로 
    private String uploadPath;
    
    // uuid 
    private String uuid;
    
    // 파일 이름 
    private String fileName;
    
    // 상품 id 
    private int pId;
    
    // 멤버 id
    private int mId;

    // Getter 및 Setter (Lombok의 @Data 어노테이션으로 자동 생성)
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

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public int getmId() {
        return mId;
    }

    public void setmId(int mId) {
        this.mId = mId;
    }

    @Override
    public String toString() {
        return "RimageVO [uploadPath=" + uploadPath + ", uuid=" + uuid + ", fileName=" + fileName + ", pId=" + pId
                + ", mId=" + mId + "]";
    }
}
