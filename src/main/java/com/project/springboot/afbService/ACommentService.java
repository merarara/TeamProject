package com.project.springboot.afbService;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.aboard.ACommentDTO;

@Mapper
public interface ACommentService {

	public List<ACommentDTO> selectAnum(String a_num);
	public List<ACommentDTO> selectAC(int a_num, String ac_num);
    public int insertAC(ACommentDTO acDto);
    public int updateAC(ACommentDTO acDto);
    public int deleteAC(Map<String, Object> params);
    public ACommentDTO getAC(String u_id, int ac_num);
    
    // 페이지설정
 	public int articlePageDao(@Param("curPage") int curPage);
    
	public int insertAcLike(@Param("ac_num") int a_num, @Param("u_id") String u_id);
	public int deleteAcLike(@Param("ac_num") int a_num, @Param("u_id") String u_id);
	
    // 좋아요 수 가져오기
 	public int getAcLikeCount(@Param("ac_num") int ac_num);
 	
 	ACommentDTO getAComment(int ac_num);

}
