package com.project.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

/*
컨트롤러와 매퍼(XML파일) 사이에서 매개역할을 하는 서비스 인터페이스로
JdbcTemplate에서는 @Service를 사용했지만 마이바티스에서는 @Mapper를 
사용한다. 
 */
@Mapper
public interface FBoard_Service {
	
	public List<FBoard_DTO> select();
	public int insert(FBoard_DTO fBoardDTO);
	public FBoard_DTO selectOne(FBoard_DTO fBoardDTO);
	public int update(FBoard_DTO fBoardDTO);
	public int delete(int f_num);
}
