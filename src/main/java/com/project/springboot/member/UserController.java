package com.project.springboot.member;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
	@Autowired
	private UserMapper userMapper;
	
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
    	String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(userDTO.getU_pw());
    	userDTO.setU_pw(passwd);
    	System.out.println(userDTO.getU_pw());
    	System.out.println(userDTO.getU_addr1());
        userService.insertUser(userDTO);
        return "/auth/login"; // 가입 완료 페이지로 이동
    }
	
    @RequestMapping("/myLogin.do")
    public String login1(Principal principal, Model model, HttpServletRequest request) {
    	try {
    		String user_id = principal.getName();
    		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	    String id = authentication.getName(); // 사용자 id

    	    request.getSession().setAttribute("userId", id); // 세션에 사용자 id 저장
    		model.addAttribute("user_id", user_id);
    		return "home"; // 로그인 성공 시 home.jsp로 이동
    	}
    	catch (Exception e) {
    		System.out.println("로그인 전입니다.");
    	}
    	return "auth/login";
    }

	// 로그아웃 
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 세션 무효화
        SecurityContextHolder.clearContext(); // SecurityContext 제거
        return "redirect:/user/login.do?logout=true"; // 로그인 페이지로 이동하며 로그아웃 메시지 전달
    }
    
    // 회원 정보 수정 폼
 	@GetMapping("/user/edit.do")
 	public String editForm(Model model) {
 		// 로그인된 사용자의 인증 정보를 가져옵니다.
 		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
 		String userId = auth.getName();
 		System.out.println(userId);
 		// 회원 정보를 조회합니다.
// 		UserDTO userDTO = userService.getUserById(userId);
// 		model.addAttribute("userDTO", userDTO);
//
// 		return "user/edit";
 		
 		UserDTO dto = userService.selectone(userId);
 		
 		model.addAttribute("uinfo", dto);

 		return "/user/edit";
 	}

 	// 회원 정보 수정 처리
 	@PostMapping("/user/edit.do")
 	public String edit(@ModelAttribute UserDTO userDTO) {
 		// 수정된 회원 정보를 업데이트합니다.
 		userMapper.updateUser(userDTO);

 		return "redirect:/home.do";
 	}
    
    
    
    
 // 회원탈퇴 페이지로 이동하는 매핑
    @RequestMapping("/user/delete.do")
    public String deleteForm() {
        return "/user/delete";
    }

    // 회원탈퇴 처리
    @PostMapping("/user/delete.do")
    public String delete(HttpServletRequest request, Model model) {
        try {
            // 로그인된 사용자의 인증 정보를 가져옵니다.
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String userId = auth.getName();
            System.out.println(111);
            System.out.println(userId);
            // 회원정보를 삭제합니다.
            UserDTO userDTO = new UserDTO();
            userDTO.setU_id(userId);
            userService.deleteUser(userDTO.getU_id());

            // 세션 무효화 및 SecurityContext 제거
            request.getSession().invalidate();
            SecurityContextHolder.clearContext();

            model.addAttribute("message", "회원탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
            return "/auth/login";
        } catch (Exception e) {
            model.addAttribute("error", "회원탈퇴 중 오류가 발생했습니다.");
            return "/user/delete";
        }
    }



	
	
	@RequestMapping("/myError.do")
	public String login2() {		
		return "auth/error";
	}
}
