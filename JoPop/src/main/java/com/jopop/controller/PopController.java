package com.jopop.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jopop.model.CartVO;
import com.jopop.model.Criteria;
import com.jopop.model.MemberVO;
import com.jopop.model.PopVO;
import com.jopop.model.ReviewVO;
import com.jopop.model.RimageVO;
import com.jopop.service.CartService;
import com.jopop.service.PopService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/pop")
public class PopController {
    private static final Logger logger = LoggerFactory.getLogger(PopController.class);

    @Autowired
    PopService popService;
    
    @Autowired
    CartService cartService;

    
 // 모든 장소 정보 조회 + 리스트 
    @GetMapping("/locations")
    public String getAllLocations(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        Criteria cri = new Criteria();
        cri.setKeyword(keyword);

        logger.info("Criteria: " + cri);

        List<PopVO> list = new ArrayList<>();
        try {
            list = popService.getGoodsList(cri);
            logger.info("List: " + list);
        } catch (Exception e) {
            logger.error("Error fetching goods list", e);
        }

        model.addAttribute("list", list);

        List<PopVO> locations = new ArrayList<>();
        try {
            locations = popService.getAllLocations();
            model.addAttribute("locations", locations);
        } catch (Exception e) {
            logger.error("Error fetching locations", e);
        }

        return "pop/locations";
    }
    
     
 // 상품 리뷰 조회
    @GetMapping("/popsDetail")
    public String popsDetailGET(@RequestParam(value = "pid", required = true) int pid, Criteria cri, Model model, HttpSession session) throws Exception {
        logger.info("popsDetailGetInfo().... PID: " + pid);

        model.addAttribute("cri", cri);
        PopVO popsInfo = popService.PopGoodsInfo(pid);

        if (popsInfo == null) {
            logger.warn("No pop information found for PID: " + pid);
            return "redirect:/errorPage";
        }

        model.addAttribute("popsInfo", popsInfo);

        List<ReviewVO> reviews = popService.getReviewsByPid(pid);
        for (ReviewVO review : reviews) {
            List<RimageVO> images = popService.getImagesByReviewId(review.getmId(), review.getpId());
            review.setImageList(images);
        }
        model.addAttribute("reviews", reviews);
        model.addAttribute(popService.getImagesByReviewId(pid, pid));

        // 찜 상태 확인
        MemberVO member = (MemberVO) session.getAttribute("member");
        boolean isLiked = false;
        if (member != null) {
            CartVO cart = new CartVO();
            cart.setmId(member.getmId());
            cart.setpId(pid);
            isLiked = cartService.checkCart(cart) != null;
        }
        model.addAttribute("isLiked", isLiked);

        return "pop/popsDetail";
    }
    
    // 찜 상태 확인
    @GetMapping("/checkCart")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkCart(@RequestParam("pId") int pId, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("member");
        Map<String, Boolean> response = new HashMap<>();
        if (member == null) {
            response.put("isLiked", false);
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }

        CartVO cart = new CartVO();
        cart.setmId(member.getmId());
        cart.setpId(pId);
        CartVO result = cartService.checkCart(cart);
        boolean isLiked = result != null;

        // 디버깅 로그 추가
        logger.info("Member ID: " + member.getmId());
        logger.info("Product ID: " + pId);
        logger.info("Cart Result: " + (result != null));

        response.put("isLiked", isLiked);
        return ResponseEntity.ok(response);
    }

