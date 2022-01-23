package com.spring.www.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;

@Service
public interface BoardService {
	// 게시글 작성
	public BoardVO insertBoard(BoardVO vo);
	// 게시글 수정
	public void updateBoard(BoardVO vo);
	// 게시글 삭제
	public void deleteBoard(BoardVO vo);
	// 게시글 상세 보기 
	public BoardVO getBoard(int boardseq);
	// 게시글 리스트
	public List<BoardVO> selectBoardList(Criteria cri);
	// 게시글 총 개수
	public int selectCount(Criteria cri);
	// 추천수
	public void boardCount(int boardseq);
	// 추천
	public int upCount(BoardVO vo);
	// 반대
	public int downCount(BoardVO vo);
	// 사용자가 작성한 리스트
	public List<BoardVO> myList(BoardVO vo);
}
