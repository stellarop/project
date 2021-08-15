package com.spring.www.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;

@Service
public interface BoardService {
	// 글 입력
	public void insertBoard(BoardVO vo);
	// 글 수정
	public void updateBoard(BoardVO vo);
	// 글 삭제
	public void deleteBoard(BoardVO vo);
	// 글 조회
	public BoardVO getBoard(int boardseq);
	// 글 리스트 + 페이징
	public List<BoardVO> selectBoardList(Criteria cri);
	// 게시글 개수
	public int selectCount(Criteria cri);
	// 게시글 조회수
	public void boardCount(int boardseq);
	// 게시글 추천
	public void upCount(int boardseq);
	// 게시글 반대
	public void downCount(int boardseq);
	// 게시글 수정 삭제 패스워드 체크
	public int boardPwdCheck(BoardVO vo);
	//public List<BoardVO> boardList();
}
