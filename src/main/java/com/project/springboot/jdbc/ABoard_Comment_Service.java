package com.project.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ABoard_Comment_Service {
	
	public List<ABoard_DTO> select();
	public int insert(ABoard_DTO aBoardDTO);
	public ABoard_DTO selectOne(ABoard_DTO aBoardDTO);
	public int update(ABoard_DTO aBoardDTO);
	public int delete(int a_num);
}

