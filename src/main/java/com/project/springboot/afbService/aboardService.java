package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.aboard.aboardDTO;

@Mapper 
public interface aboardService {

	public List<aboardDTO> selectA(int nEnd, int nStart); 
	public int insertA(aboardDTO aboardDto);
	public aboardDTO selectOneA(String a_num);
	public int updateA(aboardDTO aboardDto);
	public int deleteA(String a_num);
	public List<aboardDTO> searchAboard(String searchField, String searchWord);
	
	// 페이지설정
	public int articlePageDao(int curPage);
	// 조회수 증가
	public void updateVisitCount(String a_num);
	// 좋아요 증가
    public void updateLikeCount(String a_num);
    
    public int insertLike(int a_num, String u_id);
    public int deleteLike(String a_num, String u_id);
	public int selectLikeCount(int a_num);
	public Object selectLike(int a_num, String u_id);
	public int deleteLike(int a_num, String u_id);
	public void updateLikeCount(int a_num, int updatedLikeCount);
	
	

}