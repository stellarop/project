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
	
	// ��� ����Ʈ 
	public List<ReplyVO> replyList(ReplyVO rvo){
		return sqlsessiontemplate.selectList("ReplyDAO.replyList",rvo);
	}
	
	// ��� �Է�
	public void insertReply(ReplyVO rvo) {
		sqlsessiontemplate.insert("ReplyDAO.insertreply",rvo);
	}
	
	// ��� ����
	public void updateReply(ReplyVO rvo) {
		sqlsessiontemplate.update("ReplyDAO.updatereply",rvo);
	}
	
	// ��� ����
	public void deleteReply(ReplyVO rvo) {
		sqlsessiontemplate.delete("ReplyDAO.deletereply",rvo);
	}
	
	// ��� ��ȸ
	public ReplyVO selectReply(int replyseq) {
		return sqlsessiontemplate.selectOne("ReplyDAO.selectreply",replyseq);
	}
	
	// ��� ��õ
	public void upCountReply(int replyseq) {
		sqlsessiontemplate.update("ReplyDAO.upCountReply", replyseq);
	}
	
	// ��� ����õ
	public void downCountReply(int replyseq) {
		sqlsessiontemplate.update("ReplyDAO.downCountReply", replyseq);
	}
	
}
