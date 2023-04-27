package com.project.springboot.cservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.cboard.*;

@Service
public class C_ReplyServiceImpl implements C_ReplyService {

	@Autowired
	private C_ReplyDAO dao;
	
	// 댓글 조회
	@Override
	public List<C_ReplyVO> list(int c_num) throws Exception {
		return dao.list(c_num);
	}

	// 댓글 작성
	@Override
	public void write(C_ReplyVO vo) throws Exception {
		dao.write(vo);
	}

	// 댓글 수정
	@Override
	public void modify(C_ReplyVO vo) throws Exception {
		dao.modify(vo);
	}

	// 댓글 삭재
	@Override
	public void delete(C_ReplyVO vo) throws Exception {
		dao.delete(vo);
	}

	
	// 단일 댓글 조회
	@Override
	public C_ReplyVO replySelect(C_ReplyVO vo) throws Exception {
		return dao.replySelect(vo);
	}

}
