package org.oracle.s202501a.dao.ny_dao;


import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;



public interface DeptDao {
	List<Dept> deptSelect();
	Dept detailDept(Long dept_No);
	List<Dept> listDept(Dept dept);
	List<Dept> listDept3();
	int deleteDept(Long dept_No);
	int countEmpInDept(Long dept_No);
	int insertDept(Dept dept);
	int updateDept(Dept dept);
	Dept deptConfirm(Long deptNo);
}
