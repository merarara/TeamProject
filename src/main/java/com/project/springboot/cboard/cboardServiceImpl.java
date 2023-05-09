package com.project.springboot.cboard;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
	public int insertLike(int c_num, String u_id) {
		return abs.insertLike(c_num, u_id);
	}

    @Override
    public void addlike(int c_like) {
        abs.addlike(c_like);
    }
    
    @Override
    public void minlike(int c_like) {
        abs.minlike(c_like);
    }
	
	@Override
	public int getLikeCount(int c_num) {
	    return abs.getLikeCount(c_num);
	}
	
	@Override
	public cboardDTO getCboard(int c_num) {
	    return abs.getCboard(c_num);
	}
	
	 @Override
	 public int upload(upDTO upDto) {
		 return abs.upload(upDto);
	 }
	 
	 @Override
	 public int uploadnum(cboardDTO cboardDto) {
		 return abs.uploadnum(cboardDto);
	 }
	 
	@Override
	public List<upDTO> uploadview(int c_num) {
		return abs.uploadview(c_num);
	}

	@Override
	public List<upDTO> getUploadList(int c_num) {
	    return abs.getUploadList(c_num);
	}
	
	@Override
	public void updateCBoard(cboardDTO cboardDto) {
		cboardService mapper = sqlSession.getMapper(cboardService.class);
	    mapper.update(cboardDto);
	}

	@Override
	public List<upDTO> getFile(int parseInt) {
		return null;
	}

	@Override
	public int update(cboardDTO cboardDto, MultipartFile[] file) {
		return 0;
	}

	@Override
	public boolean checkLiked(int c_num, String u_id) {
		return false;
	}


	@Override
	public int deleteFile(int c_num, String sfile) {
		return abs.deleteFile(c_num, sfile);
	}
	
	@Override
	public int deleteFileAll(String c_num) {
		return abs.deleteFileAll(c_num);
	}
	
	@Override
	public int deleteAll(String c_num) {
		return abs.deleteAll(c_num);
	}
	@Override
	public boolean checkLike(int c_num, String u_id) {
	    int likeCount = abs.selectLikeCount(c_num, u_id); // c_num, u_id로 likeCount 조회
	    return likeCount > 0; // likeCount가 0보다 크면 좋아요를 누른 기록이 있는 것이므로 true 반환
	}
	
	@Override
	public int selectLikeCount(int c_num, String u_id) {
	    return abs.selectLikeCount(c_num, u_id);
	}

	@Override
    public cboardDTO selectOne(int c_num) {
        return abs.selectOne(c_num);
    }

}
