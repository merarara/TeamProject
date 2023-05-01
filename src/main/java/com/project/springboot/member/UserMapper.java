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
    int selectTotalCount();
    List<UserDTO> selectAll(int offset, int limit);
    List<UserDTO> selectBlacklist(int offset, int limit);
    List<UserDTO> selectUserlist(int offset, int limit);
    int selectSearchIdCount(String searchId);
    List<UserDTO> searchById(String searchId, int offset, int limit);
    void updateAuthority(String u_id, String u_authority);
    void insertSnsUser(SnsDTO snsDTO);
    void updateSnsUser(SnsDTO snsDTO);
    
}
