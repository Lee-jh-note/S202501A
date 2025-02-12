package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;

public interface EmpDao {
	int totalEmp();
	List<Emp> listEmp(Emp emp);
	Emp detailEmp(Long emp_No);
	int updateEmp(Emp emp);
	/* int insertEmp(Emp emp); */ // 유저 컨트롤러 동일
	int deleteEmp(Emp emp); 
	int condTotalEmp(Emp emp);
	List<Emp> empSearchList3(Emp emp);
	List<Emp> empPosSelect();
	Emp empConfirm(String emp_Name);
	
	
}
