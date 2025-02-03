package org.oracle.s202501a.dao.sh__dao;

import java.util.List;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;

public interface EmpDAO {
	List<EmpDTO> empSelect();

	int insertEmp(EmpDTO emp);
	}
