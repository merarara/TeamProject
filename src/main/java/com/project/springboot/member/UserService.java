package com.project.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {
@Autowired
private UserMapper userMapper;

	@Transactional
	public void insertUser(UserDTO userDTO) {
	    userMapper.insertUser(userDTO);
	}

}
