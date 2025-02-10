package org.oracle.s202501a.chat;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {

	@RequestMapping("/chat")
	public ModelAndView chat() {
		System.out.println("ChatController chat Start...");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("sh_views/chatView");
		return mv;
	}
}
