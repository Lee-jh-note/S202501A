package org.oracle.s202501a.service.sh_service;

import java.util.List;	

import org.modelmapper.ModelMapper;
import org.oracle.s202501a.dto.sh_dto.EmpContext;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.repository.UserRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;


@Service("userDetailsService")
@RequiredArgsConstructor
// UserDetails: Spring Security에서 사용자의 정보를 담는 인터페이스
// UserDetailsService: Spring Security에서 유저의 정보를 가져오는 인터페이스
public class FormUserDetailsService implements UserDetailsService {

	private final UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	       Emp emp = userRepository.findByUsername(username);
	        if (emp == null) {
	            throw new UsernameNotFoundException("No user found with username: " + username);
	        }
	        List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority(emp.getRoles()));
	        ModelMapper mapper = new ModelMapper();
	        EmpDTO empDTO = mapper.map(emp, EmpDTO.class);
	        System.out.println("FormUserDetailsService loadUserByUsername accountDto->"+empDTO);
	        System.out.println("FormUserDetailsService loadUserByUsername authorities->"+authorities);
	        return new EmpContext(empDTO, authorities);
	}

}
