package org.oracle.s202501a.service.sh_service;

import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.repository.UserRepository;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

	private final UserRepository userRepository;
	
	@Transactional
	public void createUser(Emp emp) {
		System.out.println("UserRepository createUser emp->"+emp);
		userRepository.save(emp);
	}
}
