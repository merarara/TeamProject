package com.project.springboot.afbService;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.project.springboot.aboard.AupDTO;
import com.project.springboot.aboard.aboardDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public interface IAboardService {
	
	public List<aboardDTO> selectA(int curPage, String searchField, String searchWord);
	public int insertA(aboardDTO aboardDto);
	public aboardDTO selectOneA(String a_num);
	public int updateA(aboardDTO aboardDto);
	public int deleteA(Map<String, Object> params);
	
	// 페이지설정
	public BpageInfo articlePage(int curPage, String searchField, String searchWord);
	// 조회수 증가
	void updateVisitCount(String a_num);
	
	public int addLike(int a_num, String u_id);
	public int removeLike(int a_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(int a_num);
	aboardDTO getAboard(int a_num);
	
	public int upload(AupDTO aupDto);
	public int uploadnum(aboardDTO aboardDto);
	public List<AupDTO> uploadview(int a_num);
	public int deleteFile(int a_num, String sfile);
	public int deleteFileAll(String a_num);
	public int deleteAcAll(String a_num);
	
	public boolean checkLike(int a_num, String u_id);
	int selectLikeCount(@Param("a_num") int a_num, @Param("u_id") String u_id);
	
	public String alCheck(String a_num, String u_id);
	
}
