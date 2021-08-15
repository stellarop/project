package com.spring.www.VO;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class ReplyVO {
	private int replyseq;
	private int boardseq;
	private String writer;
	private String content;
	private int count;
	private String password;
	private Date regdate;
	
	public int getReplyseq() {
		return replyseq;
	}
	public void setReplyseq(int replyseq) {
		this.replyseq = replyseq;
	}
	public int getBoardseq() {
		return boardseq;
	}
	public void setBoardseq(int boardseq) {
		this.boardseq = boardseq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ReplyVO [replyseq=" + replyseq + ", boardseq=" + boardseq + ", writer=" + writer + ", content="
				+ content + ", count=" + count + ", password=" + password + ", regdate=" + regdate + "]";
	}
	
	
	
	
	
	
	
	
	
}
