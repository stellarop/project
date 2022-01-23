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
	public int upCount(BoardVO vo) {
		int upCount = sqlsessiontemplate.update("BoardDAO.upCountBoard" , vo);
		return upCount;
	}
	public int downCount(BoardVO vo) {
		int downCount = sqlsessiontemplate.update("BoardDAO.downCountBoard", vo);
		return downCount;
	} 
	public int count(BoardVO vo) {
		int count = sqlsessiontemplate.selectOne("BoardDAO.count",vo);
		return count;
	}
	
	public List<BoardVO> myList(BoardVO vo){
		return sqlsessiontemplate.selectList("BoardDAO.myList",vo);
	}
	
}
