package com.project.springboot.cboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface C_BoardDAO {
    public List<C_BoardDTO> selectList();
    public C_BoardDTO selectView(int c_num);
    public void updatec_visitcount(int c_num);
    public void insertWrite(C_BoardDTO dto);
    public void updateWrite(C_BoardDTO dto);
    public void deleteWrite(int c_num);
    public int selectCount(Map<String, Object> map);
    public List<C_BoardDTO> selectListPage(Map<String, Object> map);
    
}
