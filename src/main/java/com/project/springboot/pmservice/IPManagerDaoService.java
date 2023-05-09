package com.project.springboot.pmservice;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.BOrderinfoDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.PSoldInfoDTO;
import com.project.springboot.productdto.ProductinfoDTO;
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
	
	// 주문 관리 페이지 설정
	public MProductPageinfo articleSPage(int curPage, String searchword, String searchfield, String tab);
		
	// 주문 관리 페이지 검색
	public List<OrderinfoDTO> searchSList(int curPage, String searchword, String searchfield, String tab);
	
	// 주문 상세 내역 가져오기
	public List<BOrderinfoDTO> getBOrder();
	
	// 상품 결제 승인
	public int confirmOrder(String barcode, String m_num, String p_num);
	
	// 상품 주문 취소
	public int doCancel(int m_num);
	
	// 상품 재고 업데이트
	public void updateCount(String p_num);
	
	// 상품 주문 상태 변경
	public int updateOrder(String m_num, String status);
	
	// 상품 판매 내역 가져오기
	public List<PSoldInfoDTO> getSoldInfo ();
	
	// 상품 추가
	public int addProduct(ProductlistDTO pDTO, ProductinfoDTO pinfoDTO);
}
