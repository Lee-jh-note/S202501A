package org.oracle.s202501a.controller.sh_controller;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;	
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {

	@GetMapping(value = "/login" )
	public String login(
			@RequestParam(value = "error" , required = false) String error,
			@RequestParam(value = "exception" , required = false ) String exception,
			Model model
			) {
			System.out.println("LoginController login start...");
	       	model.addAttribute("error",error);
	        model.addAttribute("exception",exception);
		
		return "sh_views/loginPage";

	}
	
    @GetMapping(value="/writeFormEmp")
    public String signup() {
        return "sh_views/writeFormEmp";
    }

    @GetMapping(value = "/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication authentication = SecurityContextHolder.getContextHolderStrategy().getContext().getAuthentication();
        System.out.println("LoginController logout authentication->"+authentication);
        if (authentication != null) {
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }

        return "redirect:/login";
    }

    @GetMapping(value="/denied")
    public String accessDenied(@RequestParam(value = "exception", required = false) String exception, 
    		                   @AuthenticationPrincipal EmpDTO empDTO, 
    		                   Model model) {
    	
        System.out.println("LoginController accessDenied accountDto->"+empDTO);
        System.out.println("LoginController accessDenied exception->"+exception);

        model.addAttribute("username", empDTO.getUsername());
        model.addAttribute("exception", exception);

        return "sh_views/denied";
    }
	
	
	
	
	
	
	
}
