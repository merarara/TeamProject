package com.project.springboot.member;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	// 회원가입
	@Autowired
	UserService userService;

	
	// 로그인 및 회원가입 페이지로 이동하는 매핑
	@RequestMapping("/user/main.do")
	public String main() {
		return "/user/main";
	}
	
	// 로그인 페이지로 이동하는 매핑
	@RequestMapping("/user/login.do")
	public String login() {
		return "/auth/login";
	}
	
	// 홈으로 이동하는 맵핑
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}
	
	// 회원가입 맵핑
	@RequestMapping("/user/join.do")
	public String join() {
		System.out.println(5);
		return "/user/join";
	}
	
	// 회원가입 폼
    @GetMapping("/signUp")
    public String signUpForm() {
        return "signup";
    }
    
    // 회원가입 처리
    @PostMapping("/user/signUp.do")
    public String signUp(@ModelAttribute UserDTO userDTO) {
    	System.out.println(1);
    	String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(userDTO.getU_Pw());
    	userDTO.setU_Pw(passwd);
    	System.out.println(userDTO.getU_Pw());
    	System.out.println(userDTO.getU_Addr1());
        userService.insertUser(userDTO);
        return "redirect:/auth/login"; // 가입 완료 페이지로 이동
    }
	
	// 로그인 맵핑
	@RequestMapping("/myLogin.do")
	public String login1(Principal principal, Model model) {
		try {
			String user_id = principal.getName();
			model.addAttribute("user_id", user_id);
			return "auth/login"; // 로그인 성공 시 main.jsp로 이동
		}
		catch (Exception e) {
			System.out.println("로그인 전입니다.");
		}
		return "auth/login";
	}
	
	
	
	@RequestMapping("/myError.do")
	public String login2() {		
		return "auth/error";
	}

	@RequestMapping("/denied.do")
	public String login3() {		
		return "auth/denied";
	}
	
	@RequestMapping("/member/test.do")
	public String test1() {
		return "member/test";
	}
}
