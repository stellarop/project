package com.spring.www.VO;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

// �Խ��� ����¡ ó��
public class PageMaker {
	// ���� ������ ��ȣ
	private Criteria cri;
	// �� �Խñ� ����
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	// ȭ�� �ϴܿ� �������� ������ ��ư�� ��
	private int displayPageNum = 5;

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	private void calcData() {
		// �� ������ ��ȣ = (���� ������ ��ȣ / ȭ�鿡 ������ ������ ��ȣ�� ����) * ȭ�鿡 ������ ������ ��ȣ�� ����
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		// ���� ������ ��ȣ = (�� ������ ��ȣ - ȭ�鿡 ������ ������ ��ȣ�� ����) + 1
		startPage = (endPage - displayPageNum) + 1;
		if (startPage <= 0)
			startPage = 1;
		
		//������ ������ ��ȣ = �� ���ñ� �� / �� �������� ������ ���ñ��� ����
		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		// ���� ��ư ���� ���� = ���� ������ ��ȣ == 1 ? false : true
		prev = startPage == 1 ? false : true;
		// ���� ��ư ���� ���� = �� ������ ��ȣ * �� �������� ������ �Խñ��� ���� < �� �Խñ��� �� ? true : false
		next = endPage * cri.getPerPageNum() < totalCount ? true : false;
		
	} 
	

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}
	
	

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	
}
