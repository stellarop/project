package com.spring.www.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.www.Service.BoardService;
import com.spring.www.Service.ReplyServie;
import com.spring.www.VO.BoardVO;
import com.spring.www.VO.Criteria;
import com.spring.www.VO.ReplyVO;

@Controller
public class ReplyController {
	@Autowired
	private ReplyServie replyservice;
	
	// 댓글 리스트
	@ResponseBody
	@RequestMapping(value = "/replyList.do",method = RequestMethod.POST)
	public Map<String, Object> getBoard(BoardVO vo, ReplyVO rvo,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		// 로그인한 유저 아이디 getAttribute로 가져오기
		String userId = (String) session.getAttribute("userId");
		// 댓글 리스트
		result.put("reply", replyservice.replyList(rvo));
		// 유저 아이디
		result.put("user", userId);
		return result;
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/insertReply.do", method = RequestMethod.POST)
	public Map<String, Object> insertReply(ReplyVO rvo, Criteria cri,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		// 로그인한 유저 아이디 getAttribute로 가져오기
		String user = (String) session.getAttribute("userId");
		// 댓글 작성자에 로그인한 유저 아이디를 넣어준다
		rvo.setWriter(user);
		// 댓글 작성
		result.put("insertReply", replyservice.insertReply(rvo));
		return result;
	}
	
	
	// 댓글 수정 view
	@RequestMapping(value = "/updateReplyView.do" , method = {RequestMethod.GET,RequestMethod.POST})
	public String updateReplyView(ReplyVO rvo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateReply", replyservice.selectReply(rvo.getReplyseq()));
		return "updateReplyView.jsp";
	}
	
	// 댓글 수정
	@ResponseBody
	@RequestMapping(value = "/updateReply.do", method = RequestMethod.POST)
	public Map<String, Object> updateReply(ReplyVO rvo){
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 어떤 댓글을 수정할지
		result.put("updateReply", replyservice.selectReply(rvo.getReplyseq()));
		// 댓글 수정
		replyservice.updateReply(rvo);
		return result;
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
	public Map<String, Object> deleteReply(ReplyVO rvo){
		Map<String, Object> result = new HashMap<String, Object>();
		// 어떤 댓글을 삭제할지
		result.put("deleteReply", replyservice.selectReply(rvo.getReplyseq()));
		replyservice.deleteReply(rvo);
		return result;
	}
	
	


}
