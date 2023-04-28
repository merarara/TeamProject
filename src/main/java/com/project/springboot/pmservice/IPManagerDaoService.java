package com.project.springboot.pmservice;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public interface IPManagerDaoService {
	
	// 재고 관리 페이지 설정
	public MProductPageinfo articleMPage(int curPage);
	
	// 상품 검색
	public List<ProductlistDTO> searchPlist(int curPage);
	
	// 상품 재고 검색
	public List<PCountDTO> searchPcount ();
}
