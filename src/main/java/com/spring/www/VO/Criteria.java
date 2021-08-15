package com.spring.www.VO;



//Ư�� ������ ��ȸ
public class Criteria {
	// ���� ������ ��ȣ
	private int page;
	// �� �������� ������ �Խñ��� ����
	private int perPageNum;
	// �˻� Ű���� 
	private String keyword;
	// �˻� Ÿ��
	private String searchType;
	
	
	// Ư�� �������� �Խñ� ���� ��ȣ, �Խñ� ���� �� ��ȣ
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

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
