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




/* @SessionAttributes는 수정 작업을 처리할 때 유용하게 사용되는 어노테이션
 * Model에 "board" 라는 이름으로 저장되는 데이터가 있다면 그 데이터를 세션 에도 자동으로 저장한다(getBoard 데이터를 board 라는 이름으로 jsp로 넘겨주엇기 때문에)
 * getBoard(게시글 상세보기) 메서드가 실행되어 상세 화면이 출력되면 Model에 board라는 이름으로
 * BoardVO 객체가 저장되고 세션에도 board라는 이름으로 BoardVO 객체가 저장된다
 * BoardVO 객체에는 상세 화면에 출력된 모든 데이터가 저장되어 있다
 * 사용자가 글 수정 버튼을 클릭하면 updateBoard 메서드가 실행되고 중요한 것이 매개변수로 선언된 @ModelAttribute("board") 이다
 * controller에서 updateBoard 메서드가 호출될 때 스프링 컨테이너는 우선 @ModelAttribute("board") 설정을 해석하여
 * 세션에 board라는 이름으로 저장된 데이터가 있는지 확인한다 있다면 해당 객체를 세샨에서 꺼내 매개변수로 선언된 vo 변수에 할당한다
 * 그리고 사용자가 입력한 파라미터값을 vo 객체에 할당한다 이때 사용자가 수정한 데이터 값만 새롭게 할당되고 나머지 데이터는 상세 보기를 했을때
 * 세션에 저장된 데이터가 유지된다
 * 
 */
@Controller
public class BoardController {
	@Autowired
	private BoardService boardservice;
	@Autowired
	private ReplyServie replyservice;

	
	// 게시글 입력
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
	public String insertBoard(BoardVO vo) throws IOException {		
		MultipartFile uploadFile = vo.getUploadFile();
		// 업로드하는 파일의 실제 이름를 반환
		String fileName = uploadFile.getOriginalFilename();
		
		// 업로드한 파일의 존재여부
		if(!uploadFile.isEmpty()) {
			String originalFilename = uploadFile.getOriginalFilename();
			// 업로드한 파일의 데이터를 저장
			uploadFile.transferTo(new File("C:\\Project 파일 업로드\\" + fileName));
		}	
		// 파일 이름을 db에 저장
		vo.setFilename(fileName);
		boardservice.insertBoard(vo);
		return "main.do"; 
	}
	
	// 게시글 수정 뷰
	@RequestMapping(value = "/updateBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateBoardView(BoardVO vo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
		return "updateBoardView.jsp";
	}
	
	// 게시글 수정 
	@RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
	public String updateBoard(BoardVO vo) {
		// 해당 게시글 데이터
		BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
		// 해당 게시글 비밀번호
		String getBoardpassword = getBoard.getPassword();
		// 사용자가 입력한 비밀번호
		String password = vo.getPassword();
		
		if(getBoardpassword.equals(password)) {
			boardservice.updateBoard(vo);
			return "main.do";
			}
		return "updateBoardView.do";
	}
	
	
	// 게시글 삭제 뷰
	@RequestMapping(value = "/deleteBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteBoardView(BoardVO vo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("deleteBoard", boardservice.getBoard(vo.getBoardseq()));
		return "deleteBoardView.jsp";
	}
	
	// 게시글 삭제 
	@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteBoard(BoardVO vo) {
		// 해당 게시글 데이터
		BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
		// 해당 게시글 비밀번호
		String getBoardpassword = getBoard.getPassword();
		// 사용자가 입력한 비밀번호
		String password = vo.getPassword();
		
		if(getBoardpassword.equals(password)) {
			boardservice.deleteBoard(vo);
			return "main.do";
		}
		return "deleteBoardView.do";
	}
	
	// 게시글 조회
	@RequestMapping(value = "/getBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getBoard(BoardVO vo,ReplyVO rvo, Model model, Criteria cri){
		// 게시글 상세 보기 
		model.addAttribute("board", boardservice.getBoard(vo.getBoardseq()));
		// 특정 페이지 조회
		model.addAttribute("cri", cri);
		// 댓글 리스트
		model.addAttribute("replyList", replyservice.replyList(rvo));
		return "getBoard.jsp";
	}  

	// 게시글 리스트
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
	public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
		//System.out.println("입력한 검색어 : " + cri); 
		// 게시글 리스트
		model.addAttribute("boardList", boardservice.selectBoardList(cri));		
		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// 게시글 수 넣어주기
		pageMaker.setTotalCount(boardservice.selectCount(cri));
		//System.out.println("게시글 수 : " + boardservice.selectCount(cri));
		//System.out.println("게시글 내용 : " + boardservice.selectBoardList(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		/*
		if(cri.getKeyword() != null) {
			System.out.println("검색시 출력 : " + cri.getKeyword());
			int pagenum = cri.getPage();
			
			System.out.println("페이지 넘버 : " + pagenum);
			System.out.println(pageMaker.getCri());
			//return "main.do?page=1";
		}else {
			System.out.println("검색하지않을때  출력");
		}
		*/
		return "main.jsp";
	}
	
	// 게시글 추천
	@RequestMapping(value = "/upCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String upCountBoard(BoardVO vo) {
		boardservice.upCount(vo.getBoardseq());
		return "getBoard.do";
	}
	
	// 게시글 반대
	@RequestMapping(value = "/downCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String downCountBoard(BoardVO vo) {
		boardservice.downCount(vo.getBoardseq());
		return "getBoard.do";
	}
	
	// 게시글 수정 삭제 패스워드 체크
	@ResponseBody
	@RequestMapping(value = "/boardPwdCheck.do", method = RequestMethod.POST)
	public int boardPwdCheck(BoardVO vo) {
		int result = boardservice.boardPwdCheck(vo);
		return result;
	}

}
