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
	
	// �α���
	@Override
	public UserVO login(UserVO vo) {	
		return userDAO.login(vo);
	}

	// ȸ������
	@Override
	public void createUser(UserVO vo) {
		userDAO.createUser(vo);
	}
	
	// ȸ����������
	@Override
	public void updateUser(UserVO vo) {
		userDAO.updateUser(vo);
	}
	
	// id ã��
	@Override
	public UserVO findId(UserVO vo) {
		return userDAO.findId(vo);
	}
	
	// password ã��
	@Override
	public UserVO findPassword(UserVO vo) {
		return userDAO.findPassword(vo);
	}
	
	// ȸ��Ż��
	@Override
	public void deleteUser(UserVO vo) {
		userDAO.deleteUser(vo);
	}
	
	// ���̵� üũ
	@Override
	public int idCheck(UserVO vo) {
		int result = userDAO.idCheCk(vo);
		return result;
	}
	
	// �н����� üũ
	@Override
	public int passwordCheck(UserVO vo) {
		int result = userDAO.passwordCheck(vo);
		return result;
	}
}
