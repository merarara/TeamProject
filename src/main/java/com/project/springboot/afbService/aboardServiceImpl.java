package com.project.springboot.afbService;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.aboard.AupDTO;
import com.project.springboot.aboard.aboardDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public class aboardServiceImpl implements IAboardService {
	
	@Autowired
    private SqlSession sqlSession;
	
	@Autowired
	private aboardService abs;
	
	int listCount = 15;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
    @Override
    public List<aboardDTO> selectA(int curpage, String searchField, String searchWord) {
    	int nStart = (curpage - 1) * listCount + 1;
		int nEnd = (curpage - 1) * listCount + listCount;
    	
        return abs.selectA(nEnd, nStart, searchField, searchWord);
    }

    @Override
    public int insertA(aboardDTO aboardDto) {
        return abs.insertA(aboardDto);
    }

    @Override
    public aboardDTO selectOneA(String a_num) {
        return abs.selectOneA(a_num);
    }

    @Override
    public int updateA(aboardDTO aboardDto) {
        return abs.updateA(aboardDto);
    }
    
    @Override
    public int deleteA(String a_num) {
	    return sqlSession.delete("deleteA", a_num);
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
    public void updateVisitCount(String a_num) {
        abs.updateVisitCount(a_num);
    }
    
    @Override
	public int addLike(int a_num, String u_id) {
		return abs.insertLike(a_num, u_id);
	}

	@Override
	public int removeLike(int a_num, String u_id) {
		return abs.deleteLike(a_num, u_id);
	}
	
	@Override
	public int getLikeCount(int a_num) {
	    return abs.getLikeCount(a_num);
	}
	
	 @Override
	    public aboardDTO getAboard(int a_num) {
	        return abs.getAboard(a_num);
	   }
	 
	 @Override
	 public int upload(AupDTO aupDto) {
		 return abs.upload(aupDto);
	 }
	 
	 @Override
	 public int uploadnum(aboardDTO aboardDto) {
		 return abs.uploadnum(aboardDto);
	 }
	 
	@Override
	public List<AupDTO> uploadview(int a_num) {
		return abs.uploadview(a_num);
	}
}
