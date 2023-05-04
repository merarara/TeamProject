package com.project.springboot.pmservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.BOrderinfoDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public class PManagerDaoService implements IPManagerDaoService {
	
	@Autowired
	PManagerDao dao;
	
	private int plistMPsize = 20;
	
	private int plistMPblock = 5;
	
	private int plistSPsize = 3;
	
	private int plistSPblock = 5;
	
	// 재고 관리 페이지 가져오기
	@Override
	public List<ProductlistDTO> searchPlist(int curpage, String searchword, String searchfield) {
		int nStart = (curpage - 1) * plistMPsize + 1;
		int nEnd = (curpage - 1) * plistMPsize + plistMPsize;
		
		List<ProductlistDTO> plist = dao.searchPlistDao(nEnd, nStart, searchword, searchfield); 
		
		return plist;
	}
	
	// 상품 재고량 검색
	@Override
	public List<PCountDTO> searchPcount() {
		List<PCountDTO> pcnt = dao.searchPcountDao();
		
		return pcnt;
	}
	
	// 재고 삭제
	@Override
	public int deleteCount(String barcode, int p_num) {
		int result = dao.deleteCountDao(barcode);
		
		System.out.println(result);
		
		if (result == 1) {
			dao.updateCountDao(p_num);
		}
		
		return result;
	}
	
	// 바코드 목록 가져오기
	@Override
	public List<String> getBarcodeList(int p_num) {
		
		List<String> barcodeList = dao.getBarcodeListDao(p_num);
		
		return barcodeList;
	}
	
	// 바코드 추가
	@Override
	public int addBarcode(int p_num, String barcode) {
		int result = dao.addBarcodeDao(p_num, barcode);
		
		if (result == 1) {
			dao.updateCountDao(p_num);
		}
		
		return result;
	}
	
	// 주문 내역 가져오기
	@Override
	public List<OrderinfoDTO> searchSList(int curpage, String searchword, String searchfield, String tab) {
		int nStart = (curpage - 1) * plistSPsize + 1;
		int nEnd = (curpage - 1) * plistSPsize + plistSPsize;
		
		List<OrderinfoDTO> plist = dao.searchSlistDao(nEnd, nStart, searchword, searchfield, tab); 
		
		return plist;
	}
	
	// 주문 상세 내역 가져오기
	@Override
	public List<BOrderinfoDTO> getBOrder() {
		List<BOrderinfoDTO> blist = dao.getBOrderDao();
		
		return blist;
	}
	
	// 상품 결제 승인
	@Override
	public int confirmOrder(String barcode, String m_num) {
		int result = dao.updateBarcodeDao(barcode);
		int result2 = dao.updateOrderDao(m_num);
		
		if (result + result2 <= 2) {
			dao.updateCountDao(result2);
		}
		
		return result + result2;
	}
	
	// 상품 재고 업데이트
	@Override
	public void updateCount(String p_num) {
		dao.updateCountDao(Integer.parseInt(p_num));
	}
	
	// 재고 관리 페이지 설정
	@Override
	public MProductPageinfo articleMPage(int curpage, String searchword, String searchfield) {
		int totalCount = 0;
		totalCount = dao.articleMPageDao(searchword, searchfield);
		
		// 총 페이지 수
		int totalPage = totalCount / plistMPsize;
		if (totalCount % plistMPsize > 0)
		{
			totalPage++;
		}
		
		// 현재 페이지
		int myCurPage = curpage;
		if (myCurPage > totalPage)
		{
			myCurPage = totalPage;
		}
		if (myCurPage < 1)
		{
			myCurPage = 1;
		}
		
		// 시작 페이지
		int startPage = ((myCurPage - 1) / plistMPblock) * plistMPblock + 1;
		
		// 끝 페이지
		int endPage = startPage + plistMPblock - 1;
		if (endPage > totalPage)
		{
			endPage = totalPage;
		}
		
		MProductPageinfo pinfo = new MProductPageinfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(plistMPsize);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(plistMPblock);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
	}
	
	// 주문 내역 페이지 설정
	@Override
	public MProductPageinfo articleSPage(int curpage, String searchword, String searchfield, String tab) {
		int totalCount = 0;
		totalCount = dao.articleSPageDao(searchword, searchfield, tab);
		
		// 총 페이지 수
		int totalPage = totalCount / plistSPsize;
		if (totalCount % plistSPsize > 0)
		{
			totalPage++;
		}
		
		// 현재 페이지
		int myCurPage = curpage;
		if (myCurPage > totalPage)
		{
			myCurPage = totalPage;
		}
		if (myCurPage < 1)
		{
			myCurPage = 1;
		}
		
		// 시작 페이지
		int startPage = ((myCurPage - 1) / plistSPblock) * plistSPblock + 1;
		
		// 끝 페이지
		int endPage = startPage + plistSPblock - 1;
		if (endPage > totalPage)
		{
			endPage = totalPage;
		}
		
		MProductPageinfo pinfo = new MProductPageinfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(plistSPsize);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(plistSPblock);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
	}
}
