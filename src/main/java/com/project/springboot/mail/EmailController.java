package com.project.springboot.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EmailController {
	
	@Autowired
	EmailService emailService;
	
	
	@PostMapping("/emailConfirm")
	@ResponseBody
	public String emailConfirm(@RequestParam String email1, @RequestParam String email2) throws Exception {

	  String confirm = emailService.sendSimpleMessage(email1 + "@" +  email2);

	  return confirm;
	}
	
	// 이메일 인증 성공 및 실패 처리
	@GetMapping("/emailConfirmPage")
	public String emailConfirmPage(@RequestParam String confirm, Model model) {
	  model.addAttribute("confirm", confirm);
	  return "emailConfirmPage";
	}

	@PostMapping("/emailConfirmPage")
	public String emailConfirm(@RequestParam String userConfirm, Model model, String ePw) {
	  
		if (ePw.equals(userConfirm)) {
	    // 인증 성공 처리
	    return "successPage";
	  } else {
	    // 인증 실패 처리
	    model.addAttribute("message", "인증코드가 일치하지 않습니다.");
	    return "emailConfirmPage";
	  }
	}

}
