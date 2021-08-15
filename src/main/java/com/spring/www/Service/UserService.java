package com.spring.www.Service;

import org.springframework.stereotype.Service;

import com.spring.www.VO.UserVO;

@Service
public interface UserService {
	// �α���
	public UserVO login(UserVO vo);
	// ȸ������
	public void createUser(UserVO vo);
	// ȸ�� ���� ����
	public void updateUser(UserVO vo);
	// id ã��
	public UserVO findId(UserVO vo);
	// password ã��
	public UserVO findPassword(UserVO vo);
	// ȸ��Ż��
	public void deleteUser(UserVO vo);
	// ���̵� üũ
	public int idCheck(UserVO vo);
	// �н����� üũ
	public int passwordCheck(UserVO vo);
	
}
