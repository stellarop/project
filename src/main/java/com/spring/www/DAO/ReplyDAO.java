package com.spring.www.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.www.VO.ReplyVO;

@Repository
public class ReplyDAO {
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;
	
	// ´ñ±Û ¸®½ºÆ® 
	public List<ReplyVO> replyList(ReplyVO rvo){
		return sqlsessiontemplate.selectList("ReplyDAO.replyList",rvo);
	}
	
	// ´ñ±Û ÀÔ·Â
	public void insertReply(ReplyVO rvo) {
		sqlsessiontemplate.insert("ReplyDAO.insertreply",rvo);
	}
	
	// ´ñ±Û ¼öÁ¤
	public void updateReply(ReplyVO rvo) {
		sqlsessiontemplate.update("ReplyDAO.updatereply",rvo);
	}
	
	// ´ñ±Û »èÁ¦
	public void deleteReply(ReplyVO rvo) {
		sqlsessiontemplate.delete("ReplyDAO.deletereply",rvo);
	}
	
	// ´ñ±Û Á¶È¸
	public ReplyVO selectReply(int replyseq) {
		return sqlsessiontemplate.selectOne("ReplyDAO.selectreply",replyseq);
	}
	
	// ´ñ±Û ÃßÃµ
	public void upCountReply(int replyseq) {
		sqlsessiontemplate.update("ReplyDAO.upCountReply", replyseq);
	}
	
	// ´ñ±Û ºñÃßÃµ
	public void downCountReply(int replyseq) {
		sqlsessiontemplate.update("ReplyDAO.downCountReply", replyseq);
	}
	
}
