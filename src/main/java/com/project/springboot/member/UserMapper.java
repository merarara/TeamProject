package com.project.springboot.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    void insertUser(UserDTO userDTO);
    void updateUser(UserDTO userDTO);
    void deleteUser(String u_id);
    UserDTO selectOne(String u_id);
}
