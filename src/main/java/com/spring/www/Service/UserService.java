package com.spring.www.Service;

import org.springframework.stereotype.Service;

import com.spring.www.VO.UserVO;

@Service
public interface UserService {
	// 로그인
	public UserVO login(UserVO vo);
	// 회원가입
	public void createUser(UserVO vo);
	// 회원 정보 수정
	public void updateUser(UserVO vo);
	// id 찾기
	public UserVO findId(UserVO vo);
	// password 찾기
	public UserVO findPassword(UserVO vo);
	// 회원탈퇴
	public void deleteUser(UserVO vo);
	// 아이디 체크
	public int idCheck(UserVO vo);
	// 패스워드 체크
	public int passwordCheck(UserVO vo);
	
}
