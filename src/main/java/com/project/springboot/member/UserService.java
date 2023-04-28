package com.project.springboot.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.springboot.oauth2.SnsDTO;

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

    // 회원 조회 
    @Transactional
    public UserDTO selectOne(String u_id) {
        UserDTO dto = userMapper.selectOne(u_id);
        return dto;
    }

    // 닉네임 조회
    @Transactional
    public UserDTO selectUserByNickname(String u_nickname) {
        UserDTO dto = userMapper.selectUserByNickname(u_nickname);
        return dto;
    }
    
    // 전체 회원 조회
    @Transactional
    public List<UserDTO> selectAll() {
        List<UserDTO> list = userMapper.selectAll();
        return list;
    }
    // 일반회원 조회
    @Transactional
    public List<UserDTO> selectUserlist() {
    	List<UserDTO> list = userMapper.selectUserlist();
    	return list;
    }
    // 블랙리스트 조회
    @Transactional
    public List<UserDTO> selectBlacklist() {
        List<UserDTO> list = userMapper.selectBlacklist();
        return list;
    }
    // 권한 수정
    @Transactional
    public void updateAuthority(String u_id, String u_authority) {
        userMapper.updateAuthority(u_id, u_authority);
    }

    // 재고 추가
    @Transactional
    public void addStock(String p_barcode, int quantity) {
        userMapper.addStock(p_barcode, quantity);
    }
    
    // SNS 회원가입
    @Transactional
    public void insertSnsUser(SnsDTO snsDTO) {
        userMapper.insertSnsUser(snsDTO);
    }
}
