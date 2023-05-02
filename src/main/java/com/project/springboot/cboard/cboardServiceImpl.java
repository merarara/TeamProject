package com.project.springboot.cboard;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<cboardDTO> select(int curpage) {
    	int nStart = (curpage - 1) * listCount + 1;
		int nEnd = (curpage - 1) * listCount + listCount;
    	
        return abs.select(nEnd, nStart);
    }

    @Override
    public int insert(cboardDTO cboardDto) {
        return abs.insert(cboardDto);
    }

    @Override
    public cboardDTO selectOne(String a_num) {
        return abs.selectOne(a_num);
    }

    @Override
    public int update(cboardDTO cboardDto) {
        return abs.update(cboardDto);
    }
    
    @Override
    public List<cboardDTO> searchboard(String searchField, String searchWord) {
        return abs.searchboard(searchField, searchWord);
    }
    
    @Override
    public int delete(String a_num) {
	    return sqlSession.delete("deleteA", a_num);
    }

    @Override
    public BpageInfo articlePage(int curPage) {
    	int totalCount = 0;
		totalCount = abs.articlePageDao(curPage);
		
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
    public Map<String, Object> toggleLike(int a_num, String u_id) {
        Map<String, Object> result = new HashMap<String, Object>();

        int likeCount = abs.selectLikeCount(a_num);

        int updatedLikeCount = 0;

        // 이미 좋아요를 누른 상태인 경우 -> 좋아요 삭제
        if (abs.selectLike(a_num, u_id) != null) {
            abs.deleteLike(a_num, u_id);
            updatedLikeCount = likeCount - 1;
            result.put("liked", false);
        }
        // 좋아요를 누르지 않은 상태인 경우 -> 좋아요 추가
        else {
            abs.insertLike(a_num, u_id);
            updatedLikeCount = likeCount + 1;
            result.put("liked", true);
        }

        abs.updateLikeCount(a_num, updatedLikeCount);

        result.put("likeCount", updatedLikeCount);

        return result;
    }
    
    @Override
    public int insertLike(int a_num, String u_id) {
        int result = 0;
        try {
            result = abs.insertLike(a_num, u_id); // DAO 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public int deleteLike(int a_num, String u_id) {
        int result = 0;
        try {
            result = abs.deleteLike(a_num, u_id); // DAO 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public int selectLikeCount(int a_num) {
        int result = 0;
        try {
            result = abs.selectLikeCount(a_num); // DAO 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public Object selectLike(int a_num, String u_id) {
        Object result = null;
        try {
            result = abs.selectLike(a_num, u_id); // DAO 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    
    
    @Override
    public void updateLikeCount(int a_num, int updatedLikeCount) {
        Map<String, Object> map = new HashMap<>();
        map.put("a_num", a_num);
        map.put("a_likecount", updatedLikeCount);
        sqlSession.update("aboardMapper.updateLikeCount", map);
    }
}
