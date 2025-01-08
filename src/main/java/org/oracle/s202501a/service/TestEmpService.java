package org.oracle.s202501a.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.TestEmpDaoImpl;
import org.oracle.s202501a.dto.TestEmpDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class TestEmpService {

    private final TestEmpDaoImpl testEmpDaoImpl;

    public List<TestEmpDto> findAll() {
        return testEmpDaoImpl.findAll()
                .stream()
                .peek(testEmpDto -> System.out.println(testEmpDto))
                .toList();
    }
}
