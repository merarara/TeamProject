package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.fboard.fboardDTO;

@Mapper
public interface fboardService {
	
	public List<fboardDTO> selectF(int nEnd, int nStart);
	public int insertF(fboardDTO fboardDto);
	public fboardDTO selectOneF(String f_num);
	public int updateF(fboardDTO fboardDto);
	public int deleteF(fboardDTO fboardDto); 
	
	public List<fboardDTO> searchFboard(String searchField, String searchWord);
	
	// 페이지설정
	public int articlePageDao(int curPage);
}