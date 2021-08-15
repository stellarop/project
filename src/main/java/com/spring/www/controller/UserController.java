package com.spring.www.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.www.Service.UserService;
import com.spring.www.VO.UserVO;

@Controller
public class UserController {

	@Autowired
	private UserService userservice;

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String getLogin(@ModelAttribute("user") UserVO vo) {
		vo.setId("lee");
		vo.setPassword("lee");
		return "login.jsp";
	}

	// 로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") UserVO vo, HttpSession session,RedirectAttributes rttr) {
		UserVO user = userservice.login(vo);
		if (user != null) {
			session.setAttribute("userName", user.getName());
			session.setAttribute("userId", user.getId());
			session.setAttribute("userTime", user.getRegdate());
			session.setAttribute("userPassword", user.getPassword());
			return "main.do";
		} else {
			// rttr.addFlashAttribute("result", "registerOK");
			return "login.jsp";
		}

	}

	// 로그아웃
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		// 브라우저와 연결된 세션 객체를 강제 종료한다
		session.invalidate();
		return "login.jsp";
	}

	// 회원가입
	@RequestMapping(value = "/createUser.do", method = RequestMethod.POST)
	public String createUser(UserVO vo) {
		
		int result = userservice.idCheck(vo);
		
		if(result == 1) {
			return "createUser.do";
		}else if(result == 0) {
			userservice.createUser(vo);
		}
		return "login.jsp";
	}

	// 회원 정보 수정
	@RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
	public String updateUser(UserVO vo, HttpSession session) {
		userservice.updateUser(vo);
		// 회원정보 수정 후 세션 끊어줌
		session.invalidate();
		return "login.jsp";
	}

	// id 찾기
	@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
	public String findId(@ModelAttribute("user") UserVO vo, HttpSession session) {
		UserVO id = userservice.findId(vo);
		if (id != null) {
			session.setAttribute("userName", id.getName());
			session.setAttribute("userId", id.getId());
			return "Id.jsp";
		} else {
			return "noId.jsp";
		}
	} 

	// password 찾기
	@RequestMapping(value = "/findPassword.do", method = RequestMethod.POST)
	public String findPassword(@ModelAttribute("user") UserVO vo, HttpSession session) {
		UserVO password = userservice.findPassword(vo);
		if (password != null) {
			session.setAttribute("userName", password.getName());
			session.setAttribute("userPassword", password.getPassword());
			return "password.jsp";
		} else {
			return "noPassword.jsp";
		}
	}

	// 회원탈퇴
	@RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST)
	public String deleteUser(UserVO vo, HttpSession session) {
		// 세션에 있는 비밀번호
		String sessionpassword = (String) session.getAttribute("userPassword");
		// 입력한 비밀번호
		String vopassword = vo.getPassword();
		if (sessionpassword.equals(vopassword)) {
			userservice.deleteUser(vo);
			session.invalidate();
			return "login.jsp";
		} else {
			return "deleteUser.jsp";
		}
		
	}
	
	// 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public int idCheck(UserVO vo) {
		int result = userservice.idCheck(vo);
		return result;
	}
	
	// 패스워드 체크
	@ResponseBody
	@RequestMapping(value = "/passwordCheck.do", method = RequestMethod.POST)
	public int passwordCheck(UserVO vo) {
		int result = userservice.passwordCheck(vo);
		return result;
	}
}
