package com.project.springboot.afbService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.fboard.fboardDTO;
import com.project.springboot.fboard.fboardDTO;

@Mapper
public interface fboardService {
	
	public List<fboardDTO> selectF();
	public int insertF(fboardDTO fboardDto);
	public fboardDTO selectOneF(String f_num);
	public int updateF(fboardDTO fboardDto);
	public int deleteF(fboardDTO fboardDto); 
	
	public List<fboardDTO> searchFboard(String searchField, String searchWord);
}