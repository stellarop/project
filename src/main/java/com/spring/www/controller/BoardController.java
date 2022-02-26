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

	// 게시글 작성 view
	@RequestMapping(value = "/insertBoard.do")
	public String insertBoardUrl() {
		return "insertBoard.jsp";
	}
	
	// 게시글 작성 
	@ResponseBody
	@RequestMapping(value = "/ajaxinsertBoard.do", method = RequestMethod.POST
			) //,produces = "application/text;charset=UTF-8",consumes="multipart/form-data")
	public Map<String, Object> insertBoard(BoardVO vo, HttpSession session) throws IOException{
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(result);
		// 로그인 한 유저 아이디 getAttribute로 가져오기
		String user = (String)session.getAttribute("userId");
		
		// vo에 있는 UploadFile을 파일 형식으로 변경
		MultipartFile uploadFile = vo.getUploadFile();
		System.out.println(uploadFile);
		// 업로드하는 파일의 실제 이름를 반환
		
		String fileName = uploadFile.getOriginalFilename();
		
		// 업로드한 파일의 존재여부
		if(!uploadFile.isEmpty()) {
			String originalFilename = uploadFile.getOriginalFilename();
			// 업로드한 파일을 C:\\Project 파일 업로드 에 저장
			uploadFile.transferTo(new File("C:\\Project 파일 업로드\\" + fileName));
		}	
		// 파일 이름을 데이터베이스에 저장
		vo.setFilename(fileName);
		// 게시글 작성자에 로그인 한 유저 아이디 넣어주기
		vo.setWriter(user);
		result.put("fileName", fileName);
		//게시글 작성
		result.put("insertBoard", boardservice.insertBoard(vo));
		return result;
	}
	
	
	
	// 게시글 수정 view
	@RequestMapping(value = "/updateBoardView.do", method = RequestMethod.GET)
	public String updateBoardView(BoardVO vo, Criteria cri, Model model) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		return "updateBoardView.jsp";
	}
	
	
	
	// 게시글 수정
	@ResponseBody
	@RequestMapping(value = "/updateBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> updateBoard(BoardVO vo, Model model, Criteria cri) {
		Map<String, Object> result = new HashMap<String,Object>();
		// 페이지 유지
		result.put("cri", cri);
		// 어떤 게시글을 수정할지
		result.put("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		// 게시글 수정
		boardservice.updateBoard(vo);
		return result;
	}
	
	 
	// 게시글 삭제 
	@ResponseBody
	@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object>  deleteBoardView(BoardVO vo, Criteria cri) {
		Map<String, Object> result = new HashMap<String,Object>();
		// 페이지 유지
		result.put("cri", cri);
		boardservice.deleteBoard(vo);
		return result;
	}
	
	// 게시글 상세
	@RequestMapping(value = "/getBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getBoard(BoardVO vo,ReplyVO rvo, Model model, Criteria cri,HttpSession session){
	
		// 해당 게시글
		model.addAttribute("board", boardservice.getBoard(vo.getBoardseq()));
		// 페이지
		model.addAttribute("cri", cri);
		// 로그인한 유저 아이디
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		return "getBoard.jsp";
	}  
	
	// 게시글 리스트 View
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardservice.selectCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("boardList", boardservice.selectBoardList(cri));
		return "main.jsp";
	}
	
	// 마이 리스트
	@ResponseBody
	@RequestMapping(value = "/myList.do",method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> myList(BoardVO vo, ReplyVO rvo){
		Map<String, Object> result = new HashMap<String, Object>();
		// 작성한 게시글
		result.put("myList", boardservice.myList(vo));
		// 댓글 개수
		result.put("replyCount", replyservice.replyCount(rvo));
		return result;
	}
}
