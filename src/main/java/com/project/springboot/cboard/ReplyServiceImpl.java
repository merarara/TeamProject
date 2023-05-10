package com.project.springboot.cboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO dao;
	
	// 댓글 조회
	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		return dao.list(bno);
	}

	// 댓글 작성
	@Override
	public void write(ReplyVO vo) throws Exception {
		dao.write(vo);
	}

	// 댓글 수정
	@Override
	public void modify(ReplyVO vo) throws Exception {
		dao.modify(vo);
	}

	// 댓글 삭재
	@Override
	public void delete(ReplyVO vo) throws Exception {
		dao.delete(vo);
	}

	
	// 단일 댓글 조회
	@Override
	public ReplyVO replySelect(ReplyVO vo) throws Exception {
		return dao.replySelect(vo);
	}

	@Override
	public List<ReplyVO> list(String c_num) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int delete(int c_num, int c_rno) {
		// TODO Auto-generated method stub
		return 0;
	}

}
