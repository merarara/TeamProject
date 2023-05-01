package com.project.springboot.prservice;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

@Service
public class PReviewDaoService implements IPReviewDaoService {
	
	@Autowired
	PReviewDao dao;
	
	// 리뷰 글쓰기
	@Override
	public int insertReview(ReviewDTO rdto) {
		int result = dao.insertReviewDao(rdto);
		return result;
	}
	
	// 리뷰 이미지 넣기
	@Override
	public int insertRImg(ReviewImageDTO ridto) {
		int result = dao.insertRImgDao(ridto);
		return result;
	}
	
	// 리뷰번호 추적
	@Override
	public int checkRnum(int p_num, String u_id) {
		int r_num = dao.checkRnumDao(p_num, u_id);
		return r_num;
	}
	
	// 리뷰 가져오기
	@Override
	public List<ReviewDTO> GetReview(int p_num) {
		List<ReviewDTO> rdto = dao.getReviewDao(p_num);
		return rdto;
	}
	
	// 리뷰 이미지 가져오기
	@Override
	public List<ReviewImageDTO> getRevImgDao(int p_num) {
		List<ReviewImageDTO> ridto = dao.getRevImgDao(p_num);
		
		return ridto;
	}
	
	// 리뷰 좋아요 체크
	@Override
	public String revGoodChk(int r_num, String u_id) {
		String idchk = dao.revGoodChkDao(r_num, u_id);
		
		return idchk;
	}
	
	// 리뷰 좋아요 증가
	@Override
	public int revGoodPlus(int r_num) {
		int result = dao.revGoodPlusDao(r_num);
		
		return result;
	}
	
	@Override
	public int revGoodinsert(int r_num, String u_id) {
		int result2 = dao.revGoodinsertDao(r_num, u_id);
		
		return result2;
	}
	
	@Override
	public int revGoodUpdate(int p_num) {
		int result = dao.revGoodUpdateDao(p_num);
		
		return result;
	}
	
	@Override
	public int deleteReview (int r_num, int p_num) {
		List<String> img = dao.getImageNameDao(r_num, p_num);
		
		try {
			for (String e: img) {
				String path = ResourceUtils.getFile("classpath:static/revuploads/")
						.toPath().toString();
				File filePath = new File(path, e);
				
				if(filePath.exists()) {
					filePath.delete();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int result1 = dao.deleteRevImgDao(r_num, p_num);
		int result2 = dao.deleteReviewDao(r_num, p_num);
		
		return result2;
	}
}
