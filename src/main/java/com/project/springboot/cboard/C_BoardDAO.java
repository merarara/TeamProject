package com.project.springboot.cboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface C_BoardDAO {
    
    Object insertWrite = null;

	List<C_BoardDTO> selectListPage(Map<String,Object> map);
    @Select("SELECT * FROM C_BOARD WHERE c_num = #{c_num}")
	public C_BoardDTO selectView(@Param("c_num") String c_num);
    
    
    @Update("UPDATE board SET C_visitcount = C_visitcount+1 WHERE c_num=#{c_num}")
	public void updateVisitCount(@Param("c_num") String c_num);
    
    public List<C_BoardDTO> selectAll();
    
 	public int selectCount(Map<String, Object> map);
    
 	public void insertWrite(C_BoardDTO dto);
    
    public void updateBoard(C_BoardDTO dto);
    
    public void deleteBoard(@Param("c_num") String c_num, @Param("C_pass") String c_pass);
    
    public int selectListCount(HashMap<String, Object> hm);
    
    public List<C_BoardDTO> selectPage(HashMap<String, Object> hm);
    
    public List<C_BoardDTO> searchList(HashMap<String, Object> hm);

}
