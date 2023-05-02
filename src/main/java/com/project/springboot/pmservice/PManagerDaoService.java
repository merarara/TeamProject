package com.project.springboot.pmservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public class PManagerDaoService implements IPManagerDaoService {
	
	@Autowired
	PManagerDao dao;
	
	private int plistMPsize = 20;
	
	private int plistMPblock = 5;
	
	@Override
	public List<ProductlistDTO> searchPlist(int curpage, String searchword, String searchfield) {
		int nStart = (curpage - 1) * plistMPsize + 1;
		int nEnd = (curpage - 1) * plistMPsize + plistMPsize;
		
		List<ProductlistDTO> plist = dao.searchPlistDao(nEnd, nStart, searchword, searchfield); 
		
		return plist;
	}
	
	@Override
	public List<PCountDTO> searchPcount() {
		List<PCountDTO> pcnt = dao.searchPcountDao();
		
		return pcnt;
	}
	
	@Override
	public int deleteCount(String barcode, int p_num) {
		int result = dao.deleteCountDao(barcode);
		
		System.out.println(result);
		
		if (result == 1) {
			dao.updateCountDao(p_num);
		}
		
		return result;
	}
	
	@Override
	public List<String> getBarcodeList(int p_num) {
		
		List<String> barcodeList = dao.getBarcodeListDao(p_num);
		
		return barcodeList;
	}
	
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
}
