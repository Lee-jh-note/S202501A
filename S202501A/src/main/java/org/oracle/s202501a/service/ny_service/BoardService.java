package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;

public interface BoardService {

	int totalBoard();
	 //객체없이
	List<Board> listBoard(Board board);

}
