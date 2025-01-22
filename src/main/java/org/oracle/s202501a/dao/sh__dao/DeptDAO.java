package org.oracle.s202501a.dao.sh__dao;

import java.util.List;

import org.oracle.s202501a.dto.sh_dto.DeptDTO;


public interface DeptDAO {
 List<DeptDTO> deptSelect();

DeptDTO   detailDept(Long dept_No);


}
