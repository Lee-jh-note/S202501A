package org.oracle.s202501a.controller.sh_controller;

	import org.springframework.security.core.Authentication;	
	import org.springframework.security.core.context.SecurityContext;
	import org.springframework.security.core.context.SecurityContextHolder;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping(value = "/")
	public String home() {
	   	System.out.println("HomeController home  Start...");
    	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
    	Authentication authentication = securityContext.getAuthentication();
    	System.out.println("HomeController home authentication->"+authentication);
		return "sh_views/main";

    }
	
	
	@GetMapping(value="/Sales")
	public String user() {
    	System.out.println("HomeController Sales Start...");
		return "sh_views/Sales";
	}

	@GetMapping(value="/Logistics")
	public String manager() {
    	System.out.println("HomeController Logistics Start...");
		return "sh_views/Logistics";
	}

	@GetMapping(value="/HR")
	public String admin() {
    	System.out.println("HomeController HR Start...");
		return "sh_views/HR";
	}
	

}
