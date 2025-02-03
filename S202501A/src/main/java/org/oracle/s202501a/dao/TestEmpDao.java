package org.oracle.s202501a.dao;

import org.oracle.s202501a.dto.TestEmpDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface TestEmpDao {
    List<TestEmpDto> findAll();
}
