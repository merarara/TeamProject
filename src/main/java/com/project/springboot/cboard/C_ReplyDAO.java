package com.project.springboot.cboard;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

public interface C_ReplyDAO {

	// 댓글 조회
	public List<C_ReplyVO> list(int c_num) throws Exception;
	
	// 댓글 조회
	public void write(C_ReplyVO vo) throws Exception;
	
	// 댓글 수정
	public void modify(C_ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void delete(C_ReplyVO vo) throws Exception;
	

	// 단일 댓글 조회
	public C_ReplyVO replySelect(C_ReplyVO vo) throws Exception;

	public List<C_ReplyVO> replyList(int c_num) throws Exception;
}
