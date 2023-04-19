package com.project.springboot.pservice;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public interface IPListDaoService {
	// 페이지설정
	public PPageInfo articlePage(int curPage);
	
	// 리스트
	public ArrayList<ProductlistDTO> plist(int curPage);
}