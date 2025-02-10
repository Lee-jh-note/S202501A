package org.oracle.s202501a.repository;

import java.util.Optional;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.entity.Emp;	
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<Emp, Long> {
	Optional<Emp> findByUsername(String username);
	Optional<Emp> findByEmpNameAndEmpEmail(String empName, String empEmail);
}
