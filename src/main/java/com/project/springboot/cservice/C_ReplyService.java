package com.project.springboot.cservice;

import java.util.List;

import com.project.springboot.cboard.*;

public interface C_ReplyService {
	
	// 댓글 조회
	public List<C_ReplyVO> list(int c_rno) throws Exception;
	
	// 댓글 작성
	public void write(C_ReplyVO vo) throws Exception;
	
	// 댓글 수정
	public void modify(C_ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void delete(C_ReplyVO vo) throws Exception;
	

	// 단일 댓글 조회
	public C_ReplyVO replySelect(C_ReplyVO vo) throws Exception;

	public List<C_ReplyVO> replyList(int c_num) throws Exception;

}
