package com.project.springboot.afbService;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
	// 조회수 증가
	void updateVisitCount(String a_num);
	
	public int addLike(int a_num, String u_id);
	public int removeLike(int a_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(int a_num);
	aboardDTO getAboard(int a_num);
}
