package com.project.springboot.cboard;

import java.util.List;

public interface ReplyService {
	
	// 댓글 조회
	public List<ReplyVO> list(int c_num) throws Exception;
	
	// 댓글 작성
	public void write(ReplyVO vo) throws Exception;
	
	// 댓글 수정
	public void modify(ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void delete(ReplyVO vo) throws Exception;
	

	// 단일 댓글 조회
	public ReplyVO replySelect(ReplyVO vo) throws Exception;

	public List<ReplyVO> list(String c_num);

	public int delete(int c_num, int c_rno);


}
