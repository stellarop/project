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
	public BoardVO insertBoard(BoardVO vo) {
		boardDAO.insertBoard(vo);
		return vo;
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
	public int upCount(BoardVO vo) {
		int upCount = boardDAO.upCount(vo);		
		return upCount;
	}

	@Override
	public int downCount(BoardVO vo) {
		int downCount = boardDAO.downCount(vo);
		return downCount;
	}
	
	@Override
	public int count(BoardVO vo) {
		int count = boardDAO.count(vo);
		return count;
	}
	
	@Override
	public List<BoardVO> myList(BoardVO vo) {
		return boardDAO.myList(vo);
	}
	

}
