package org.oracle.s202501a.controller.sh_controller;

import org.oracle.s202501a.dto.sh_dto.DeptDTO;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.service.sh_service.ClientService;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.modelmapper.ModelMapper;	

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {
	private final UserService userService;
	private final ClientService cs;

	private final PasswordEncoder passwordEncoder;
	
	@PostMapping(value = "/writeFormEmp3")
	public String signup(EmpDTO empDto) {
		System.out.println("UserController @PostMapping signup start... ");
		System.out.println("UserController @PostMapping signup empDto 1->"+empDto);
	    DeptDTO dept = cs.detailDept(empDto.getDept_No());

	    String passwd = dept.getDept_Name() + empDto.getBirth().replace("-","");
	    System.out.println("EmpController writeEmp passwd->" + passwd);
	    empDto.setPassword(passwd);

		ModelMapper mapper = new ModelMapper();
		Emp emp = mapper.map(empDto, Emp.class);
		// accountDto password Encoder
		emp.setPassword(passwordEncoder.encode(empDto.getPassword()));
		System.out.println("UserController @PostMapping signup accountDto2 emp->"+emp);
		userService.createUser(emp);
		
		return "redirect:/";
		

	}
}