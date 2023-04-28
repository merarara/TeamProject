package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.aboard.aboardDTO;

@Mapper 
public interface aboardService {

	public List<aboardDTO> selectA(); 
	public int insertA(aboardDTO aboardDto);
	public aboardDTO selectOneA(String a_num);
	public int updateA(aboardDTO aboardDto);
	public int deleteA(aboardDTO aboardDto);
}