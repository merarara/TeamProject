package com.project.springboot.prservice;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

@Controller
public class PReviewController {
	
	@Autowired
	IPReviewDaoService prdao;
	
	// 상품 리뷰 글 업로드
	@RequestMapping(value="/product/reviewUpload.do", method=RequestMethod.POST)
	public String reviewUpload(MultipartFile[] review_file, ReviewDTO rdto,
			MultipartHttpServletRequest req) {
		String path = "";
		
		System.out.println(review_file);
		
		int ireview = prdao.insertReview(rdto);
		
		int r_num = prdao.checkRnum(rdto.getP_num(), rdto.getU_id());
		
		int upd = prdao.revGoodUpdate(rdto.getP_num());
		
		if (!review_file[0].isEmpty()) {
			for (MultipartFile f: review_file) {
				String originalName = f.getOriginalFilename();
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String savedName = uuid + ext;
				
				try {
					path = ResourceUtils.getFile("classpath:static/revuploads/")
							.toPath().toString();
					File filePath = new File(path, savedName);
					f.transferTo(filePath);
				} catch (Exception e) {
					e.printStackTrace();
				}
				ReviewImageDTO ridto = new ReviewImageDTO();
				ridto.setR_num(r_num);
				ridto.setP_num(rdto.getP_num());
				ridto.setR_ofile(originalName);
				ridto.setR_sfile(savedName);
				
				prdao.insertRImg(ridto);
			}
		}
		return "redirect:/product/productinfo.do?p_num=" + rdto.getP_num();
	}
	
	// 리뷰 추천
	@ResponseBody
	@RequestMapping("/product/doRGood.do")
	public Map<String, String> doReviewGood (HttpServletRequest req) {
		String u_id = req.getParameter("u_id");
		int r_num = Integer.parseInt(req.getParameter("r_num"));
		
		String idchk = prdao.revGoodChk(r_num, u_id);
		
		Map<String, String> response = new HashMap<String, String>();
		
		if (idchk == null || idchk == "") {
			int result = prdao.revGoodPlus(r_num);
			int result2 = prdao.revGoodinsert(r_num, u_id);
			
			if (result == 1 && result2 == 1) {
				response.put("status", "success");
			}
		} else {
			response.put("status", "fail");
		}
		
		return response;
	}
	
	// 리뷰 삭제
	@ResponseBody
	@RequestMapping("/product/deleteReview.do")
	public Map<String, String> deleteReview (HttpServletRequest req) {
		
		int r_num = Integer.parseInt(req.getParameter("r_num"));
		int p_num = Integer.parseInt(req.getParameter("p_num"));
		
		int result = prdao.deleteReview(r_num, p_num);
		
		Map<String, String> response = new HashMap<String, String>();
		
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "fail");
		}
		
		return response;
	}
}
