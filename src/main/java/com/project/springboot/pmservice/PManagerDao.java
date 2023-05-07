package com.project.springboot.pmservice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.productdto.BOrderinfoDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.PSoldInfoDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Mapper
public interface PManagerDao {
	// 페이지 설정
	public int articleMPageDao (@Param("searchWord") String searchWord, @Param("searchField") String searchField);
	
	// 상품 검색
	public List<ProductlistDTO> searchPlistDao(@Param("nEnd") int nEnd, @Param("nStart") int nStart, 
			@Param("searchWord") String searchword, @Param("searchField") String searchfield);
	
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
	
	// 페이지 설정
	public int articleSPageDao (@Param("searchWord") String searchWord, @Param("searchField") String searchField, @Param("tab") String tab);
	
	// 결제 목록 가져오기
	public List<OrderinfoDTO> searchSlistDao(@Param("nEnd") int nEnd, @Param("nStart") int nStart, 
			@Param("searchWord") String searchword, @Param("searchField") String searchfield, @Param("tab") String tab);
	
	// 주문 상세 내역 가져오기
	public List<BOrderinfoDTO> getBOrderDao();
	
	// 상품 결제 승인시 재고 상태 변경
	public int updateBarcodeDao(@Param("barcode") String barcode);
	
	// 판매 재고 정보 입력
	public int insertSoldInfoDao(@Param("barcode") String barcode, @Param("m_num") String m_num, @Param("p_num") String p_num);
	
	// 주문 상태 변경
	public int updateOrderDao(@Param("m_num") String m_num);
	
	// 주문 상태 변경2
	public int updateOrderinfoDao(@Param("m_num") String m_num, @Param("status") String status);
		
	// 상품 판매 내역 가져오기
	public List<PSoldInfoDTO> getSoldInfoDao ();
	
	// 상품 리스트 추가
	public int addPListDao(ProductlistDTO pDTO);
	
	// p_num 추적
	public int searchPNum();
	
	// 상품 상세 정보 추가
	public int addPInfoDao(ProductinfoDTO pinfoDTO);
}
