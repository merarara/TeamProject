package com.project.springboot.pmservice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PManagerDao {
	//페이지 설정
	public int articleMPageDao ();
	
	// 상품 검색
	public List<ProductlistDTO> searchPlistDao(@Param("nEnd") int nEnd, @Param("nStart") int nStart);
	
	// 상품 재고 검색
	public List<PCountDTO> searchPcountDao();
}
