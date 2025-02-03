package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;

public interface BoardDao {
	List<Board> listBoard(Board board);
	int totalBoard();
	Board contents(Long board_No);
	int updateBoard(Board board);
	int deleteBoard(Long board_No);
	int insertBoard(Board board);


}
