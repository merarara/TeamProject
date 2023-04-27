package com.project.springboot.prservice;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

@Service
public interface IPReviewDaoService {
	// 리뷰 글 쓰기
	public int insertReview(ReviewDTO rdto);
	
	// 리뷰 글 이미지 저장
	public int insertRImg(ReviewImageDTO ridto);
	
	// 리뷰 번호 추적
	public int checkRnum(int p_num, String u_id);
	
	// 리뷰 가져오기
	public List<ReviewDTO> GetReview(int p_num);
	
	// 리뷰 이미지 가져오기
	public List<ReviewImageDTO> getRevImgDao(int p_num);
}
