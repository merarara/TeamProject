package com.project.springboot.oauth2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.springboot.member.UserService;

@Controller
public class SnsJoinController {

    @Autowired
    private UserService userService;

    @GetMapping("/snsjoin")
    public String snsJoin(@AuthenticationPrincipal DefaultOAuth2User oauth2User, Model model) {
        String email = oauth2User.getAttribute("email");
        // SNS 제공자로부터 이메일을 가져와서 모델에 담아둔다.
        model.addAttribute("email", email);
        return "user/snsjoin";
    }
    
    @PostMapping("/snsjoin")
    public String snsJoinPost(SnsDTO snsDTO) {
    	userService.insertSnsUser(snsDTO);
        return "redirect:/";
    }
    
    
}

