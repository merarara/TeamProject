package com.project.springboot.cboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper 
public interface cboardService {

	public List<cboardDTO> select(int nEnd, int nStart); 
	public int insert(cboardDTO cboardDto);
	public cboardDTO selectOne(String a_num);
	public int update(cboardDTO cboardDto);
	public int delete(String a_num);
	public List<cboardDTO> searchboard(String searchField, String searchWord);
	
	// 페이지설정
	public int articlePageDao(int curPage);
	// 조회수 증가
	public void updateVisitCount(String a_num);
	// 좋아요 증가
    public void updateLikeCount(String a_num);
    
    public int insertLike(int a_num, String u_id);
    public int deleteLike(String a_num, String u_id);
	public int selectLikeCount(int a_num);
	public Object selectLike(int a_num, String u_id);
	public int deleteLike(int a_num, String u_id);
	public void updateLikeCount(int a_num, int updatedLikeCount);
	
	

}