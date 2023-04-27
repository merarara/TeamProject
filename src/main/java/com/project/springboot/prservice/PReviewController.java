package com.project.springboot.prservice;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

@Controller
public class PReviewController {
	
	@Autowired
	IPReviewDaoService prdao;
	
	// 상품 리뷰 글
	@RequestMapping(value="/product/reviewUpload.do", method=RequestMethod.POST)
	public String reviewUpload(MultipartFile[] review_file, ReviewDTO rdto,
			MultipartHttpServletRequest req) {
		String path = "";
		
		int ireview = prdao.insertReview(rdto);
		
		int r_num = prdao.checkRnum(rdto.getP_num(), rdto.getU_id());
		
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
		
		return "redirect:/product/productinfo.do?p_num=" + rdto.getP_num();
	}
}
