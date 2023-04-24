package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public interface IPListDaoService {
	// 페이지설정
	public PPageInfo articlePage(int curPage, String searchfield, String searchword, String type, String selected);
	
	// 리스트
	public ArrayList<ProductlistDTO> plist(int curPage, String searchfield, String searchword, String type, String selected);
	
	// 상품 상세페이지
	public ProductinfoDTO viewpinfo(int p_num);
	
	// 상품 검색 자동완성
	public List<String> wordSearchShow(Map<String, String> paraMap);
	
	// 상품 구매
	public int insertOrder(OrderinfoDTO orderinfoDTO);
	
	// 장바구니 추가
	public int add_bascket(ProductBascketDTO bascketDTO);
}
