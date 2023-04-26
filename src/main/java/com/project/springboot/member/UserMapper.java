package com.project.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    void insertUser(UserDTO userDTO);
    void updateUser(UserDTO userDTO);
    void deleteUser(String u_id);
    UserDTO selectOne(String u_id);
    UserDTO selectUserByNickname(String u_nickname);
    List<UserDTO> selectAll();
    List<UserDTO> selectBlacklist();
    List<UserDTO> selectUserlist();
}
