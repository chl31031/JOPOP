package com.jopop.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jopop.model.Criteria;
import com.jopop.model.ImageVO;
import com.jopop.model.MemberVO;
import com.jopop.model.PageDTO;
import com.jopop.model.PopVO;
import com.jopop.service.AdminService;
import com.jopop.service.MemberService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {
  
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);     
  
  @Autowired
  private AdminService adminService;
  
  @Autowired
  private MemberService memberService;
  
  /* 관리자 메인 페이지 이동 */
  @RequestMapping(value="main", method =RequestMethod.GET)
  public void adminMainGET() throws Exception {
	  
	  logger.info("관리자 페이지 이동");
  
  }
  

  /* 팝업 정보 관리 페이지 접속 */
  @RequestMapping(value = "popsManage", method = RequestMethod.GET)
  public void popsManageGET(Criteria cri, Model model) throws Exception{
      
	  logger.info("팝업 정보 관리(팝업 목록) 페이지 접속");
      
      //상품 리스트 데이터 
      List list =adminService.popsGetList(cri);
      
      if(!list.isEmpty()) {
    	  model.addAttribute("list", list);
      }else {
    	  model.addAttribute("listCheck", "empty");
    	  return;
      }
      
      //페이지 인터 페이스 데이터 
      model.addAttribute("pageMaker", new PageDTO(cri, adminService.popsGetTotal(cri)));
  }
  
  /* 팝업 정보 등록 페이지 접속 */
  @RequestMapping(value = "popsEnroll", method = RequestMethod.GET)
  public void popsEnrollGET(Model model) throws Exception{
      
	  logger.info("팝업 등록 페이지 접속");
      
      ObjectMapper om = new ObjectMapper();
      
      List list = adminService.cateList();
      
      String cateList = om.writeValueAsString(list);
      
      model.addAttribute("cateList", cateList);
      
      logger.info("변경 전.........." + list);
	  logger.info("변경 후.........." + cateList);
      
  }
  
  /* 팝업 등록 post */ 
  @PostMapping("/popsEnroll")
  public String popsEnrollPOST(PopVO pop, RedirectAttributes rttr) {
	  
	  logger.info("팝업 등록(popsEnrollPOST)...."+pop);
	  
	  adminService.popsEnroll(pop);
	  
	  rttr.addFlashAttribute("enroll_result", pop.getpName());
	  
	  return "redirect:/admin/popsManage";
  } 

  /* 팝업 상세내역 조회 페이지? */
  @GetMapping({"/popsDetail","/popsModify"})
  public void popsGetInfoGET(int pId, Criteria cri, Model model) throws JsonProcessingException  {
	  
	  logger.info("팝업 정보 조회(popsGetInfo())....." + pId);
	  
	  ObjectMapper mapper = new ObjectMapper();
	  
	  //카테고리 리스트 데이터 
	  model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));
	  	  
	  //목록 페이지 조건 정보 ?
	  model.addAttribute("cri", cri);
	  
	  //조회 페이지 정보 ?
	  model.addAttribute("popsInfo", adminService.popsGetDetail(pId));
  }
  
  /* 팝업 정보 수정 */
  @PostMapping("/popsModify")
  public String popsModifyPOST(PopVO vo, RedirectAttributes rttr) {
	  
	  logger.info("팝업 정보 수정(popsModifyPost)...." + vo);
	  
	  int result = adminService.popsModify(vo);
	  
	  rttr.addFlashAttribute("modify_result",result);
	  
	  return "redirect:/admin/popsManage";
  }
  
  /* 팝업 정보 삭제 */
  @PostMapping("/popsDelete")
  public String popsDeletePOST(int pId,RedirectAttributes rttr) {
	  
	  logger.info("팝업 정보 삭제(popsDeletePOST)....");
	  
	  List<ImageVO> fileList = adminService.getImageInfo(pId);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo ->{
				
				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// 썸네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid()+"_" + vo.getFileName());
				pathList.add(path);
				
			});
			
			pathList.forEach(path ->{
				path.toFile().delete();
			});
			
		}
	  
	  int result = adminService.popsDelete(pId);
	  
	  rttr.addFlashAttribute("delete_result", result);
	  
	  return "redirect:/admin/popsManage";
  }
  
  /* 팝업 첨부 파일(이미지) 업로드 설명이 필요행*/
  @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<ImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		
		logger.info("팝업 이미지 업로드(uploadAjaxAcitonPOST)....");
					
		//이미지 파일 체크 
		for(MultipartFile multipartFile:uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
				
				logger.info("MTME TYPE:" + type);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				List<ImageVO> list = null;
				return new ResponseEntity<>(list,HttpStatus.BAD_REQUEST);
				
			}
		}//for
		
		//업로드된 파일 경로
		String uploadFolder = "C:\\upload"; 
		
		//날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		//폴더 생성 
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		  
		//이미지 정보 담는 객체 
		List<ImageVO> list = new ArrayList();
		
		//향상된 for ??
		for(MultipartFile multipartFile : uploadFile) {
			
			//이미지 정보 객체 
			ImageVO vo = new ImageVO();
			
			//파일 이름 transferTo 메소드
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			
			
			// uuid 적용 파일 이름 __파일이름 같은 방식 적용
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			// 파일 위치, 파일 이름을 합친 File 객체 
			File saveFile = new File(uploadPath, uploadFileName);
			
			// 파일 저장 
			try {
				multipartFile.transferTo(saveFile);
								
				//방법 2 
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				//비율 
				double ratio = 3;
				
				//넓이 높이 
				int width = (int)(bo_image.getWidth()/ratio);
				int height = (int)(bo_image.getHeight()/ratio);
				
				Thumbnails.of(saveFile)
				.size(width, height)
				.toFile(thumbnailFile);			    
			    
			} catch (Exception e) {
				e.printStackTrace();
			} 
			list.add(vo);
			
		}//for
		
		ResponseEntity<List<ImageVO>> result = new ResponseEntity<List<ImageVO>>(list,HttpStatus.OK);
	
		return result;
	}
  
  /* 팝업 이미지 삭제 */ 
  @PostMapping("/deleteFile")
  
  public ResponseEntity<String> deleteFile(String fileName){
	   
	  logger.info("팝업 이미지 삭제(deleteFile)....." + fileName);
	   
	   File file = null;
	   
	   //썸네일 파일 삭제 	   
	   try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			//원본 파일 삭제			
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			logger.info("originFileName"  +originFileName);
			
			file = new File(originFileName);
			
			file.delete();
		   
	   }catch (Exception e) {
		   e.printStackTrace();
		   
		   return new  ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
	}//catch
	   
	   return new  ResponseEntity<String>("success", HttpStatus.OK);
  }
  
  //여기서부터 회원관리 코드 추가
  
  /* 회원 정보 관리 페이지 접속 */
  @RequestMapping(value = "memberManage", method = RequestMethod.GET)
  public void MemberManageGET(Criteria cri, Model model) throws Exception{
      
	  logger.info("회원 정보 관리 페이지 접속");
      
      //회원 리스트 데이터 
      List mlist = memberService.memberGetList(cri);
      
      if(!mlist.isEmpty()) {
    	  model.addAttribute("list", mlist);
      }else {
    	  model.addAttribute("listCheck", "empty");
    	  return;
      }
  }
  
  /* 회원 정보 상세 페이지 */
  @GetMapping({"/memberDetail","/memberModify"})
  public void memberGetInfoGET(int mId, Criteria cri, Model model) throws JsonProcessingException  {
	  
	  logger.info("팝업 정보 조회(memberGetInfo())....." + mId);
	  
	  ObjectMapper mapper = new ObjectMapper();
	  	  
	  //목록 페이지 조건 정보 ?
	  model.addAttribute("cri", cri);
	  
	  //조회 페이지 정보 ?
	  model.addAttribute("memberInfo", memberService.memberGetDetail(mId));
  }
  
  /* 회원 정보 수정 */
  @PostMapping("/memberModify")
  public String memberModifyPOST(MemberVO vo, RedirectAttributes rttr) {
	  
	  logger.info("회원 정보 수정(memberModifyPost)...." + vo);
	  
	  int result = memberService.memberModify(vo);
	  
	  rttr.addFlashAttribute("modify_result",result);
	  
	  return "redirect:/admin/memberManage";
  }
  
  /* 팝업 정보 삭제 
  @PostMapping("/popsDelete")
  public String popsDeletePOST(int pId,RedirectAttributes rttr) {
	  
	  logger.info("팝업 정보 삭제(popsDeletePOST)....");
	  
	  List<ImageVO> fileList = adminService.getImageInfo(pId);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo ->{
				
				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// 썸네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid()+"_" + vo.getFileName());
				pathList.add(path);
				
			});
			
			pathList.forEach(path ->{
				path.toFile().delete();
			});
			
		}
	  
	  int result = adminService.popsDelete(pId);
	  
	  rttr.addFlashAttribute("delete_result", result);
	  
	  return "redirect:/admin/popsManage";
  }*/
	
	
	//특정 회원이 작성한 후기
	/*@ResponseBody
	@PostMapping("/getCommentList")
	public List<CommentVO> getCommentList(String com_writer){
		System.out.println("open! user Comment List ajax!");
		System.out.println("조회할 회원 아이디 : " + com_writer);
		List<CommentVO> list = comService.getComList(com_writer);
		System.out.println(list);
		return list;
	}*/
	   
  
  /* 유저 삭제 */
	@ResponseBody
	@PostMapping("/memberDrop")
	public void memberdrop(int mid) {
		memberService.memberDrop(mid);
	}
   
}
