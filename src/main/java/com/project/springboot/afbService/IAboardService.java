package com.project.springboot.afbService;

import java.util.List;
import java.util.Map;

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
	void updateVisitCount(String a_num);
	Map<String, Object> toggleLike(int a_num, String u_id);
	
	public void updateLikeCount(int a_num, int updatedLikeCount); 
	public int insertLike(int a_num, String u_id);
    public int selectLikeCount(int a_num);
    public Object selectLike(int a_num, String u_id);
	public int deleteLike(int a_num, String u_id);
    
    
	
}
