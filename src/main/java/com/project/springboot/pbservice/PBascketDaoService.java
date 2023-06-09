package com.project.springboot.pbservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.productdto.OrderinfoDTO;
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
	
	// O_Num 체크
	@Override
	public String checkM_Num(String u_id) {
		String result = dao.checkM_NumDao(u_id);
		
		return result;
	}
	
	// 결제 DB처리
	@Override
	public int insertOrder(OrderinfoDTO orderinfoDTO) {
		int result = dao.insertOrderDao(orderinfoDTO);
		
		return result;
	}
	
	// 장바구니 결제 상세 DB처리
	@Override
	public int insertBOinfo(String m_num, String u_id, String u_nick, String p_num, String p_name, String p_price, String bo_qty) {
		int result = dao.insertBOinfoDao(m_num, u_id, u_nick, p_num, p_name, p_price, bo_qty);
		return result;
	}
	
	// 장바구니 결제 후 삭제
	@Override
	public int deleteABascket(String u_id) {
		int result = dao.deleteABascketDao(u_id);
		
		return result;
	}
}
