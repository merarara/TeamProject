package com.project.springboot.cboard;

import java.util.List;



public interface C_BoardDAO {
	
	// 게시물 목록
	public List<C_BoardVO> list() throws Exception;
	
	// 게시물 작성
	public void write(C_BoardVO vo) throws Exception;

	// 게시물 조회
	public C_BoardVO view(int c_num) throws Exception;
	
	// 게시물 수정
	public void modify(C_BoardVO vo) throws Exception;
	
	// 게시뮬 삭제
	public void delete(int c_num) throws Exception;

	
	
	// 게시물 총 갯수
	public int count() throws Exception;	

	
	
	// 게시물 목록 + 페이징
	public List<C_BoardVO> listPage(int displayPost, int postNum) throws Exception;
	
	
	
	// 게시물 목록 + 페이징 + 검색
	public List<C_BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	// 게시물 총 갯수 + 검색 적용
	public int searchCount(String searchType, String keyword) throws Exception;
	//조회수증가
	public static void updateVisitCount(int c_num) {}

	public void c_sfile(C_BoardVO vo);
	
	
	
		
		
}
