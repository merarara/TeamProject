package com.project.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    void insertUser(UserDTO userDTO);
    void insertSnsUser(UserDTO userDTO);
    void updateUser(UserDTO userDTO);
    void deleteUser(String u_id);
    UserDTO selectOne(String u_id);
    // 회원 아이디로 회원 정보 조회 
    public List<UserDTO> searchUser(String searchId);
    UserDTO selectUserByNickname(String u_nick);
    int selectTotalCount();
    List<UserDTO> selectAll(@Param("offset") int offset, @Param("limit") int limit, @Param("searchId") String searchId);
    List<UserDTO> selectBlacklist(@Param("offset") int offset, @Param("limit") int limit, @Param("searchId") String searchId);
    List<UserDTO> selectUserlist(@Param("offset") int offset, @Param("limit") int limit, @Param("searchId") String searchId);
    void updateAuthority(String u_id, String u_authority);
}
