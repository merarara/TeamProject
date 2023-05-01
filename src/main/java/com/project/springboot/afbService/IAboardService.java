package com.project.springboot.afbService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.aboard.aboardDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public interface IAboardService {
	public List<aboardDTO> selectA(int curPage); 
	public int insertA(aboardDTO aboardDto);
	public aboardDTO selectOneA(String a_num);
	public int updateA(aboardDTO aboardDto);
	public int deleteA(String a_num);
	public List<aboardDTO> searchAboard(String searchField, String searchWord);
	
	// 페이지설정
	public BpageInfo articlePage(int curPage);
	
}
