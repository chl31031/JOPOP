package com.jopop.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jopop.model.Criteria;
import com.jopop.model.PopVO;
import com.jopop.model.RimageVO;
import com.jopop.service.PopService;

import net.coobird.thumbnailator.Thumbnails;
@Controller
@RequestMapping("/pop")
public class PopController {
private static final Logger logger = LoggerFactory.getLogger(PopController.class);

		@Autowired
		PopService popService;


	/*검색 페이지로 이동 */
	@GetMapping("/search")
	public void searchGET() {
		logger.info("검색 페이지로 이동");
	}
	
	//상품 조회 
    @GetMapping("/popsDetail")
    public String popsDetailGET(@RequestParam(value = "pid", required = true) int pid, Criteria cri, Model model) {
        logger.info("popsDetailGetInfo().... PID: " + pid);

        model.addAttribute("cri", cri);
        PopVO popsInfo = popService.PopGoodsInfo(pid);

        if (popsInfo == null) {
            logger.warn("No pop information found for PID: " + pid);
            return "redirect:/errorPage"; // 없다면 리다이렉트 
        }

        model.addAttribute("popsInfo", popsInfo);
        return "pop/popDetail"; // 
    }

    /* 첨부 파일 업로드 */
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<RimageVO>>  uploadAjaxActionPOST(MultipartFile[] uploadFile) {
        logger.info("uploadAjaxActionPOST..........");
            
        
        /* 이미지 파일 체크 */
		for(MultipartFile multipartFile: uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			if(!type.startsWith("image")) {
				
				List<RimageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
				
			}
			
		}// for
        
        String uploadFolder = "C:\\upload";
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		/* 이미저 정보 담는 객체 */
		List<RimageVO> list = new ArrayList();
        
        // 향상된 for
        for (MultipartFile multipartFile : uploadFile) {
        	
        	//이미지 정보 객체 
        	RimageVO vo = new RimageVO();
        	
        	
        	/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();	
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				
				/*
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
				BufferedImage bt_image = new BufferedImage(300, 500, BufferedImage.TYPE_3BYTE_BGR);
								
				Graphics2D graphic = bt_image.createGraphics();
				
				graphic.drawImage(bo_image, 0, 0,300,500, null);
					
				ImageIO.write(bt_image, "jpg", thumbnailFile);  방법 1 주석*/
				
				
				/* 방법 2 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
				
				BufferedImage bo_image = ImageIO.read(saveFile);

					//비율 
					double ratio = 3;
					//넓이 높이
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio);					
				
				
				Thumbnails.of(saveFile)
		        .size(width, height)
		        .toFile(thumbnailFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			list.add(vo);
        } //for

        ResponseEntity<List<RimageVO>> result = new ResponseEntity<List<RimageVO>>(list, HttpStatus.OK);
        
        return result;
        }
    
    
 // 이미지 출력
    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        File file = new File("c:\\upload\\" + fileName);
        
        logger.info("Requested file: " + fileName); // 경로 확인용 로그 출력

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
     
    
    
    /* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		logger.info("deleteFile........" + fileName);
		
		File file =null; 
		
		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			logger.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		} //catch
		return new ResponseEntity<String>("success", HttpStatus.OK);
		
	}
	
	
	

 
}
