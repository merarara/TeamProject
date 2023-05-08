package com.project.springboot.pbservice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;

@Mapper
public interface PBascketDao {
	// 장바구니 추가
	public int add_bascketDao(ProductBascketDTO bascketDTO);
	
	// 장바구니 목록 가져오기
	public List<ProductBascketDTO> get_bascketListDao(String u_id);
	
	// 장바구니 삭제
	public int deleteBascketDao(int b_num);
	
	// 상품 구매 DB처리
	public int insertOrderDao(OrderinfoDTO OrderinfoDTO);
	
	// 장바구니 결제 상세 O_Num 확인
	public String checkM_NumDao(String u_id);
	
	// 장바구니 결제 상세
	public int insertBOinfoDao(@Param("m_num") String m_num, @Param("u_id") String u_id, @Param("u_nick") String u_nick, @Param("p_num") String p_num, 
			@Param("p_name") String p_name, @Param("p_price") String p_price, @Param("bo_qty") String bo_qty);
	
	// 장바구니 결제 후 삭제
	public int deleteABascketDao(String u_id);
}
