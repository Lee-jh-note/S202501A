package org.oracle.s202501a.repository;

import org.oracle.s202501a.entity.Emp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<Emp, Long> {
	Emp findByUsername(String username);
}
