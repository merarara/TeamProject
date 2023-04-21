package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PListDao {
	//페이지설정
	public int articlePageDao (int curPage, String searchfield, String searchword, String type);
	
	// 리스트뷰
	public ArrayList<ProductlistDTO> listDao (int nEnd, int nStart, String searchfield, String searchword, String type);
	
	// 상품 상세페이지
	public ProductinfoDTO viewpinfoDao (int p_num);
	
	// 상품 검색 자동완성
	public List<String> wordSearchShowDao(Map<String, String> paraMap);
	
	List<ProductlistDTO> plistWithBrandsDao(String[] brands);
}
