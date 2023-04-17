package com.project.springboot.pservice;

import java.util.ArrayList;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productlist.ProductlistDTO;

public interface IPListDaoService {
	// 페이지설정
	public PPageInfo articlePage(int curPage);
	
	// 리스트
	public ArrayList<ProductlistDTO> plist(int curPage);
}
