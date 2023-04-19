package com.project.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.cboard.ListController;

@Controller
<<<<<<< HEAD
public class MainController {

=======
public class MainController {	
	
>>>>>>> 345f146571b02e0857fbd67d6575edec0ebfefd4
	@RequestMapping("/")
	public String home() {
		return "home";
	}

}

