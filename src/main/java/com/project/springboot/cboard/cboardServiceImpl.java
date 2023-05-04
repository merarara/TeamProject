package com.project.springboot.cboard;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public class cboardServiceImpl implements IboardService {
	
	@Autowired
    private SqlSession sqlSession;
	
	@Autowired
	private cboardService abs;
	
	int listCount = 5;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
    @Override
    public List<cboardDTO> select(int curpage, String searchField, String searchWord) {
    	int nStart = (curpage - 1) * listCount + 1;
		int nEnd = (curpage - 1) * listCount + listCount;
    	
        return abs.select(nEnd, nStart, searchField, searchWord);
    }

    @Override
    public int insert(cboardDTO cboardDto) {
        return abs.insert(cboardDto);
    }

    @Override
    public cboardDTO selectOne(String c_num) {
        return abs.selectOne(c_num);
    }

    @Override
    public int update(cboardDTO cboardDto) {
        return abs.update(cboardDto);
    }
    
    
    @Override
    public int delete(String c_num) {
	    return sqlSession.delete("delete", c_num);
    }

    @Override
    public BpageInfo articlePage(int curPage, String searchField, String searchWord) {
    	int totalCount = 0;
		totalCount = abs.articlePageDao(curPage, searchField, searchWord);
		
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
    
    @Override
    public void updateVisitCount(String c_num) {
        abs.updateVisitCount(c_num);
    }
    
    @Override
	public int addLike(int c_num, String u_id) {
		return abs.insertLike(c_num, u_id);
	}

	@Override
	public int removeLike(int c_num, String u_id) {
		return abs.deleteLike(c_num, u_id);
	}
	
	@Override
	public int getLikeCount(int c_num) {
	    return abs.getLikeCount(c_num);
	}
	
	 @Override
	    public cboardDTO getCboard(int c_num) {
	        return abs.getCboard(c_num);
	   }
}
