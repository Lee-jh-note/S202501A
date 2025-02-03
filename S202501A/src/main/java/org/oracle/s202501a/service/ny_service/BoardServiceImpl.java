package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dao.ny_dao.BoardDao;
import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDao bd;
	
	@Override
	public int totalBoard() {
		System.out.println("BoardServiceImpl totalBoard Start ...");
		int totBoardCnt = bd.totalBoard();
		System.out.println("BoardServiceImpl totalBoard totBoardCnt->" + totBoardCnt);
		return totBoardCnt;
	}


	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("BoardServiceImpl listBoard Start...");
		boardList = bd.listBoard(board);
		System.out.println("BoardServiceImpl listBoard boardList.size()->" + boardList.size());

		return boardList;
	}



}
