package com.project.springboot.cboard;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public interface IboardService {
	
	public List<cboardDTO> select(int curPage, String searchField, String searchWord); 
	public int insert(cboardDTO cboardDto);
	public cboardDTO selectOne(String c_num);
	public int update(cboardDTO cboardDto, MultipartFile[] file);
	public int delete(String c_num);
	
	// 페이지설정
	public BpageInfo articlePage(int curPage, String searchField, String searchWord);
	// 조회수 증가
	void updateVisitCount(String c_num);
	
	
	// 좋아요 수 가져오기
	public int getLikeCount(int c_num);
	cboardDTO getCboard(int c_num);
    
	public int upload(upDTO upDto);
	public int uploadnum(cboardDTO cboardDto);
	public List<upDTO> uploadview(int c_num);
	List<upDTO> getUploadList(int c_num);
	void updateCBoard(cboardDTO cboardDto);
	public List<upDTO> getFile(int parseInt);
	int update(cboardDTO cboardDto);
	public boolean checkLiked(int c_num, String u_id);
	int insertLike(int c_num, String u_id);
	public int deleteFile(int c_num, String sfile);
	public int deleteFileAll(String c_num);
	public int deleteAll(String c_num);
	public boolean checkLike(int c_num, String u_id);
	int selectLikeCount(@Param("c_num") int c_num, @Param("u_id") String u_id);
	void addlike(int c_like);
	void minlike(int c_like);
	public cboardDTO selectOne(int c_num);
}
