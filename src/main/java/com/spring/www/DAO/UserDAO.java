package com.spring.www.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.www.VO.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;
	
	public UserVO login(UserVO vo) {
		return sqlsessiontemplate.selectOne("UserDAO.login",vo);
	}
	public void createUser(UserVO vo) {
		sqlsessiontemplate.insert("UserDAO.createuser",vo);
	}
	public void updateUser(UserVO vo) {
		sqlsessiontemplate.update("UserDAO.updateuser",vo);
	}
	public UserVO findId(UserVO vo) {
		return sqlsessiontemplate.selectOne("UserDAO.findid",vo);
	}
	public UserVO findPassword(UserVO vo) {
		return sqlsessiontemplate.selectOne("UserDAO.findpassword",vo);
	}
	public void deleteUser(UserVO vo) {
		 sqlsessiontemplate.delete("UserDAO.deleteuser",vo);
	}
	public int idCheCk(UserVO vo) {
		int result = sqlsessiontemplate.selectOne("UserDAO.idcheck",vo);
		return result;
	}
	public int passwordCheck(UserVO vo) {
		int result = sqlsessiontemplate.selectOne("UserDAO.passwordcheck",vo);
		return result;
	}
}
