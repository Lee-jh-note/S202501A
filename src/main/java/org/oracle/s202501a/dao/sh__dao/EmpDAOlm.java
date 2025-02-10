package org.oracle.s202501a.dao.sh__dao;

import java.util.List;		

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpDAOlm implements EmpDAO {
	private final SqlSession session;
	
	@Override
	public List<EmpDTO> empSelect() {
		List<EmpDTO> empList = null;
		System.out.println("EmpDaolm empSelect Start...");
		try {
			empList = session.selectList("org.oracle.s202501a.mapper.ClientMapper.getEmpList");
		} catch (Exception e) {
			System.out.println("EmpDaolm empSelect Exception->"+e.getMessage());
		}
	
	return empList;

	}

	@Override
	   public int insertEmp(EmpDTO emp) {
	      int result = 0;
	      System.out.println("EmpDaoImpl insert Start...");
	      String password = "";
	      try {
	         System.out.println("EmpDaoImpl insert emp->"+emp);
	         password =  emp.getDept_Name();
	         // emp.setPassword(password);
	         // 입력시 EMP_NO_SEQ.nextv 직원번호 자동 생성 (ID 자동 생성)
	         // 부서이름+ 생년월일 => password (비밀번호 자동 생성)
	         // emp.setPassword("HR");
	         result = session.insert("org.oracle.s202501a.mapper.empMapper.nyinsertEmp", emp);
	      } catch (Exception e) {
	         System.out.println("EmpDaoImpl insert Exception->" + e.getMessage());
	      }
	      return result;

	   }
}