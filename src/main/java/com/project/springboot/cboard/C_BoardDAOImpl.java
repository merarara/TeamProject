package com.project.springboot.cboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class C_BoardDAOImpl implements C_BoardDAO {

	@Autowired 
	private SqlSession sql;
	
	private static String namespace = "com.project.springboot.cboard";

	// 게시물 목록
	@Override
	public List<C_BoardVO> list() throws Exception {	
		
		return sql.selectList(namespace + ".list");
	}

	// 게시물작성
	@Override
	public void write(C_BoardVO vo) throws Exception {
	    sql.insert(namespace + ".write", vo);
	}


	// 게시물 조회
	@Override
	public C_BoardVO view(int bno) throws Exception {
	
		return sql.selectOne(namespace + ".view", bno);
	}

	// 게시물 수정
	@Override
	public void modify(C_BoardVO vo) throws Exception {
		sql.update(namespace + ".modify", vo);
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		sql.delete(namespace + ".delete", bno);
	}

	
	
	// 게시물 총 갯수
	@Override
	public int count() throws Exception {
		return sql.selectOne(namespace + ".count");	
	}

	
	
	// 게시물 목록 + 페이징
	@Override
	public List<C_BoardVO> listPage(int displayPost, int postNum) throws Exception {

		HashMap<String, Integer> data = new HashMap<String, Integer>();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		return sql.selectList(namespace + ".listPage", data);
	}

	
	
	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<C_BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception {

		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		data.put("searchType", searchType);
		data.put("keyword", keyword);
		
		return sql.selectList(namespace + ".listPageSearch", data);
	}
	
	// 게시물 총 갯수 + 검색 적용
	@Override
	public int searchCount(String searchType, String keyword) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("searchType", searchType);
		data.put("keyword", keyword);
		
		return sql.selectOne(namespace + ".searchCount", data);	
	}

		

}
