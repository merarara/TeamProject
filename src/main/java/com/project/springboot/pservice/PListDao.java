package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.BascketOrderDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;
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
	
	// 상품 상세페이지
	public ProductinfoDTO viewpinfoDao (int p_num);
	
	// 상품 검색 자동완성
	public List<String> wordSearchShowDao(Map<String, String> paraMap);
	
	// 상품 구매 DB처리
	public int insertOrderDao(OrderinfoDTO OrderinfoDTO);
	
	// 장바구니 추가
	public int add_bascketDao(ProductBascketDTO bascketDTO);
	
	// 장바구니 목록 가져오기
	public List<ProductBascketDTO> get_bascketListDao(String u_id);
	
	// 장바구니 삭제
	public int deleteBascketDao(int b_num);
	
	// 장바구니 결제
	public int insertBOrderDao(BascketOrderDTO bOrderDTO);
	
	// 장바구니 결제 상세 O_Num 확인
	public String checkO_NumDao(String u_id);
	
	// 장바구니 결제 상세
	public int insertBOinfoDao(@Param("o_num") String o_num, @Param("u_id") String u_id, @Param("p_num") String p_num, 
			@Param("p_name") String p_name, @Param("p_price") String p_price, @Param("bo_qty") String bo_qty);
	
	// 장바구니 결제 후 삭제
	public int deleteABascketDao(String u_id);
}
