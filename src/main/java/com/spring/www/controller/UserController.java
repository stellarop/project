package com.spring.www.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	// 로그인
	@ResponseBody
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public boolean login(@ModelAttribute("user") UserVO vo, HttpSession session,RedirectAttributes rttr) {
		// 사용자가 입력한 로그인 데이터를 db와 비교
		UserVO user = userservice.login(vo);
		// 두 데이터가 일치하면 true / 불일치 할시 
		if(user != null) {
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userTime", user.getRegdate());
			session.setAttribute("userPassword", user.getPassword()); 
			return true;
		}else {
			session.setAttribute("login", false);
			return false;
		}	
	}

	// 로그아웃
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) {
		session.invalidate();
		return "login.jsp";
	}

	// 회원가입
	@ResponseBody
	@RequestMapping(value = "/createUser.do", method = RequestMethod.POST)
	public boolean createUser(UserVO vo) {
		
		// 아이디 중복 체크
		int result = userservice.idCheck(vo);
		
		// 중복된 아이디 인지 확인
		if(result == 1) {
			// 중복된 아이디면 false 반환
			return false;
		// 사용 가능한 아이디 일시  회원가입 진행
		}else if(result == 0) {	
			userservice.createUser(vo);
			// 사용 가능한 아이디 일시 true 반환
		}
		return true;	
	}
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
	public int findId(@ModelAttribute("user") UserVO vo, HttpSession session) {
	
		UserVO id = userservice.findId(vo);
		
		if (id != null) {
			// 사용자 이름과 아이디를 보내줌
			session.setAttribute("userName", id.getName());
			session.setAttribute("userId", id.getId());
			session.setAttribute("getId", true);
			return 0;
		} else {
			return 1;
		}
	} 

	// 패스워드  찾기
	@ResponseBody
	@RequestMapping(value = "/findPassword.do", method = RequestMethod.POST)
	public int findPassword(@ModelAttribute("user") UserVO vo, HttpSession session) {
		
		UserVO password = userservice.findPassword(vo);
		
		if (password != null) {
			// 사용자 이름과 패스워드를 보내줌
			session.setAttribute("userName", password.getName());
			session.setAttribute("userPassword", password.getPassword());
			session.setAttribute("getPassword", true);
			return 0;
		} else {
			return 1;
		}
	}

	// 회원탈퇴 
	@RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST)
	public String deleteUser(UserVO vo, HttpSession session) {
	
		// 세션에 있는 패스워드
		String sessionPwd = (String) session.getAttribute("userPassword");
		// 사용자가 입력한 패스워드 
		String voPwd = vo.getPassword();
		
		// 두 값을 비교 후 일치하면 삭제, 세션을 끊어줌
		if (sessionPwd.equals(voPwd)) {
			userservice.deleteUser(vo);
			session.invalidate();
			return "login.jsp";
		}else {
			return "deleteUser.jsp";
		}		
	}
	
	// 회원 정보 수정
	@RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
	public String updateUser(UserVO vo, HttpSession session) {
		userservice.updateUser(vo);
		session.invalidate();
		return "login.jsp";
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
