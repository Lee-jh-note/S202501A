package org.oracle.s202501a.controller.sh_controller;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.sh_service.FormUserDetailsService;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;	
	import org.springframework.security.core.context.SecurityContext;
	import org.springframework.security.core.context.SecurityContextHolder;
	import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {

	private final UserService f;
	
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
	
	@GetMapping("/my-profile")
	public String getMyProfile(Model model) {
		EmpDTO dto = f.getSe();
		model.addAttribute("Dto", dto);
	    return "sh_views/main";
	   }
	
		@ResponseBody
		@GetMapping("header")
		public EmpDTO header() {
			// 예: 세션에서 EmpDTO를 얻거나, DB 조회 등을 통해 가져옴
			EmpDTO dto = f.getSe();
			
			// (필요에 따라 DTO가 null일 경우 예외 처리 or 기본값 설정)
			if (dto == null) {
				dto = new EmpDTO();
				dto.setEmp_No(0L);
				dto.setEmp_Name("비로그인");
			}
			
			System.out.printf("AJAX로 요청 받은 EmpDTO: {}", dto);
			return dto;  // JSON 형태로 반환
		}
}
