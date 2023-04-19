package com.project.springboot.pservice;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PListDao {
	//페이지설정
	public int articlePageDao (int curPage);
	
	// 리스트뷰
	public ArrayList<ProductlistDTO> listDao (int nEnd, int nStart);
}
