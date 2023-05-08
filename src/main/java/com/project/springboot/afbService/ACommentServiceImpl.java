package com.project.springboot.afbService;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.aboard.ACommentDTO;
import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public class ACommentServiceImpl implements IACommentService {
	
	@Autowired
    private SqlSession sqlSession;
	
    @Autowired
    private ACommentService acs;
    
    int listCount = 15;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수

    @Override
    public List<ACommentDTO> selectAC(int a_num, String ac_num) {
        return acs.selectAC(a_num, ac_num);
    }

    @Override
    public int insertAC(ACommentDTO acDto) {
        return acs.insertAC(acDto);
    }

    @Override
    public int updateAC(ACommentDTO acDto) {
        return acs.updateAC(acDto);
    }

    @Override
    public int deleteAC(Map<String, Object> params) {
        return acs.deleteAC(params);
    }
    
    @Override
    public BpageInfo articlePage(int curPage) {
    	int totalCount = 0;
		totalCount = acs.articlePageDao(curPage);
		
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
	public int addAcLike(int ac_num, String u_id) {
		return acs.insertAcLike(ac_num, u_id);
	}

	@Override
	public int removeAcLike(int ac_num, String u_id) {
		return acs.deleteAcLike(ac_num, u_id);
	}
	
	@Override
	public int getAcLikeCount(int ac_num) {
	    return acs.getAcLikeCount(ac_num);
	}
	
	@Override
	public ACommentDTO getAComment(int ac_num) {
		return acs.getAComment(ac_num);
	}
	
	@Override
	public List<ACommentDTO> selectAnum(String a_num) {
		return acs.selectAnum(a_num);
	}
	
	@Override
	public ACommentDTO getAC(String u_id, int ac_num) {
	    ACommentDTO acDto = acs.getAC(u_id, ac_num);
	    return acDto;
	}
	 
}