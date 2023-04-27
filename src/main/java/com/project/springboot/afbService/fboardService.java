package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.fboard.fboardDTO;

@Mapper
public interface fboardService {
	
	public List<fboardDTO> selectF();
	public int insertF(fboardDTO fboardDto);
	public fboardDTO selectOneF(String f_num);
	public int updateF(fboardDTO fboardDto);
	public int deleteF(fboardDTO fboardDto); 
	
	// 페이지네이션 기능을 위한 메서드
	public List<fboardDTO> selectFboardListByRange(@Param("startRow") int startRow, @Param("endRow") int endRow);
    public int selectCount();
    public int selectCountWithKeyword(String keyword);
    public List<fboardDTO> selectFboardListByRangeWithKeyword(int startRow, int endRow, String keyword);
    public int selectCountByKeyword(String searchKeyword, String searchType);
    List<fboardDTO> selectFboardListByKeywordAndRange(String searchKeyword, String searchType, int startRow, int endRow);
    
}
