package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.ui.Model;

public interface BoardDao {
	List<Board> listBoard(Board board);
	int totalBoard();
	Board contents(Long board_No);
	int updateBoard(Board board);
	int deleteBoard(Long board_No);
	int insertBoard(Board board);
	
    List<Board> listReply(Board board); // 댓글 리스트
	int breply(Board board);
	int updateReply(Board board);
	int deleteReply(Long board_No);
	void increaseHit(Long board_No);
	


}
