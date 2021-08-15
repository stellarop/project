package com.spring.www.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;

@Service
public interface BoardService {
	// �� �Է�
	public void insertBoard(BoardVO vo);
	// �� ����
	public void updateBoard(BoardVO vo);
	// �� ����
	public void deleteBoard(BoardVO vo);
	// �� ��ȸ
	public BoardVO getBoard(int boardseq);
	// �� ����Ʈ + ����¡
	public List<BoardVO> selectBoardList(Criteria cri);
	// �Խñ� ����
	public int selectCount(Criteria cri);
	// �Խñ� ��ȸ��
	public void boardCount(int boardseq);
	// �Խñ� ��õ
	public void upCount(int boardseq);
	// �Խñ� �ݴ�
	public void downCount(int boardseq);
	// �Խñ� ���� ���� �н����� üũ
	public int boardPwdCheck(BoardVO vo);
	//public List<BoardVO> boardList();
}
