package com.spring.www.Impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import com.spring.www.DAO.BoardDAO;
import com.spring.www.Service.BoardService;
import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public void insertBoard(BoardVO vo) {
		boardDAO.insertBoard(vo);
	}

	@Override
	public void updateBoard(BoardVO vo) {
		boardDAO.updateBoard(vo);
	}

	@Override
	public void deleteBoard(BoardVO vo) {
		boardDAO.deleteBoard(vo);
	}

	@Override
	public BoardVO getBoard(int boardseq) {
		boardDAO.boardCount(boardseq);
		return boardDAO.getBoard(boardseq);
	}

	@Override
	public List<BoardVO> selectBoardList(Criteria cri) {
		return boardDAO.selectBoardList(cri);
	}
	
	@Override
	public int selectCount(Criteria cri) {
		return boardDAO.selectCount(cri);
	}

	
	@Override
	public void boardCount(int boardseq) {
		boardDAO.boardCount(boardseq);
	}

	@Override
	public void upCount(int boardseq) {
		boardDAO.upCount(boardseq);		
	}

	@Override
	public void downCount(int boardseq) {
		boardDAO.downCount(boardseq);
	}

	@Override
	public int boardPwdCheck(BoardVO vo) {
		int result = boardDAO.boardPwdCheck(vo);
		return result;
	}
	
	/*
	@Override
	public List<BoardVO> boardList() {
		return boardDAO.boardList();
	}
	*/
	

}
