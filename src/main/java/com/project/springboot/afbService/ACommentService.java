package com.project.springboot.afbService;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.aboard.ACommentDTO;
import com.project.springboot.aboard.aboardDTO;

@Mapper
public interface ACommentService {
	
	public List<ACommentDTO> selectAC(int nEnd, int nStart);
    public int insertAC(ACommentDTO acDto);
    public int updateAC(ACommentDTO acDto);
    public int deleteAC(int ac_num);
    
    // 페이지설정
 	public int articlePageDao(@Param("curPage") int curPage);
    
	public int insertLike(@Param("ac_num") int a_num, @Param("u_id") String u_id);
	public int deleteLike(@Param("ac_num") int a_num, @Param("u_id") String u_id);
	
    // 좋아요 수 가져오기
 	public int getLikeCount(@Param("ac_num") int ac_num);
 	
 	ACommentDTO getAComment(int ac_num);

}
