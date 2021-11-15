package com.spring.www.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.www.DAO.ReplyDAO;
import com.spring.www.Service.ReplyServie;
import com.spring.www.VO.ReplyVO;

@Service
public class ReplyServieImpl implements ReplyServie {

	@Autowired
	private ReplyDAO replyDAO;
	
	@Override
	public List<ReplyVO> replyList(ReplyVO rvo) {
		return replyDAO.replyList(rvo);
	}

	@Override
	public ReplyVO insertReply(ReplyVO rvo) {
		replyDAO.insertReply(rvo);
		return rvo;
	}
	
	@Override
	public void updateReply(ReplyVO rvo) {
		replyDAO.updateReply(rvo);
	}
	
	@Override
	public void deleteReply(ReplyVO rvo) {
		replyDAO.deleteReply(rvo);
	}

	@Override
	public ReplyVO selectReply(int replyseq) {
		return replyDAO.selectReply(replyseq);
	}

	@Override
	public void upCountReply(int replyseq) {
		replyDAO.upCountReply(replyseq);
	}

	@Override
	public void downCountReply(int replyseq) {
		replyDAO.downCountReply(replyseq);
	}

}
