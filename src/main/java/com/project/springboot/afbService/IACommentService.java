package com.project.springboot.afbService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.aboard.ACommentDTO;
import com.project.springboot.aboard.AupDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public interface IACommentService {
	
	public List<ACommentDTO> selectAnum(String a_num);
	public List<ACommentDTO> selectAC(int a_num, String ac_num);
    public int insertAC(ACommentDTO acDto);
    public int updateAC(ACommentDTO acDto);
    public int deleteAC(String c_num);
    
    // 페이지설정
 	public BpageInfo articlePage(int curPage);
 	
 	public int addLike(int a_num, String u_id);
	public int removeLike(int a_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(int ac_num);
	ACommentDTO getAComment(int ac_num);

}
