package com.project.springboot.prservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
