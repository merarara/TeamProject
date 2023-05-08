package com.project.springboot.cboard;

import java.util.List;

public interface ReplyDAO {

	// 댓글 조회
	public List<ReplyVO> list(int c_num) throws Exception;
	
	// 댓글 조회
	public void write(ReplyVO vo) throws Exception;
	
	// 댓글 수정
	public void modify(ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void delete(ReplyVO vo) throws Exception;
	

	// 단일 댓글 조회
	public ReplyVO replySelect(ReplyVO vo) throws Exception;
}
