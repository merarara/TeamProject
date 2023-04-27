package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.PCountVO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PListDao {
	//페이지설정
	public int articlePageDao (@Param("sField") String searchfield, @Param("sWord") String searchword, 
			@Param("type") String type, @Param("selected") String selected);
	
	// 리스트뷰
	public ArrayList<ProductlistDTO> listDao (@Param("nEnd") int nEnd, @Param("nStart") int nStart, 
			@Param("sField") String searchfield, @Param("sWord") String searchword, 
			@Param("type") String type, @Param("selected") String selected);
	
	// 상품 재고 확인
	public List<PCountVO> pCountChkDao (int p_num);
	
	// 상품 상세페이지
	public ProductinfoDTO viewpinfoDao (int p_num);
	
	// 상품 결제 체크
	public String buyCheckDao1 (int p_num, String u_id);
	
	// 상품 결제 체크
	public String buyCheckDao2 (int p_num, String u_id);
	
	// 상품 검색 자동완성
	public List<String> wordSearchShowDao(Map<String, String> paraMap);
	
	// 상품 구매 DB처리
	public int insertOrderDao(OrderinfoDTO OrderinfoDTO);
	
	// 결제 후 scount 증가
	public int update_SCountDao(int p_num);
	
	
}
