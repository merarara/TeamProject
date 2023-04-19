package com.project.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {	
<<<<<<< HEAD
=======
	
>>>>>>> 835b5bac0541292836f38e42e97aeb48c38d4de3
	@RequestMapping("/")
	public String home() {
		return "home";
	}

}

