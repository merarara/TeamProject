package com.project.springboot.pmservice;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public interface IPManagerDaoService {
	
	// 재고 관리 페이지 설정
	public MProductPageinfo articleMPage(int curPage, String searchword, String searchfield);
	
	// 상품 검색
	public List<ProductlistDTO> searchPlist(int curPage, String searchword, String searchfield);
	
	// 상품 재고 검색
	public List<PCountDTO> searchPcount ();
	
	// 재고 삭제
	public int deleteCount(String barcode, int p_num);
	
	// 바코드번호 가져오기
	public List<String> getBarcodeList(int p_num);
	
	// 바코드 번호 추가
	public int addBarcode(int p_num, String barcode);
}
