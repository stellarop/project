package com.spring.www.VO;



public class Criteria {
	// 현재 페이지 번호
	private int page;
	 // 한 페이지당 보여줄 게시글의 갯수
	private int perPageNum;
	// 검색 키워드 
	private String keyword;
	// 검색 타입
	private String searchType;
	
	
	// 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	
	// 한개의 페이지에 게시글을 10개 보여줌
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int pageCount) {
		int cnt = this.perPageNum;
		if (pageCount != cnt) {
			this.perPageNum = cnt;
		} else {
			this.perPageNum = pageCount;
		}
	}
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", keyword=" + keyword + ", searchType="
				+ searchType + "]";
	}
	
	

	
	

	
	
}
