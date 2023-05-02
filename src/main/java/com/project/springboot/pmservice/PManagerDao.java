package com.project.springboot.pmservice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PManagerDao {
	//페이지 설정
	public int articleMPageDao (@Param("searchWord") String searchWord, @Param("searchField") String searchField);
	
	// 상품 검색
	public List<ProductlistDTO> searchPlistDao(@Param("nEnd") int nEnd, @Param("nStart") int nStart, @Param("searchWord") String searchword, @Param("searchField") String searchfield);
	
	// 상품 재고 검색
	public List<PCountDTO> searchPcountDao();
	
	// 재고 삭제
	public int deleteCountDao(String barcode);
	
	// 재고 업데이트
	public void updateCountDao(int p_num);
	
	// 바코드번호 가져오기
	public List<String> getBarcodeListDao(int p_num);
	
	// 바코드번호 추가
	public int addBarcodeDao(int p_num, String barcode);
}
