package com.spring.www.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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


@Controller
public class BoardController {
	@Autowired
	private BoardService boardservice;
	private ReplyServie replyservice;
	// 寃���湲� ���� view
	@RequestMapping(value = "/insertBoard.do")
	public String insertBoardUrl() {
		return "insertBoard.jsp";
	}
	  
	// 寃���湲� ���� 
	@ResponseBody
	@RequestMapping(value = "/ajaxinsertBoard.do", method = RequestMethod.POST
			) //,produces = "application/text;charset=UTF-8",consumes="multipart/form-data")
	public Map<String, Object> insertBoard(BoardVO vo, HttpSession session) throws IOException{
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(result);
		// 濡�洹몄�� �� ���� ���대�� getAttribute濡� 媛��몄�ㅺ린
		String user = (String)session.getAttribute("userId");
		
		// vo�� ���� UploadFile�� ���� �����쇰� 蹂�寃�
		MultipartFile uploadFile = vo.getUploadFile();
		System.out.println(uploadFile);
		// ��濡������� ���쇱�� �ㅼ�� �대�瑜� 諛���
		
		String fileName = uploadFile.getOriginalFilename();
		
		// ��濡����� ���쇱�� 議댁�ъ�щ�
		if(!uploadFile.isEmpty()) {
			String originalFilename = uploadFile.getOriginalFilename();
			// ��濡����� ���쇱�� C:\\Project ���� ��濡��� �� ����
			uploadFile.transferTo(new File("C:\\Project ���� ��濡���\\" + fileName));
		}	
		// ���� �대��� �곗�댄�곕��댁�ㅼ�� ����
		vo.setFilename(fileName);
		// 寃���湲� ���깆���� 濡�洹몄�� �� ���� ���대�� �ｌ�댁＜湲�
		vo.setWriter(user);
		result.put("fileName", fileName);
		//寃���湲� ����
		result.put("insertBoard", boardservice.insertBoard(vo));
		return result;
	}
	
	
	
	// 寃���湲� ���� view
	@RequestMapping(value = "/updateBoardView.do", method = RequestMethod.GET)
	public String updateBoardView(BoardVO vo, Criteria cri, Model model) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		return "updateBoardView.jsp";
	}
	
	
	
	// 寃���湲� ����
	@ResponseBody
	@RequestMapping(value = "/updateBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> updateBoard(BoardVO vo, Model model, Criteria cri) {
		Map<String, Object> result = new HashMap<String,Object>();
		// ���댁� ��吏�
		result.put("cri", cri);
		// �대�� 寃���湲��� ������吏�
		result.put("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		// 寃���湲� ����
		boardservice.updateBoard(vo);
		return result;
	}
	
	 
	// 寃���湲� ���� 
	@ResponseBody
	@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object>  deleteBoardView(BoardVO vo, Criteria cri) {
		Map<String, Object> result = new HashMap<String,Object>();
		// ���댁� ��吏�
		result.put("cri", cri);
		boardservice.deleteBoard(vo);
		return result;
	}
	
	// 寃���湲� ����
	@RequestMapping(value = "/getBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getBoard(BoardVO vo,ReplyVO rvo, Model model, Criteria cri,HttpSession session){
	
		// �대�� 寃���湲�
		model.addAttribute("board", boardservice.getBoard(vo.getBoardseq()));
		// ���댁�
		model.addAttribute("cri", cri);
		// 濡�洹몄�명�� ���� ���대��
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		return "getBoard.jsp";
	}  
	
	// 寃���湲� 由ъ�ㅽ�� View
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardservice.selectCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("boardList", boardservice.selectBoardList(cri));
		return "main.jsp";
	}
	
	// 留��� 由ъ�ㅽ�� 
	@ResponseBody
	@RequestMapping(value = "/myList.do",method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> myList(BoardVO vo, ReplyVO rvo){
		Map<String, Object> result = new HashMap<String, Object>();
		// ���깊�� 寃���湲� 
		result.put("myList", boardservice.myList(vo));
		// ��湲� 媛���
		result.put("replyCount", replyservice.replyCount(rvo));
		return result;
	}
}
