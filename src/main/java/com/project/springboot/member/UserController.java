package com.project.springboot.member;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	
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
	
	// 내정보로 이동하는 맵핑
	@RequestMapping("/user/myinfo.do")
	public String myinfo() {
		return "/user/myinfo";
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
    public String signUp(@ModelAttribute UserDTO userDTO, HttpServletRequest req) {
        // 이메일 직접입력 시 파라미터로 받겨준다.
        String email1 = req.getParameter("email1");
        String email2 = req.getParameter("email2");
        String u_email = email1 + "@" + email2;
        userDTO.setU_email(u_email);
        String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(userDTO.getU_pw());
        userDTO.setU_pw(passwd);
        userService.insertUser(userDTO);
        return "redirect:/auth/login"; // 가입 완료 페이지로 이동
    }
    
    // 아이디 중복
    @PostMapping("/user/checkId")
    @ResponseBody
    public Map<String, String> checkId(@RequestParam("u_id") String u_id) {
        Map<String, String> resultMap = new HashMap<>();
        UserDTO existingUser = userService.selectOne(u_id);
        
        if (existingUser == null) {
        	resultMap.put("duplicate", "unexist");
        } else {
            resultMap.put("duplicate", "exist");
            System.out.println(1);
        }
        return resultMap;
    }
    // 닉네임 중복
    @PostMapping("/user/checkNick")
    @ResponseBody
    public Map<String, String> checkNick(@RequestParam("u_nick") String u_nick) {
    	Map<String, String> resultMap = new HashMap<>();
    	UserDTO existingUser = userService.selectOne(u_nick);
    	
    	if (existingUser == null) {
    		resultMap.put("duplicate", "unexist");
    	} else {
    		resultMap.put("duplicate", "exist");
    		System.out.println(1);
    	}
    	return resultMap;
    }

    // 로그인
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
 		UserDTO dto = userService.selectOne(userId);
 		model.addAttribute("uinfo", dto);
 		
 		return "/user/edit";
 	}

 	// 회원 정보 수정 처리
 	@PostMapping("/user/edit.do")
 	public String edit(@ModelAttribute UserDTO userDTO) {
 		// 수정된 회원 정보를 업데이트합니다.
 		String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(userDTO.getU_pw());
    	userDTO.setU_pw(passwd);
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
    
    @GetMapping("/admin/adminPage.do")
    public String showAdminPage(Model model) {
        return "/admin/adminPage";
    }
    // ADMIN 회원관리
    @GetMapping("/admin/userManagement.do")
    public String userManagement(Model model) {

        return "/admin/userManagement";
    }
    
    // 회원전체조회
    @GetMapping("/users")
    @ResponseBody
    public List<UserDTO> showAllUsers() {
        List<UserDTO> userList = userService.selectAll();
        return userList;
    }
    
    // 블랙리스트조회
    @GetMapping("/blackusers")
    @ResponseBody
    public List<UserDTO> selectBlacklist() {
        List<UserDTO> userList = userService.selectBlacklist();
        return userList;
    }
    // 일반리스트조회
    @GetMapping("/basicusers")
    @ResponseBody
    public List<UserDTO> selectUserlist() {
    	List<UserDTO> userList = userService.selectUserlist();
    	return userList;
    }
    
    // 전체권한관리 
 	@RequestMapping("/admin/totalAuthority.do")
 	public String totalAuthority() {
 		System.out.println(5);
 		return "/admin/totalAuthority";
 	}
 	
 	// 권한 수정
    @RequestMapping(value="/updateAuthority", method=RequestMethod.POST)
    public String updateAuthority(@RequestParam("u_id") String u_id, @RequestParam("u_authority") String u_authority, Model model) {
    	System.out.println(u_authority);
        userService.updateAuthority(u_id, u_authority);
        // 권한 수정하고 관리 페이지로 넘어가서 확인하기.
        return "redirect:/admin/userManagement.do";
    }
    
	@RequestMapping("/myError.do")
	public String login2() {		
		return "auth/error";
	}
}
