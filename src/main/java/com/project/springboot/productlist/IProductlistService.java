package com.project.springboot.productlist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IProductlistService {
	//상품 전체 목록
	public List<ProductlistDTO> productlist_allsch();
}
