package org.oracle.s202501a.chat;

import lombok.RequiredArgsConstructor;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ChatController {

   private final UserService userService;

   @RequestMapping("/chat")
   public ModelAndView chat() {
      System.out.println("ChatController chat Start...");
      ModelAndView mv = new ModelAndView();
      EmpDTO empDTO = userService.getSe();
      String ename = empDTO.getEmpName();
      mv.addObject("empName", ename);
      mv.setViewName("sh_views/chatView");
      return mv;
   }
}
