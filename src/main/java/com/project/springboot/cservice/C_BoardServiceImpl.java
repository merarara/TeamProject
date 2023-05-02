package com.project.springboot.cservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.cboard.C_BoardDAO;
import com.project.springboot.cboard.C_BoardVO;

@Service
public class C_BoardServiceImpl implements C_BoardService {

	@Autowired
	private C_BoardDAO dao;
	
	
	// 게시물 목록
	@Override
	public List<C_BoardVO> list() throws Exception {

		return dao.list();
	}

	// 게시물 작성
	@Override
	public void write(C_BoardVO vo) throws Exception {
		
		dao.write(vo);
	}

	// 게시물 조회
	@Override
	public C_BoardVO view(int c_num) throws Exception {

		return dao.view(c_num);
	}

	// 게시물 수정
	@Override
	public void modify(C_BoardVO vo) throws Exception {
		
		dao.modify(vo);
	}

	// 게시물 삭제
	@Override
	public void delete(int c_num) throws Exception {
		dao.delete(c_num);
	}

	
	
	// 게시물 총 갯수
	@Override
	public int count() throws Exception {
		return dao.count();
	}

	
	
	// 게시물 목록 + 페이징
	@Override
	public List<C_BoardVO> listPage(int displayPost, int postNum) throws Exception {
		return dao.listPage(displayPost, postNum);
	}

	
	
	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<C_BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception {
		return  dao.listPageSearch(displayPost, postNum, searchType, keyword);
	}
	
	// 게시물 총 갯수
	@Override
	public int searchCount(String searchType, String keyword) throws Exception {
		return dao.searchCount(searchType, keyword);
	}
	
	@Override
	public void updateVisitCount(int c_num) {
	    return;
	}

	@Override
	public void c_sfile(C_BoardVO vo) throws Exception {
	    dao.c_sfile(vo);
	}

	@Override
	public String c_sfile(int c_num) throws Exception
	{
		return null;
	}

	

}
