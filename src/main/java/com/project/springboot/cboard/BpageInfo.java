package com.project.springboot.cboard;

import lombok.Data;

@Data
public class BpageInfo {
	private int totalCount;			// 총 게시물의 갯수
	private int listCount;			// 한페이지당 보여줄 게시물의 갯수
	private int totalPage;			// 총 페이지
	private int curPage;			// 현재 페이지
	private int pageCount;			// 하단에 보여줄 페이지 리스트의 갯수
	private int startPage;			// 시작 페이지
	private int endPage;			// 끝 페이지
}
