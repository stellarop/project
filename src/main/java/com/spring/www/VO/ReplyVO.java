package com.spring.www.VO;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyVO {
	private int replyseq;
	private int boardseq;
	private String writer;
	private String content;
	// json으로 데이터 출력시 날짜 출력이 제대로 되지 않음
	// @JsonFormat(pattern = "yyyy-MM-dd")를 붙혀주어서 날짜 형식으로 맞춰준다
	@JsonFormat(pattern = "yyyy-MM-dd")
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ReplyVO [replyseq=" + replyseq + ", boardseq=" + boardseq + ", writer=" + writer + ", content="
				+ content + ", regdate=" + regdate + "]";
	}
	
	
	
	
	
	
	
}
