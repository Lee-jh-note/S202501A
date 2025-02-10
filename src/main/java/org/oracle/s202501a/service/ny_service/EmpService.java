package org.oracle.s202501a.service.ny_service;


import java.util.HashMap;
import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;


public interface EmpService {
	List<Emp>     listEmp(Emp emp); //직원 전체 조회
	int totalEmp();
	Emp detailEmp         (Long emp_No);
	
	
	int updateEmp(Emp emp); // 직원 수정
		
	int deleteEmp(Emp emp); //직원 삭제

	/*
	 * int insertEmp(Emp emp); //직원 등록
	 */	
	
	int condTotalEmp(Emp emp); //직원 검색
	
	List<Emp> listSearchEmp(Emp emp);
	
		
	Dept detailDept(Long dept_No);	//	어느 특정 부서인지
	List<Emp> empPosSelect();

	
	List<Dept> listDept(Dept dept); //	emp 리스트 상의 부서 
	List<Dept> listDept3(); //	파라미터 없는 부서 전체 리스트



	int countEmpInDept(Long dept_No);

	List<Dept> deptSelect(); //	부서 선택
	
	String deleteDept(Long dept_No); // 부서 삭제
	
	int insertDEPT(Dept dept); //부서 등록

	int updateDept(Dept dept); //부서 수정
	
	Dept deptConfirm(Long deptNo); // 부서 중복 확인


}