package com.project.springboot.afbService;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.fboard.fboardDTO;

@Service
public class fboardServiceImpl implements IFboardService {
	
	@Autowired
	fboardService fsv;
	
	int listCount = 5;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
    @Override
    public List<fboardDTO> selectF(int curpage, String searchField, String searchWord) {
    	int nStart = (curpage - 1) * listCount + 1;
		int nEnd = (curpage - 1) * listCount + listCount;
    	
        return fsv.selectF(nEnd, nStart, searchField, searchWord);
    }

    @Override
    public int insertF(fboardDTO fboardDto) {
        return fsv.insertF(fboardDto);
    }

    @Override
    public fboardDTO selectOneF(String f_num) {
        return fsv.selectOneF(f_num);
    }

    @Override
    public int updateF(fboardDTO fboardDto) {
        return fsv.updateF(fboardDto);
    }

    @Override
    public int deleteF(fboardDTO fboardDto) {
        return fsv.deleteF(fboardDto);
    }
    
    @Override
    public BpageInfo articlePage(int curPage, String searchField, String searchWord) {
    	int totalCount = 0;
		totalCount = fsv.articlePageDao(curPage, searchField, searchWord);
		
		// 총 페이지 수
		int totalPage = totalCount / listCount;
		if (totalCount % listCount > 0)
		{
			totalPage++;
		}
		
		// 현재 페이지
		int myCurPage = curPage;
		if (myCurPage > totalPage)
		{
			myCurPage = totalPage;
			
		}
		if (myCurPage < 1)
		{
			myCurPage = 1;
		}
		
		// 시작 페이지
		int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;
		
		// 끝 페이지
		int endPage = startPage + pageCount - 1;
		if (endPage > totalPage)
		{
			endPage = totalPage;
		}
		
		BpageInfo pinfo = new BpageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
    }
}
