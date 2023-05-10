package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.project.springboot.aboard.aboardDTO;
import com.project.springboot.cboard.cboardDTO;
import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.PCountVO;
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
	
	// 상품 재고 확인
	@Override
	public List<PCountVO> pCountChk(int p_num) {
		List<PCountVO> p_count = dao.pCountChkDao(p_num);
		
		return p_count;
	}
	
	// 상품 상세페이지 뷰
	@Override
	public ProductinfoDTO viewpinfo(int p_num) {
		ProductinfoDTO dto = dao.viewpinfoDao(p_num);
		
		return dto;
	}
	
	// 상품 결제 체크
	@Override
	public String buyCheck(int p_num, String u_id) {
		String bchk = dao.buyCheckDao(p_num, u_id);
		
		return bchk;
	}
	
	// 상품 검색 자동완성
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> list = dao.wordSearchShowDao(paraMap);
		
		return list;
	}
	
	// 결제 후 SCount증가
	@Override
	public int update_SCount(int p_num) {
		int result = dao.update_SCountDao(p_num);
		
		return result;
	}
	
	// 홈 상품 가져오기
	@Override
	public List<ProductlistDTO> homeProduct() {
		List<ProductlistDTO> plist = dao.homeProductDao();
		
		return plist;
	}
	
	// 홈 공지사항 가져오기
	@Override
	public List<aboardDTO> getNotice() {
		List<aboardDTO> nlist = dao.getNoticeDao();
		
		return nlist;
	}
	
	// 상품 상세 장바구니 체크
	@Override
	public String bascketCheck(String u_id) {
		String bascketChk = dao.bascketCheckDao(u_id);
		return bascketChk;
	}
	
	@Override
	public List<cboardDTO> getBoard() {
		List<cboardDTO> clist = dao.getBoardDao();
		return clist;
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
