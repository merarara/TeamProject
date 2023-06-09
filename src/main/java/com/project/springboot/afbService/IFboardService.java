package com.project.springboot.afbService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.fboard.fboardDTO;

@Service
public interface IFboardService {
	public List<fboardDTO> selectF(int curPage, String searchField, String searchWord);
	public int insertF(fboardDTO fboardDto);
	public fboardDTO selectOneF(String f_num);
	public int updateF(fboardDTO fboardDto);
	public int deleteF(fboardDTO fboardDto); 
	
	// 페이지설정
	public BpageInfo articlePage(int curPage, String searchField, String searchWord);
}
