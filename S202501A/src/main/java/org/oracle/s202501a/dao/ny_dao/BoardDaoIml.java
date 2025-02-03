package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoIml implements BoardDao{
	private final SqlSession session; 
	
	//보드 리스트 
	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("DeptDaoImpl deptSelect Start..." );
		try {
			boardList = session.selectList("nylistBoard", board);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl boardSelect Exception->"+e.getMessage());
		}
		return boardList;
	}

	@Override
	public int totalBoard() {
		int totBoardCount = 0;
		System.out.println("BoardDaoImpl Start totalEmp...");
		try {
			totBoardCount = session.selectOne("nytotalBoard");
			System.out.println("BoardDaoImpl totalBoard totBoardCount->" + totBoardCount);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl totalBoard e.getMessage()->" + e.getMessage());
		}

		return totBoardCount;
	}
	
	
	
	
	
	
	
	
	
	
}
