package com.project.springboot.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
public class MyAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        String errorMsg = "";
        // sns
        String loginid = request.getParameter("j_username");

        if (exception instanceof BadCredentialsException) {
            // sns
            loginFailureCount(loginid);
            errorMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.(1)";
        } else if (exception instanceof InternalAuthenticationServiceException) {
            // sns
            loginFailureCount(loginid);
            errorMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.(2)";
        } else if (exception instanceof DisabledException) {
            errorMsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.(3)";
        } else if (exception instanceof CredentialsExpiredException) {
            errorMsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.(4)";
        }

        // sns 비밀번호를 3번 이상 틀릴 시 계정 잠금 처리
        loginFailureCount(loginid);

        // 에러 메시지와 함께 로그인 페이지로 redirect
        request.setAttribute("username", loginid);
        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/myLogin.do?error").forward(request, response);
    }

    // sns 비밀번호를 3번 이상 틀릴 시 계정 잠금 처리
    protected void loginFailureCount(String username) {
        /*
        // 틀린 횟수 업데이트
        userDao.countFailure(username);
        // 틀린 횟수 조회
        int cnt = userDao.checkFailureCount(username);
        if(cnt==3) {
            // 계정 잠금 처리
            userDao.disabledUsername(username);
        }
        */
    }
}



