package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Service
public class PListDaoService implements IPListDaoService {
	
	@Autowired
	PListDao dao;
	
	/* 상품리스트 페이징 변수 start */
	@Value("${productlist.plist_page_size}")
	private int plistPsize;
	
	@Value("${productlist.plist_page_block}")
	private int plistPblock;
	/* 상품리스트 페이징 변수 end */
	
	// 상품리스트 service & dao
	@Override
	public ArrayList<ProductlistDTO> plist(int curpage, String searchfield, String searchword, String type, String selected)
	{
		int nStart = (curpage - 1) * plistPsize + 1;
		int nEnd = (curpage - 1) * plistPsize + plistPsize;
		
		ArrayList<ProductlistDTO> dto = dao.listDao(nEnd, nStart, searchfield, searchword, type, selected);

		return dto;
	}
	
	@Override
	public ProductinfoDTO viewpinfo(int p_num) {
		ProductinfoDTO dto = dao.viewpinfoDao(p_num);
		
		return dto;
	}
	
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> list = dao.wordSearchShowDao(paraMap);
		
		return list;
	}
	
	@Override
	public int insertOrder(OrderinfoDTO orderinfoDTO) {
		int result = dao.insertOrderDao(orderinfoDTO);
		
		return result;
	}
	
	// 페이지 설정 service & dao
	@Override
	public PPageInfo articlePage(int curpage, String searchfield, String searchword, String type, String selected)
	{
		int totalCount = 0;
		totalCount = dao.articlePageDao(searchfield, searchword, type, selected);
		
		// 총 페이지 수
		int totalPage = totalCount / plistPsize;
		if (totalCount % plistPsize > 0)
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
		int startPage = ((myCurPage - 1) / plistPblock) * plistPblock + 1;
		
		// 끝 페이지
		int endPage = startPage + plistPblock - 1;
		if (endPage > totalPage)
		{
			endPage = totalPage;
		}
		
		PPageInfo pinfo = new PPageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(plistPsize);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(plistPblock);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
	}
}
