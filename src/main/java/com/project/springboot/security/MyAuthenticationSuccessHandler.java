package com.project.springboot.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Component
public class MyAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userId = authentication.getName();
        UserDTO userDTO = userService.selectUserByNickname(userId);
        session.setAttribute("userId", userId);
        session.setAttribute("u_nick", userDTO.getU_nick());
        response.sendRedirect(request.getContextPath() + "/home.do");
    }
}
