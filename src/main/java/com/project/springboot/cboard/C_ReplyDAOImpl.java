package com.project.springboot.cboard;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class C_ReplyDAOImpl implements C_ReplyDAO {
	
	@Autowired
	private SqlSession sql;
	
	private static String namespace = "com.project.springboot.cboard";

	// 댓글 조회
	@Override
	public List<C_ReplyVO> list(int c_num) throws Exception {
		return sql.selectList(namespace + ".replyList", c_num);
	}

	// 댓글 작성
	@Override
	public void write(C_ReplyVO vo) throws Exception {
		sql.insert(namespace + ".replyWrite", vo);
	}

	// 댓글 수정
	@Override
	public void modify(C_ReplyVO vo) throws Exception {
		sql.update(namespace + ".replyModify", vo);
	}

	// 댓글 삭제
	@Override
	public void delete(C_ReplyVO vo) throws Exception {
		sql.delete(namespace + ".replyDelete", vo);
	}

	
	// 단일 댓글 조회
	@Override
	public C_ReplyVO replySelect(C_ReplyVO vo) throws Exception {
		
		return sql.selectOne(namespace + ".replySelect", vo);
	}

}
