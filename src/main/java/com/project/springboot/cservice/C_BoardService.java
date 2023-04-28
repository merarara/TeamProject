package com.project.springboot.cservice;

import java.util.List;

import com.project.springboot.cboard.*;

public interface C_BoardService {

	// 게시물 목록
	public List<C_BoardVO> list() throws Exception;
	
	// 게시물 작성
	public void write(C_BoardVO vo) throws Exception;

	// 게시물 조회
	public C_BoardVO view(int bno) throws Exception;

	// 게시물 수정
	public void modify(C_BoardVO vo) throws Exception;
	
	// 게시물 삭제
	public void delete(int bno) throws Exception;
	
	
	
	// 게시물 총 갯수
	public int count() throws Exception;

	
	
	// 게시물 목록 + 페이징
	public List<C_BoardVO> listPage(int displayPost, int postNum) throws Exception;
	
	
	
	// 게시물 목록 + 페이징 + 검색
	public List<C_BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	// 게시물 총 갯수 + 검색 적용
	public int searchCount(String searchType, String keyword) throws Exception;
	
	//조회수 증가
	public void updateVisitCount(int c_num);
}