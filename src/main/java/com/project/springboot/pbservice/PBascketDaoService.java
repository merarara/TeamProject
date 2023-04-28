package com.project.springboot.pbservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.productdto.BascketOrderDTO;
import com.project.springboot.productdto.ProductBascketDTO;

@Service
public class PBascketDaoService implements IPBascketDaoService {
	
	@Autowired 
	PBascketDao dao;
	
	// 장바구니 추가
	@Override
	public int add_bascket(ProductBascketDTO bascketDTO) {
		int result = dao.add_bascketDao(bascketDTO);
		
		return result;
	}
	
	// 장바구니 목록 가져오기
	@Override
	public List<ProductBascketDTO> get_bascketList(String u_id) {
		List<ProductBascketDTO> bascketlist = dao.get_bascketListDao(u_id);
		
		return bascketlist;
	}
	
	// 장바구니 삭제
	@Override
	public int deleteBascket(int b_num) {
		int result = dao.deleteBascketDao(b_num);
		
		return result;
	}
	
	// 장바구니 결제
	@Override
	public int insertBOrder(BascketOrderDTO bOrderDTO) {
		int result = dao.insertBOrderDao(bOrderDTO);
		
		return result;
	}
	
	// O_Num 체크
	@Override
	public String checkO_Num(String u_id) {
		String result = dao.checkO_NumDao(u_id);
		
		return result;
	}
	
	// 장바구니 결제 상세 DB처리
	@Override
	public int insertBOinfo(String o_num, String u_id, String p_num, String p_name, String p_price, String bo_qty) {
		int result = dao.insertBOinfoDao(o_num, u_id, p_num, p_name, p_price, bo_qty);
		return result;
	}
	
	// 장바구니 결제 후 삭제
	@Override
	public int deleteABascket(String u_id) {
		int result = dao.deleteABascketDao(u_id);
		
		return result;
	}
}
