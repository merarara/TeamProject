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
    int selectCount(Map<String, Object> map);
    List<C_BoardDTO> selectListPage(Map<String,Object> map);
    @Select("SELECT * FROM C_BOARD WHERE IDX = #{idx}")
	public C_BoardDTO selectView(@Param("idx") String idx);
    void close();
    
    @Update("UPDATE board SET visitcount = visitcount+1 WHERE idx=#{idx}")
	public void updateVisitCount(@Param("idx") String idx);
    
 public List<C_BoardDTO> selectAll();
    
    public void insertWrite(C_BoardDTO dto);
    
    public void updateBoard(C_BoardDTO dto);
    
    public void deleteBoard(@Param("idx") String idx, @Param("pass") String pass);
    
    public int selectListCount(HashMap<String, Object> hm);
    
    public List<C_BoardDTO> selectPage(HashMap<String, Object> hm);
    
    public List<C_BoardDTO> searchList(HashMap<String, Object> hm);

}
