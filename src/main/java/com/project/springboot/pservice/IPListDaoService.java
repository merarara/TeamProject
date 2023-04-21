package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public interface IPListDaoService {
	// 페이지설정
	public PPageInfo articlePage(int curPage, String searchfield, String searchword, String type);
	
	// 리스트
	public ArrayList<ProductlistDTO> plist(int curPage, String searchfield, String searchword, String type);
	
	// 상품 상세페이지
	public ProductinfoDTO viewpinfo(int p_num);
	
	// 상품 검색 자동완성
	public List<String> wordSearchShow(Map<String, String> paraMap);
	
}
