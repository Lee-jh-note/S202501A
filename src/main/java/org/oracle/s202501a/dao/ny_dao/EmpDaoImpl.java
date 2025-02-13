package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpDaoImpl implements EmpDao {

	private final SqlSession session;

	@Override
	public int totalEmp() {
		int totEmpCount = 0;
		System.out.println("EmpDaoImpl Start totalEmp...");
		try {
			totEmpCount = session.selectOne("nytotalEmp");
			System.out.println("EmpDaoImpl totalEmp totEmpCount->" + totEmpCount);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl totalEmp e.getMessage()->" + e.getMessage());
		}

		return totEmpCount;
	}

	
	
	@Override
	public List<Emp> listEmp(Emp emp) {
		List<Emp> empList = null;
		System.out.println("EmpDaoImpl listEmp Start ...");
		try {
			//
			empList = session.selectList("nylistEmp", emp);
			System.out.println("EmpDaoImpl listEmp empList.size()->" + empList.size());
			System.out.println("EmpDaoImpl listEmp empList->" + empList);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl listEmp e.getMessage()->" + e.getMessage());
		}
		return empList;

	}
	
	
	
	
	//직원 상세조회
	@Override
	public Emp detailEmp(Long emp_No) {
		System.out.println("EmpDaoImpl detail start..");
		Emp emp = new Emp();

		try {
			//
			emp = session.selectOne("nylistEmpSelOne", emp_No); // #기본키여서 셀렉트원?
			System.out.println("EmpDaoImpl detail emp->" + emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl detail Exception->" + e.getMessage());
		}
		return emp;
	}
	
	
	
	
	//직원 수정
	@Override
	public int updateEmp(Emp emp) {
		System.out.println("EmpDaoImpl update start..");
		System.out.println("다오 업데이트" +emp);
		int updateCount = 0;
		try {
			updateCount = session.update("nyUpdateEmp", emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl updateEmp Exception->" + e.getMessage());
		}
		return updateCount;
	}
	
	
	
	// 유저 컨트롤러 동일
	//직원 등록
	/*
	 * @Override public int insertEmp(Emp emp) { int result = 0;
	 * System.out.println("EmpDaoImpl insert Start..."); String password = ""; try {
	 * System.out.println("EmpDaoImpl insert emp->"+emp); password =
	 * emp.getDept_Name(); // emp.setPassword(password); // 입력시 EMP_NO_SEQ.nextv
	 * 직원번호 자동 생성 (ID 자동 생성) // 부서이름+ 생년월일 => password (비밀번호 자동 생성) //
	 * emp.setPassword("HR"); result = session.insert("nyinsertEmp", emp); } catch
	 * (Exception e) { System.out.println("EmpDaoImpl insert Exception->" +
	 * e.getMessage()); } return result;
	 * 
	 * }
	 */
	
	@Override
	public List<Emp> empPosSelect() {
		List<Emp> empList = null;
		System.out.println("DeptDaoImpl empPosSelect Start..." );
		try {
			empList = session.selectList("nySelectPos");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl empPosSelect Exception->"+e.getMessage());
		}

		return empList;
	}

	
	//직원 삭제
	@Override
	public int deleteEmp(Emp emp) {
		System.out.println("EmpDaoImpl delete start..");
		int deleteupdate = 0;
		System.out.println("EmpDaoImpl delete empno->" + emp);
		try {
			deleteupdate = session.update("nyDelteUpdateEmp", emp);
			System.out.println("EmpDaoImpl delete result->" + deleteupdate);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl delete Exception->" + e.getMessage());
		}

		return deleteupdate;
	}

	
	// 직원 검색
	@Override
	public int condTotalEmp(Emp emp) {
		int totEmpCount = 0;
		System.out.println("EmpDaoImpl Start condTotalEmp...");

		try {
			totEmpCount = session.selectOne("nycondEmpTotal", emp);

			System.out.println("EmpDaoImpl totalEmp totEmpCount->" + totEmpCount);

		} catch (Exception e) {
			System.out.println("EmpDaoImpl totalEmp Exception->" + e.getMessage());
		}
		return totEmpCount;
	}

	
	@Override
	public List<Emp> empSearchList3(Emp emp) {
		List<Emp> empSearchList3 = null;
		System.out.println("EmpDaoImpl empSearchList3 Start ...");
		try {
			empSearchList3 = session.selectList("nySearchListEmp", emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl listEmp Exception->" + e.getMessage());
		}
		return empSearchList3;
	}



	@Override
	public Emp empConfirm(String emp_Name) {
		 Emp emp = new Emp();
		    try {
		    	emp = session.selectOne("nyempConfirm", emp_Name);
		      } catch (Exception e) {
		         System.out.println("EmpDaoImpl empConfirm Exception->"+e.getMessage());
		      }
		return emp;
	}

}

