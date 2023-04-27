package com.project.springboot.pbservice;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.productdto.BascketOrderDTO;
import com.project.springboot.productdto.ProductBascketDTO;

@Service
public interface IPBascketDaoService {
	// 장바구니 추가
	public int add_bascket(ProductBascketDTO bascketDTO);
	
	// 장바구니 목록 가져오기
	public List<ProductBascketDTO> get_bascketList(String u_id);
	
	// 장바구니 삭제
	public int deleteBascket(int b_num);
	
	// 장바구니 결제
	public int insertBOrder(BascketOrderDTO bOrderDTO);
	
	// 장바구니 결제 상세 O_Num 확인
	public String checkO_Num(String u_id);
	
	// 장바구니 결제 상세
	public int insertBOinfo(String o_num, String u_id, String p_num, String p_name, String p_price, String bo_qty);
	
	// 장바구니 결제 후 삭제
	public int deleteABascket(String u_id);
}
