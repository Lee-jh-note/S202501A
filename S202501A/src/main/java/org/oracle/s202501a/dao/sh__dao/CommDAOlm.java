package org.oracle.s202501a.dao.sh__dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.sh_dto.CommDto;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommDAOlm implements CommDAO {
	private final SqlSession session;

	
	// role->100
	@Override
	public List<CommDto> roleSelect(int bcd) {
		List<CommDto> roleList = null;
		System.out.println("CommDaolm roleSelect Start...");
		System.out.println("CommDaolm roleSelect bcd->"+bcd);
		try {
			roleList = session.selectList("shCommSelect", bcd);
		} catch (Exception e) {
			System.out.println("CommDaolm roleSelect Exception->"+e.getMessage());
		}
		return roleList;
	}

}
