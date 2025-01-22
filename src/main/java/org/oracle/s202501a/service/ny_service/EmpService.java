package org.oracle.s202501a.service.ny_service;


import java.util.HashMap;
import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;


public interface EmpService {
	 List<Emp>     listEmp(Emp emp); //직원 전체 조회

	int totalEmp();
	Emp detailEmp         (Long emp_No);
	int updateEmp(Emp emp);

	List<Dept> deptSelect(); //	부서 선택
	int insertEmp(Emp emp);
	int deleteEmp(Emp emp);

	int condTotalEmp(Emp emp);

	List<Emp> listSearchEmp(Emp emp);
	/*List<Emp> listEmpDept(); */
	
	
	Dept detailDept(Long dept_No);	//	특정 어느부서인지
	List<Emp> empPosSelect();

	
	List<Dept> listDept(Dept dept); //	emp리스트 상의 부서 
	List<Dept> listDept3(); //	파라미터 없는 부서 전체 리스트

	String deleteDept(Long dept_No); // 부서 삭제

	int countEmpInDept(Long dept_No);

	int insertDEPT(Dept dept); //부서 등록

	int updateDept(Dept dept);



	/* void insertDept(DeptVO deptVO); */


}