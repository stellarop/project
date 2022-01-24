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
	
	// 댓글 리스트 
	public List<ReplyVO> replyList(ReplyVO rvo){
		return sqlsessiontemplate.selectList("ReplyDAO.replyList",rvo);
	}
	
	// 댓글 입력
	public void insertReply(ReplyVO rvo) {
		sqlsessiontemplate.insert("ReplyDAO.insertreply",rvo);
	}
	
	// 댓글 수정
	public void updateReply(ReplyVO rvo) {
		sqlsessiontemplate.update("ReplyDAO.updatereply",rvo);
	}
	
	// 댓글 삭제
	public void deleteReply(ReplyVO rvo) {
		sqlsessiontemplate.delete("ReplyDAO.deletereply",rvo);
	}
	
	// 댓글 조회
	public ReplyVO selectReply(int replyseq) {
		return sqlsessiontemplate.selectOne("ReplyDAO.selectreply",replyseq);
	}
	
	// 댓글 개수
	public int replyCount(ReplyVO rvo) {
		int replyCount = sqlsessiontemplate.selectOne("ReplyDAO.replyCount", rvo);
		return replyCount;
	}
	
}
