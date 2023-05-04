package com.project.springboot.cboard;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.aboard.ACommentDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public interface ICommentService {
	public List<CommentDTO> selectC(int curPage);
    public int insertC(CommentDTO ccDto);
    public int updateC(CommentDTO ccDto);
    public int deleteC(String c_num);
    
    // 페이지설정
 	public BpageInfo articlePage(int curPage);
 	
 	public int addLike(int c_num, String u_id);
	public int removeLike(int c_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(int cc_num);
	CommentDTO getComment(int cc_num);

}
