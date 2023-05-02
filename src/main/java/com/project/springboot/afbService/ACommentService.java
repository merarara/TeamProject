package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.aboard.ACommentDTO;

@Mapper
public interface ACommentService {
	
	public List<ACommentDTO> getCommentList(int a_num);
    public void writeComment(ACommentDTO acDto);
    public void modifyComment(ACommentDTO acDto);
    public void deleteComment(int c_num);

}
