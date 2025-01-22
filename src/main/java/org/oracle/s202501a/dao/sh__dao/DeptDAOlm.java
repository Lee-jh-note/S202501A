package org.oracle.s202501a.dao.sh__dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.sh_dto.DeptDTO;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class DeptDAOlm implements DeptDAO {

	  private final SqlSession session; 
	   
	@Override
	public List<DeptDTO> deptSelect() {
	      
	      List<DeptDTO> deptList = null;
	      System.out.println("DeptDaoImpl deptSelect Start..." );
	      try {
	         deptList = session.selectList("org.oracle.s202501a.mapper.DeptMapper.nySelectDept");
	      } catch (Exception e) {
	         System.out.println("DeptDaoImpl deptSelect Exception->"+e.getMessage());
	      }

	      return deptList;
	   }

	   @Override
	   public DeptDTO detailDept(Long dept_No) {
	      System.out.println("DeptDaoImpl detailDept start..");
	      System.out.println("DeptDaoImpl detailDept dept_No->"+dept_No);
	      DeptDTO dept = new DeptDTO();

	      try {
	         //
	         dept = session.selectOne("org.oracle.s202501a.mapper.DeptMapper.nylistDeptSelOne", dept_No); // #기본키여서 셀렉트원?
	         System.out.println("DeptDaoImpl detail dept->" + dept);
	      } catch (Exception e) {
	         System.out.println("DeptDaoImpl detail Exception->" + e.getMessage());
	      }
	      return dept;
	   }
}

