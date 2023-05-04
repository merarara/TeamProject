package com.project.springboot.cboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper 
public interface cboardService {

	public List<cboardDTO> select(
			@Param("nEnd") int nEnd, 
			@Param("nStart") int nStart, 
			@Param("searchField") String searchField, 
			@Param("searchWord") String searchWord); 
	public int insert(cboardDTO cboardDto);
	public cboardDTO selectOne(String c_num);
	public int update(cboardDTO cboardDto);
	public int delete(String c_num);
	
	// 페이지설정
	public int articlePageDao(
			@Param("curPage") int curPage, 
			@Param("searchField") String searchField, 
			@Param("searchWord") String searchWord);
	// 조회수 증가
	public void updateVisitCount(String c_num);
	// 좋아요 증가
	public int insertLike(@Param("c_num") int c_num, @Param("u_id") String u_id);
	public int deleteLike(@Param("c_num") int c_num, @Param("u_id") String u_id);
    
    public int addLike(int c_num, String u_id);
	public int removeLike(int c_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(@Param("c_num") int c_num);
	
	cboardDTO getCboard(int c_num);
	
	

}