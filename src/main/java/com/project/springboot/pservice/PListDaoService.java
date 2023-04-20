package com.project.springboot.pservice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.project.springboot.ppageinfo.PPageInfo;
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
	public ArrayList<ProductlistDTO> plist(int curpage)
	{
		int nStart = (curpage - 1) * plistPsize + 1;
		int nEnd = (curpage - 1) * plistPsize + plistPsize;
		
		ArrayList<ProductlistDTO> dto = dao.listDao(nEnd, nStart);

		return dto;
	}
	
	// 페이지 설정 service & dao
	@Override
	public PPageInfo articlePage(int curpage)
	{
		int totalCount = 0;
		totalCount = dao.articlePageDao(curpage);
		
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
