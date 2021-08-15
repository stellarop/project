package com.spring.www.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.www.DAO.UserDAO;
import com.spring.www.Service.UserService;
import com.spring.www.VO.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;
	
	// 로그인
	@Override
	public UserVO login(UserVO vo) {	
		return userDAO.login(vo);
	}

	// 회원가입
	@Override
	public void createUser(UserVO vo) {
		userDAO.createUser(vo);
	}
	
	// 회원정보수정
	@Override
	public void updateUser(UserVO vo) {
		userDAO.updateUser(vo);
	}
	
	// id 찾기
	@Override
	public UserVO findId(UserVO vo) {
		return userDAO.findId(vo);
	}
	
	// password 찾기
	@Override
	public UserVO findPassword(UserVO vo) {
		return userDAO.findPassword(vo);
	}
	
	// 회원탈퇴
	@Override
	public void deleteUser(UserVO vo) {
		userDAO.deleteUser(vo);
	}
	
	// 아이디 체크
	@Override
	public int idCheck(UserVO vo) {
		int result = userDAO.idCheCk(vo);
		return result;
	}
	
	// 패스워드 체크
	@Override
	public int passwordCheck(UserVO vo) {
		int result = userDAO.passwordCheck(vo);
		return result;
	}
}
