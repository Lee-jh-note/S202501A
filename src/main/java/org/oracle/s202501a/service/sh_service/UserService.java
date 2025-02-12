package org.oracle.s202501a.service.sh_service;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;	
import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.repository.UserRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	
	private final UserRepository userRepository;

	   
	@Transactional
	public void createUser(Emp emp) {
		System.out.println("UserRepository createUser emp->"+emp);
		userRepository.save(emp);
	}
	
	public EmpDTO getSe() {

	      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	      
	      //UserDTO로 변환
	      EmpDTO dto = (EmpDTO) authentication.getPrincipal();
	      System.out.println("user detail->"+dto);
	      return dto;
	      }





	

	





	
		
	      
}
