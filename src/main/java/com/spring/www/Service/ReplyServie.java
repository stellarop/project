package com.spring.www.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.ReplyVO;

@Service
public interface ReplyServie {
	public List<ReplyVO> replyList(ReplyVO rvo);	
	public ReplyVO insertReply(ReplyVO rvo);
	public void updateReply(ReplyVO rvo);	
	public void deleteReply(ReplyVO rvo);
	public ReplyVO selectReply(int replyseq);
	public void upCountReply(int replyseq);
	public void downCountReply(int replyseq);
}
