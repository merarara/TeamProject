package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.fboard.fboardDTO;

@Mapper
public interface fboardService {
	
	public List<fboardDTO> selectF(
			@Param("nEnd") int nEnd, 
			@Param("nStart") int nStart, 
			@Param("searchField") String searchField, 
			@Param("searchWord") String searchWord);
	public int insertF(fboardDTO fboardDto);
	public fboardDTO selectOneF(String f_num);
	public int updateF(fboardDTO fboardDto);
	public int deleteF(fboardDTO fboardDto); 
	
	
	// 페이지설정
	public int articlePageDao(
			@Param("curPage") int curPage, 
			@Param("searchField") String searchField, 
			@Param("searchWord") String searchWord);
}