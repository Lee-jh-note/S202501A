package org.oracle.s202501a.service.ny_service;

import java.util.List;	

import org.oracle.s202501a.dao.ny_dao.DeptDao;
import org.oracle.s202501a.dao.ny_dao.EmpDao;
import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpServiceImpl implements EmpService {

	private final EmpDao ed;
	private final DeptDao dd;

	@Override
	public int totalEmp() {
		System.out.println("EmpServiceImpl totalEmp Start ...");
		int totEmpCnt = ed.totalEmp();
		System.out.println("EmpServiceImpl totalEmp totEmpCnt->" + totEmpCnt);
		return totEmpCnt;
	}

	@Override
	public List<Emp> listEmp(Emp emp) {
		List<Emp> empList = null;
		System.out.println("EmpServiceImpl listEmp Start...");
		empList = ed.listEmp(emp);
		System.out.println("EmpServiceImpl listEmp empList.size()->" + empList.size());

		return empList;
	}

	@Override
	public Emp detailEmp(Long emp_No) {
		System.out.println("EmpServiceImpl detailEmp ...");
		Emp emp = null;
		emp = ed.detailEmp(emp_No);
		return emp; // 디티오 -> 컨트롤ㄹ러 -> 서비스->다오->다오임플->매퍼 <이름이나 타입 일치 중요>
	}

	@Override
	public Dept detailDept(Long dept_No) {
		System.out.println("EmpServiceImpl detailDept ...");
		Dept dept = null;
		dept = dd.detailDept(dept_No);
		return dept;
	}

	//직원 수정
	@Override
	public int updateEmp(Emp emp) {
		System.out.println("EmpServiceImpl update ...");
		int updateCount = 0;
		updateCount = ed.updateEmp(emp);
		return updateCount;
	}

	// 등록시 선택
	@Override
	public List<Dept> deptSelect() {
		List<Dept> deptList = null;
		System.out.println("EmpServiceImpl deptSelect Start...");
		deptList = dd.deptSelect();
		System.out.println("EmpServiceImpl deptSelect deptList.size()->" + deptList.size());
		return deptList;
	}

	@Override
	public List<Emp> empPosSelect() {
		List<Emp> empList = null;
		System.out.println("EmpServiceImpl empPosSelect Start...");
		Emp emp = null;
		empList = ed.empPosSelect();
		return empList;
	}

	//직원 등록
	/*
	 * @Override public int insertEmp(Emp emp) { int result = 0;
	 * System.out.println("EmpServiceImpl insert Start..."); result =
	 * ed.insertEmp(emp); return result; }
	 */
	
	//직원 삭제 (업데이트)
	@Override
	public int deleteEmp(Emp emp) {
		System.out.println("EmpServiceImpl deleteEmp Start...");
		int deleteupdate = ed.deleteEmp(emp); // DAO 호출
		if (deleteupdate > 0) {
			System.out.println("삭제 성공: emp_Delete = 1");
		} else {
			System.out.println("삭제 실패 또는 이미 삭제된 직원");
		}
		return deleteupdate;
	}

	// 밑 2개가 조건 검색
	@Override
	public int condTotalEmp(Emp emp) {
		System.out.println("EmpServiceImpl Start total...");
		int totEmpCnt = ed.condTotalEmp(emp);
		System.out.println("EmpServiceImpl totalEmp totEmpCnt->" + totEmpCnt);
		return totEmpCnt;
	}

	@Override
	public List<Emp> listSearchEmp(Emp emp) {
		List<Emp> empSearchList = null;
		System.out.println("EmpServiceImpl listEmp Start...");
		empSearchList = ed.empSearchList3(emp);
		System.out.println("EmpServiceImpl listSearchEmp empSearchList.size()->" + empSearchList.size());
		return empSearchList;
	}

	// 부서 삭제
	@Override
	@Transactional
	public String deleteDept(Long dept_No) {
		
		  System.out.println("DeptServiceImpl deleteDept Start...");

	        // 부서에 직원이 있는지 먼저 확인
	        int empCount = countEmpInDept(dept_No);
	        if (empCount > 0) {
	            return "삭제할 수 없습니다 " + empCount + " 명의 직원이 있습니다.";
	        }
	        // 직원이 없으면 부서 삭제 실행
	        int result = dd.deleteDept(dept_No);
	        if (result > 0) {
	            return "부서가 성공적으로 삭제 되었습니다 (부서 직원0 명)";
	        } else {
	            return "삭제에 실패했습니다.";
	        }}
	
	// 부서에 있는 직원의 수 세기
	@Override
	public int countEmpInDept(Long dept_No) {
		return dd.countEmpInDept(dept_No);
	}

	// emp에서 부서 선택시 리스트
	@Override
	public List<Dept> listDept(Dept dept) {
		List<Dept> deptList = null;
		System.out.println("EmpServiceImpl listdept Start...");
		deptList = dd.listDept(dept);
		System.out.println("EmpServiceImpl listdept empList.size()->" + deptList.size());
		return deptList;
	}

	// 부서 리스트 //등록 시 여기로 온다 => 근데 중복임
	@Override
	public List<Dept> listDept3() {
		List<Dept> deptList = null;
		System.out.println("EmpServiceImpl listdept Start...");
		deptList = dd.listDept3();
		System.out.println("EmpServiceImpl listdept empList.size()->" + deptList.size());
		return deptList;
	}
	
 // 부서 등록
	@Override
	public int insertDEPT(Dept dept) {
		int result = 0;
		System.out.println("EmpServiceImpl insertDEPT Start...");
		result = dd.insertDept(dept);
		return result;
		
	}
// 부서 수정
	@Override
	public int updateDept(Dept dept) {
		System.out.println("DeptServiceImpl update ...");
		int updateDeptCount = 0;
		updateDeptCount = dd.updateDept(dept);
		return updateDeptCount;

	}

}

