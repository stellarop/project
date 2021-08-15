package com.spring.www.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	// ´ñ±Û µî·Ï
	@RequestMapping(value = "/insertReply.do" , method = {RequestMethod.GET, RequestMethod.POST})
	public String insertReply(ReplyVO rvo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		replyservice.insertReply(rvo);
		return "getBoard.do";
  } 
	
	// ´ñ±Û ¼öÁ¤ ºä
	@RequestMapping(value = "/updateReplyView.do" , method = {RequestMethod.GET,RequestMethod.POST})
	public String updateReplyView(ReplyVO rvo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("updateReply", replyservice.selectReply(rvo.getReplyseq()));
		return "updateReplyView.jsp";
	}
		
	// ´ñ±Û ¼öÁ¤
	@RequestMapping(value = "/updateReply.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateReply(ReplyVO rvo) {
		
		ReplyVO selectreply = replyservice.selectReply(rvo.getReplyseq()); 
		
		String replypassword = selectreply.getPassword();
		String password = rvo.getPassword();
		
		if(replypassword.equals(password)) {
			replyservice.updateReply(rvo);
			return "getBoard.do";
		}
		return "updateReplyView.do";
	}
	
	// ´ñ±Û »èÁ¦ ºä
	@RequestMapping(value = "/deleteReplyView.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteReplyView(ReplyVO rvo, Model model, Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("deleteReply", replyservice.selectReply(rvo.getReplyseq()));
		return "deleteReplyView.jsp";
	}
	
	// ´ñ±Û »èÁ¦
	@RequestMapping(value = "/deleteReply.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteReply(ReplyVO rvo){		
		
		ReplyVO selectreply = replyservice.selectReply(rvo.getReplyseq()); 
		
		String replypassword = selectreply.getPassword();
		String password = rvo.getPassword();
		
		if(replypassword.equals(password)) {
			replyservice.deleteReply(rvo);
			return "getBoard.do";
		}
		return "deleteReplyView.do";
	}
	
	// ´ñ±Û ÃßÃµ
	@RequestMapping(value = "/upCountReply.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String upCountReply(ReplyVO rvo) {
		replyservice.upCountReply(rvo.getReplyseq());
		return "getBoard.do";
	}
	
	// ´ñ±Û ¹Ý´ë
	@RequestMapping(value = "/downCountReply.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String downCountReply(ReplyVO rvo) {
		replyservice.downCountReply(rvo.getReplyseq());
		return "getBoard.do";
	}

}
