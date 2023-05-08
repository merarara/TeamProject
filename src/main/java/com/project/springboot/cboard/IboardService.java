package com.project.springboot.cboard;

import java.util.Enumeration;
import java.util.List;

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
	
	public int addLike(int c_num, String u_id);
	public int removeLike(int c_num, String u_id);
	
	// 좋아요 수 가져오기
	public int getLikeCount(int c_num);
	cboardDTO getCboard(int c_num);
    
	public int upload(upDTO upDto);
	public int uploadnum(cboardDTO cboardDto);
	public List<upDTO> uploadview(int c_num);
	List<upDTO> getUploadList(int c_num);
	void deleteUploadBySfile(Enumeration<String> enumeration, MultipartFile[] file);
	public void deleteUploadBySfile(int i);
	void updateCBoard(cboardDTO cboardDto);
	void deleteUploadBySfile(int c_num, List<String> sfiles);
	public List<upDTO> getFile(int parseInt);
	public void deleteUploadBySfile(String sfile);
	int update(cboardDTO cboardDto);
	public boolean checkLiked(int c_num, String u_id);

}
