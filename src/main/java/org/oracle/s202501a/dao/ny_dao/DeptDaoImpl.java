package org.oracle.s202501a.dao.ny_dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Dept;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeptDaoImpl implements DeptDao {

	private final SqlSession session; 

	
	@Override  //11 컨트롤writeFormEmp
	public List<Dept> deptSelect() {
		
		List<Dept> deptList = null;
		System.out.println("DeptDaoImpl deptSelect Start..." );
		try {
			deptList = session.selectList("ny11SelectDept");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl deptSelect Exception->"+e.getMessage());
		}

		return deptList;
	}


	@Override
	public Dept detailDept(Long dept_No) {
		System.out.println("DeptDaoImpl detailDept start..");
		System.out.println("DeptDaoImpl detailDept dept_No->"+dept_No);
		Dept dept = new Dept();

		try {
			//
			dept = session.selectOne("nylistDeptSelOne", dept_No); // #기본키여서 셀렉트원?
			System.out.println("DeptDaoImpl detail dept->" + dept);
		} catch (Exception e) {
			System.out.println("DeptDaoImpl detail Exception->" + e.getMessage());
		}
		return dept;
	}

	//11 부서 선택시 리스트
	@Override
	public List<Dept> listDept(Dept dept) {
		List<Dept> deptList = null;
		System.out.println("DeptDaoImpl deptSelect Start..." );
		try {
			deptList = session.selectList("ny11SelectDept");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl deptSelect Exception->"+e.getMessage());
		}
		return deptList;
	}

	//부서 삭제
	@Override
	public int deleteDept(Long dept_No) {
		System.out.println("EmpDaoImpl deleteDept start..");
		int result = 0;
		System.out.println("EmpDaoImpl deleteDept dept_No->"+dept_No);
		try {
			result  = session.delete("nydeleteDept", dept_No);
			System.out.println("EmpDaoImpl deleteDept result->"+result);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl deleteDept Exception->"+e.getMessage());
		} 

		return result;
	}
	// 부서 삭제 시 팝업
	@Override
	public int countEmpInDept(Long dept_No) {
		 int count = 0;
		    try {
		        count = session.selectOne("nycountEmpInDept", dept_No);
		        System.out.println("EmpDaoImpl countEmpInDept count->" + count);
		    } catch (Exception e) {
		        System.out.println("EmpDaoImpl countEmpInDept Exception->" + e.getMessage());
		    }
		    return count;
	}

	// 11 부서 전체 보이게
	@Override
	public List<Dept> listDept3() {
		List<Dept> deptList = null;
		System.out.println("DeptDaoImpl deptSelect Start..." );
		try {
			deptList = session.selectList("ny11SelectDept");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl deptSelect Exception->"+e.getMessage());
		}
		return deptList;
	}


	@Override
	public int insertDept(Dept dept) {
		int result = 0;
		System.out.println("DeptDaoImpl insertDept Start...");
		try {
			System.out.println("DeptDaoImpl insertDept Dept->"+dept);
			result = session.insert("nyinsertDept", dept);
		} catch (Exception e) {
			System.out.println("DeptDaoImpl insertDept Exception->" + e.getMessage());
		}
		return result;
	}


	@Override
	public int updateDept(Dept dept) {
		System.out.println("DeptDaoImpl update start..");
		// 05마이바티스 파일 : 셀렉트는 셀렉트 된 값을 반환
		int updateDeptCount= 0;
		try {
			updateDeptCount = session.update("nyDeptUpdate",dept);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl updateEmp Exception->"+e.getMessage());
		}
		return updateDeptCount;
	}





}
