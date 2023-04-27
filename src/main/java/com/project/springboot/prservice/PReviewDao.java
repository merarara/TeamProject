package com.project.springboot.prservice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

@Mapper
public interface PReviewDao {
	// 리뷰 글작성
	public int insertReviewDao(ReviewDTO rdto);
	
	// 리뷰 글작성 이미지 저장
	public int insertRImgDao(ReviewImageDTO ridto);
	
	// 리뷰 번호 추적
	public int checkRnumDao(int p_num, String u_id);
	
	// 리뷰 가져오기
	public List<ReviewDTO> getReviewDao (int p_num);
	
	// 리뷰 이미지
	public List<ReviewImageDTO> getRevImgDao (int p_num);
	
	// 리뷰 좋아요 체크
	public String revGoodChkDao (int r_num, String u_id);
	
	// 리뷰 좋아요 증가
	public int revGoodPlusDao (int r_num);
	
	// 리뷰 좋아요 저장
	public int revGoodinsertDao (int r_num, String u_id);
	
	// 리뷰 별점 갱신
	public int revGoodUpdateDao (int p_num);
}
