package com.spring.www.DAO;



import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;
	
	public void insertBoard(BoardVO vo) {
		sqlsessiontemplate.insert("BoardDAO.insertBoard",vo);
	}	 
	public void updateBoard(BoardVO vo) {
		sqlsessiontemplate.update("BoardDAO.updateBoard",vo);
	}
	public void deleteBoard(BoardVO vo) {
		sqlsessiontemplate.delete("BoardDAO.deleteBoard",vo); 
	}
	public BoardVO getBoard(int boardseq) {
		return sqlsessiontemplate.selectOne("BoardDAO.getBoard",boardseq);
	}
	public List<BoardVO> selectBoardList(Criteria cri){
		return sqlsessiontemplate.selectList("BoardDAO.selectBoardList", cri);
	}
	public int selectCount(Criteria cri) {
		return sqlsessiontemplate.selectOne("BoardDAO.selectCount",cri);
	}
	public void boardCount(int boardseq) {
		sqlsessiontemplate.update("BoardDAO.boardCount", boardseq);
	}
	public void upCount(int boardseq) {
		sqlsessiontemplate.update("BoardDAO.upCountBoard" , boardseq);
	}
	public void downCount(int boardseq) {
		sqlsessiontemplate.update("BoardDAO.downCountBoard", boardseq);
	} 
	public int boardPwdCheck(BoardVO vo) {
		int result = sqlsessiontemplate.selectOne("BoardDAO.boardPwdCheck",vo);
		return result;
	}
	
}
