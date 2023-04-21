package com.project.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ABoard_Comment_Service {
	
	public List<ABoard_Comment_DTO> select2(int a_num);
	public int insert2(ABoard_Comment_DTO aBoardCommentDTO);
	public ABoard_Comment_DTO selectOne2(ABoard_Comment_DTO aBoardCommentDTO);
	public int update2(ABoard_Comment_DTO aBoardCommentDTO);
	public int delete2(int a_num);
}

