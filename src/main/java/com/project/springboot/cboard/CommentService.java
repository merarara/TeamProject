package com.project.springboot.cboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.aboard.ACommentDTO;
import com.project.springboot.aboard.aboardDTO;

@Mapper
public interface CommentService {
	
	public List<CommentDTO> selectC(int nEnd, int nStart);
    public int insertC(CommentDTO cDto);
    public int updateC(CommentDTO cDto);
    public int deleteC(int c_num);
    
    // 페이지설정
 	public int articlePageDao(@Param("curPage") int curPage);
    
	public int insertLike(@Param("cc_num") int c_num, @Param("u_id") String u_id);
	public int deleteLike(@Param("cc_num") int c_num, @Param("u_id") String u_id);
	
    // 좋아요 수 가져오기
 	public int getLikeCount(@Param("cc_num") int cc_num);
 	
 	CommentDTO getComment(int cc_num);

}
