package com.project.springboot.cboard;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.afbpageinfo.BpageInfo;

@Service
public class CommentServiceImpl implements ICommentService {
	
	@Autowired
    private SqlSession sqlSession;
	
    @Autowired
    private CommentService Cs;
    
    int listCount = 15;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수

    @Override
    public List<CommentDTO> selectC(int curpage) {
    	int nStart = (curpage - 1) * listCount + 1;
		int nEnd = (curpage - 1) * listCount + listCount;
    	
        return Cs.selectC(nEnd, nStart);
    }

    @Override
    public int insertC(CommentDTO CDto) {
        return Cs.insertC(CDto);
    }

    @Override
    public int updateC(CommentDTO CDto) {
        return Cs.updateC(CDto);
    }

    @Override
    public int deleteC(String cc_num) {
        return sqlSession.delete("deleteC", cc_num);
    }
    
    @Override
    public BpageInfo articlePage(int curPage) {
    	int totalCount = 0;
		totalCount = Cs.articlePageDao(curPage);
		
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
	public int addLike(int cc_num, String u_id) {
		return Cs.insertLike(cc_num, u_id);
	}

	@Override
	public int removeLike(int cc_num, String u_id) {
		return Cs.deleteLike(cc_num, u_id);
	}
	
	@Override
	public int getLikeCount(int cc_num) {
	    return Cs.getLikeCount(cc_num);
	}
	
	@Override
	public CommentDTO getComment(int cc_num) {
		return Cs.getComment(cc_num);
	}
}