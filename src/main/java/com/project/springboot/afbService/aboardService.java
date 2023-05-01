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
	public void updateVisitCount(String a_num);
}