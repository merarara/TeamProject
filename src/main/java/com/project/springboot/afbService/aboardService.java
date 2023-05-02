package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	
	public int insertLike(@Param("a_num") int a_num, @Param("u_id") String u_id) ;
	public int deleteLike(@Param("a_num") int a_num, @Param("u_id") String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(@Param("a_num") int a_num);
	
	aboardDTO getAboard(int a_num);

}