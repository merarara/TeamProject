package com.project.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {
@Autowired
private UserMapper userMapper;

	// 회원가입
	@Transactional
	public void insertUser(UserDTO userDTO) {
	    userMapper.insertUser(userDTO);
	}
	
	// 회원정보 수정
	@Transactional
	public void updateUser(UserDTO userDTO) {
	    userMapper.updateUser(userDTO);
	}
	
	// 회원 탈퇴
	@Transactional
	public void deleteUser(String u_id) {
	    userMapper.deleteUser(u_id);
	}

	@Transactional
	public UserDTO selectone(String u_id) {
		UserDTO dto = userMapper.selectOne(u_id);
		
		return dto;
	}
}
