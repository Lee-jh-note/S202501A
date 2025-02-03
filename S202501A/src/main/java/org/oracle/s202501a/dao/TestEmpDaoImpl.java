package org.oracle.s202501a.dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.TestEmpDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class TestEmpDaoImpl implements TestEmpDao {

    private final SqlSession sqlsession;

    @Override
    public List<TestEmpDto> findAll() {
        try {
            return sqlsession.selectList("findAll");

        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e);
        }
    }

}
