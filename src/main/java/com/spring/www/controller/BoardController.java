package com.spring.www.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.www.Service.BoardService;
import com.spring.www.Service.ReplyServie;

import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;
import com.spring.www.VO.PageMaker;
import com.spring.www.VO.ReplyVO;
import com.spring.www.VO.UserVO;




/* @SessionAttributes�� ���� �۾��� ó���� �� �����ϰ� ���Ǵ� ������̼�
 * Model�� "board" ��� �̸����� ����Ǵ� �����Ͱ� �ִٸ� �� �����͸� ���� ���� �ڵ����� �����Ѵ�(getBoard �����͸� board ��� �̸����� jsp�� �Ѱ��־��� ������)
 * getBoard(�Խñ� �󼼺���) �޼��尡 ����Ǿ� �� ȭ���� ��µǸ� Model�� board��� �̸�����
 * BoardVO ��ü�� ����ǰ� ���ǿ��� board��� �̸����� BoardVO ��ü�� ����ȴ�
 * BoardVO ��ü���� �� ȭ�鿡 ��µ� ��� �����Ͱ� ����Ǿ� �ִ�
 * ����ڰ� �� ���� ��ư�� Ŭ���ϸ� updateBoard �޼��尡 ����ǰ� �߿��� ���� �Ű������� ����� @ModelAttribute("board") �̴�
 * controller���� updateBoard �޼��尡 ȣ��� �� ������ �����̳ʴ� �켱 @ModelAttribute("board") ������ �ؼ��Ͽ�
 * ���ǿ� board��� �̸����� ����� �����Ͱ� �ִ��� Ȯ���Ѵ� �ִٸ� �ش� ��ü�� �������� ���� �Ű������� ����� vo ������ �Ҵ��Ѵ�
 * �׸��� ����ڰ� �Է��� �Ķ���Ͱ��� vo ��ü�� �Ҵ��Ѵ� �̶� ����ڰ� ������ ������ ���� ���Ӱ� �Ҵ�ǰ� ������ �����ʹ� �� ���⸦ ������
 * ���ǿ� ����� �����Ͱ� �����ȴ�
 * 
 */
@Controller
public class BoardController {
	@Autowired
	private BoardService boardservice;
	@Autowired
	private ReplyServie replyservice;

	
	// �Խñ� �Է�
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
	public String insertBoard(BoardVO vo) throws IOException {		
		MultipartFile uploadFile = vo.getUploadFile();
		// ���ε��ϴ� ������ ���� �̸��� ��ȯ
		String fileName = uploadFile.getOriginalFilename();
		
		// ���ε��� ������ ���翩��
		if(!uploadFile.isEmpty()) {
			String originalFilename = uploadFile.getOriginalFilename();
			// ���ε��� ������ �����͸� ����
			uploadFile.transferTo(new File("C:\\Project ���� ���ε�\\" + fileName));
		}	
		// ���� �̸��� db�� ����
		vo.setFilename(fileName);
		boardservice.insertBoard(vo);
		return "main.do"; 
	}
	
	// �Խñ� ���� ��
	@RequestMapping(value = "/updateBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateBoardView(BoardVO vo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		return "updateBoardView.jsp";
	}
	
	// �Խñ� ���� 
	@RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
	public String updateBoard(BoardVO vo) {
		// �ش� �Խñ� ������
		BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
		// �ش� �Խñ� ��й�ȣ
		String getBoardpassword = getBoard.getPassword();
		// ����ڰ� �Է��� ��й�ȣ
		String password = vo.getPassword();
		
		if(getBoardpassword.equals(password)) {
			boardservice.updateBoard(vo);
			return "main.do";
			}
		return "updateBoardView.do";
	}
	
	
	// �Խñ� ���� ��
	@RequestMapping(value = "/deleteBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteBoardView(BoardVO vo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("deleteBoard", boardservice.getBoard(vo.getBoardseq()));
		return "deleteBoardView.jsp";
	}
	
	// �Խñ� ���� 
	@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteBoard(BoardVO vo) {
		// �ش� �Խñ� ������
		BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
		// �ش� �Խñ� ��й�ȣ
		String getBoardpassword = getBoard.getPassword();
		// ����ڰ� �Է��� ��й�ȣ
		String password = vo.getPassword();
		
		if(getBoardpassword.equals(password)) {
			boardservice.deleteBoard(vo);
			return "main.do";
		}
		return "deleteBoardView.do";
	}
	
	// �Խñ� ��ȸ
	@RequestMapping(value = "/getBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getBoard(BoardVO vo,ReplyVO rvo, Model model, Criteria cri){
		// �Խñ� �� ���� 
		model.addAttribute("board", boardservice.getBoard(vo.getBoardseq()));
		// Ư�� ������ ��ȸ
		model.addAttribute("cri", cri);
		// ��� ����Ʈ
		model.addAttribute("replyList", replyservice.replyList(rvo));
		return "getBoard.jsp";
	}  

	// �Խñ� ����Ʈ
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
		//System.out.println("�Է��� �˻��� : " + cri); 
		// �Խñ� ����Ʈ
		model.addAttribute("boardList", boardservice.selectBoardList(cri));		
		// ����¡
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// �Խñ� �� �־��ֱ�
		pageMaker.setTotalCount(boardservice.selectCount(cri));
		//System.out.println("�Խñ� �� : " + boardservice.selectCount(cri));
		//System.out.println("�Խñ� ���� : " + boardservice.selectBoardList(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		/*
		if(cri.getKeyword() != null) {
			System.out.println("�˻��� ��� : " + cri.getKeyword());
			int pagenum = cri.getPage();
			
			System.out.println("������ �ѹ� : " + pagenum);
			System.out.println(pageMaker.getCri());
			//return "main.do?page=1";
		}else {
			System.out.println("�˻�����������  ���");
		}
		*/
		return "main.jsp";
	}
	
	// �Խñ� ��õ
	@RequestMapping(value = "/upCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String upCountBoard(BoardVO vo) {
		boardservice.upCount(vo.getBoardseq());
		return "getBoard.do";
	}
	
	// �Խñ� �ݴ�
	@RequestMapping(value = "/downCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String downCountBoard(BoardVO vo) {
		boardservice.downCount(vo.getBoardseq());
		return "getBoard.do";
	}
	
	// �Խñ� ���� ���� �н����� üũ
	@ResponseBody
	@RequestMapping(value = "/boardPwdCheck.do", method = RequestMethod.POST)
	public int boardPwdCheck(BoardVO vo) {
		int result = boardservice.boardPwdCheck(vo);
		return result;
	}

}
