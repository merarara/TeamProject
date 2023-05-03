package com.project.springboot.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;
    // 이메일 인증
    @Autowired
    private JavaMailSender javaMailSender;
    
    public void sendEmail(String toEmail, String subject, String body) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("sender-email@example.com"); // 발신자 이메일 주소
        message.setTo(toEmail); // 수신자 이메일 주소
        message.setSubject(subject); // 이메일 제목
        message.setText(body); // 이메일 본문

        javaMailSender.send(message); // 이메일 보내기
    }

    // 회원가입
    @Transactional
    public void insertUser(UserDTO userDTO) {
        userMapper.insertUser(userDTO);
    }
    // sns 회원가입
    @Transactional
    public void insertSnsUser(UserDTO userDTO) {
    	userMapper.insertSnsUser(userDTO);
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
    // 회원 검색 
    @Transactional(readOnly = true)
    public List<UserDTO> searchUser(String searchId) {
        List<UserDTO> userList = userMapper.searchUser(searchId);
        return userList;
    }

    // 닉네임 조회
    @Transactional
    public UserDTO selectUserByNickname(String u_nick) {
        UserDTO dto = userMapper.selectUserByNickname(u_nick);
        return dto;
    }
    
    // 전체 회원 조회 (페이징 처리)
    @Transactional
    public List<UserDTO> selectAll(int offset, int limit, String searchId) {
        return userMapper.selectAll(offset, limit, searchId);
    }
    @Transactional
    public int selectTotalCount() {
        return userMapper.selectTotalCount();
    }

    // 일반회원 조회
    @Transactional
    public List<UserDTO> selectUserlist(int offset, int limit, String searchId) {
    	return userMapper.selectUserlist(offset, limit, searchId);
    }
    @Transactional
    public int selectUserCount() {
        return userMapper.selectTotalCount();
    }
    
    // 블랙리스트 조회
    @Transactional
    public List<UserDTO> selectBlacklist(int offset, int limit, String searchId) {
    	return userMapper.selectBlacklist(offset, limit, searchId);
    }
    @Transactional
    public int selectBlackCount() {
        return userMapper.selectTotalCount();
    }
    // 권한 수정
    @Transactional
    public void updateAuthority(String u_id, String u_authority) {
        userMapper.updateAuthority(u_id, u_authority);
    }
}