    // 찜 추가
    @PostMapping("/addlike")
    @ResponseBody
    public ResponseEntity<String> addLike(@RequestParam("pId") int pId, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("member");
        if (member == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        CartVO cart = new CartVO();
        cart.setmId(member.getmId());
        cart.setpId(pId);

        try {
            cartService.addCart(cart);
            logger.info("상품 {}이(가) 찜되었습니다.", pId);
            return new ResponseEntity<>("찜 추가 완료", HttpStatus.OK);
        } catch (Exception e) {
            logger.error("찜하기 중 오류 발생: {}", e.getMessage());
            return new ResponseEntity<>("찜 추가 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 찜 삭제
    @PostMapping("/deletelike")
    @ResponseBody
    public ResponseEntity<String> deleteLike(@RequestParam("pId") int pId, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("member");
        if (member == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        try {
            cartService.deleteCart(pId);
            logger.info("상품 {}이(가) 찜 목록에서 삭제되었습니다.", pId);
            return new ResponseEntity<>("찜 삭제 완료", HttpStatus.OK);
        } catch (Exception e) {
            logger.error("찜 삭제 중 오류 발생: {}", e.getMessage());
            return new ResponseEntity<>("찜 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    


    // 첨부 파일 업로드
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<RimageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
        logger.info("uploadAjaxActionPOST..........");

        for (MultipartFile multipartFile : uploadFile) {
            File checkfile = new File(multipartFile.getOriginalFilename());
            String type = null;
            try {
                type = Files.probeContentType(checkfile.toPath());
                logger.info("MIME TYPE : " + type);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (!type.startsWith("image")) {
                List<RimageVO> list = null;
                return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
            }
        }

        // 경로 변경
        String uploadFolder = "C:/Users/admin/git/JOPOP-Web/JoPop/src/main/webapp/resources/Rimg";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator);

        File uploadPath = new File(uploadFolder, datePath);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        List<RimageVO> list = new ArrayList<>();

        for (MultipartFile multipartFile : uploadFile) {
            RimageVO vo = new RimageVO();

            String uploadFileName = multipartFile.getOriginalFilename();
            vo.setFileName(uploadFileName);
            vo.setUploadPath(datePath);

            String uuid = UUID.randomUUID().toString();
            vo.setUuid(uuid);

            uploadFileName = uuid + "_" + uploadFileName;

            File saveFile = new File(uploadPath, uploadFileName);

            try {
                multipartFile.transferTo(saveFile);

                File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                BufferedImage bo_image = ImageIO.read(saveFile);

                double ratio = 3;
                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);

                Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

            list.add(vo);
        }

        ResponseEntity<List<RimageVO>> result = new ResponseEntity<>(list, HttpStatus.OK);
        return result;
    }

    // 이미지 출력 
    @GetMapping("/display")
    public ResponseEntity<Resource> getImage(@RequestParam("fileName") String fileName) {
        try {
            // 경로 변경
            File file = new File("C:/Users/admin/git/JOPOP-Web/JoPop/src/main/webapp/resources/Rimg/" + fileName);
            if (file.exists()) {
                Resource resource = new FileSystemResource(file);
                HttpHeaders headers = new HttpHeaders();
                headers.add(HttpHeaders.CONTENT_TYPE, Files.probeContentType(file.toPath()));
                return new ResponseEntity<>(resource, headers, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 이미지 삭제
    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName) {
        logger.info("deleteFile........" + fileName);

        File file = null;
        try {
            // 경로 변경
            file = new File("C:/Users/admin/git/JOPOP-Web/JoPop/src/main/webapp/resources/Rimg/" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();

            String originFileName = file.getAbsolutePath().replace("s_", "");
            logger.info("originFileName : " + originFileName);
            file = new File(originFileName);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }

    // 리뷰 추가 메서드
    @PostMapping("/addReview")
    @ResponseBody
    public Map<String, String> addReview(@RequestParam("pId") int pId, @RequestParam("contents") String contents, @RequestParam("score") int score, @RequestParam(value = "imageList", required = false) String imageListJson, HttpSession session, Model model) throws Exception {
        Map<String, String> result = new HashMap<>();
        MemberVO member = (MemberVO) session.getAttribute("member");

        if (member == null) {
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        int mId = member.getmId();

        ReviewVO review = new ReviewVO();
        review.setpId(pId);
        review.setmId(mId);
        review.setContents(contents);
        review.setScore(score);

        List<RimageVO> imageList = null;
        if (imageListJson != null && !imageListJson.isEmpty()) {
            imageList = new ObjectMapper().readValue(imageListJson, new TypeReference<List<RimageVO>>() {});
        }

        popService.addReviewAndImages(review, imageList);

        result.put("message", "후기 등록이 완료되었습니다!");
        return result;
    }
    
 

   
   
}