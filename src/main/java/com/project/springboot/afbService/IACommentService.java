package com.project.springboot.afbService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.aboard.ACommentDTO;

@Service
public interface IACommentService {
	public List<ACommentDTO> getCommentList(int a_num);
    public void writeComment(ACommentDTO acDto);
    public void modifyComment(ACommentDTO acDto);
    public void deleteComment(int c_num);

}
