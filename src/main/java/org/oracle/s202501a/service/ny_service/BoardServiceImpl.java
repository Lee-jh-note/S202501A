package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dao.ny_dao.BoardDao;
import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDao bd;
	
	// 게시판 글 총 수 (글 15개씩)
	@Override
	public int totalBoard() {
		System.out.println("BoardServiceImpl totalBoard Start ...");
		int totBoardCnt = bd.totalBoard();
		System.out.println("BoardServiceImpl totalBoard totBoardCnt->" + totBoardCnt);
		return totBoardCnt;
	}

	
	//게시판 리스트 
	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("BoardServiceImpl listBoard Start...");
		boardList = bd.listBoard(board);
		System.out.println("BoardServiceImpl listBoard boardList.size()->" + boardList.size());

		return boardList;
	}

	
	//세부 내역 글
	@Override
	public Board contents(Long board_No) {
		System.out.println("BoardServiceImpl contents Start...");
		Board board = null;
		board = bd.contents(board_No);
		System.out.println("BoardServiceImpl contents ...");
		
		return board;
	}

	
	// 게시글 수정
	@Override
	public int updateBoard(Board board) {
		System.out.println("BoardServiceImpl update ...");
		int updateCount = 0;
		updateCount = bd.updateBoard(board);
		return updateCount;
	}

	
	// 게시글 삭제
	@Override
	public int deleteBoard(Long board_No) {
		int result = 0;
		System.out.println("boardServiceImpl delete Start..." );
		result =  bd.deleteBoard(board_No);
		return result;
	}

	// 게시글 등록
	@Override
	public int insertBoard(Board board) {
		int result = 0;
		System.out.println("boardServiceImpl insertBoard Start...");
		result = bd.insertBoard(board);
		return result;
	}

	//게시글 조회
	
	
	@Override
	public void increaseHit(Long board_No) {
	System.out.println("BoardServiceImpl Start increaseHit...");
	 bd.increaseHit(board_No);
	}

	
	
	// 댓글 리스트
	@Override
	public List<Board> listReply(Board board) {
		List<Board> listReply = null;
		listReply = bd.listReply(board);
		System.out.println("BoardServiceImpl listReply boardList.size()->" + listReply.size());

		
		return listReply;
	}
	
	// 댓글 등록
	@Override
	public int breply(Board board) {
		int result = 0;
		System.out.println("BoardServiceImpl addCommentboard->"+board);
		result = bd.breply(board);
		return  result;
		
	}

	@Override
	public int updateReply(Board board) {
		 System.out.println("BoardServiceImpl Start updateReply...");
		int result = 0;
		result = bd.updateReply(board);
	    return result;
	}



	@Override
	public int deleteReply(Long board_No) {
		System.out.println("BoardServiceImpl Start deleteReply...");
		int result = 0;
		result=bd.deleteReply(board_No);
		return result;
	}

	// 밑 2개가 검색
	  @Override
	    public int condTotalBoard(Board board) {
	        System.out.println("BoardServiceImpl Start condTotalBoard...");
	        int totBoardCnt = bd.condTotalBoard(board);
	        System.out.println("BoardServiceImpl condTotalBoard totBoardCnt->" + totBoardCnt);
	        return totBoardCnt;
	    }

	    @Override
	    public List<Board> listSearchBoard(Board board) {
	        List<Board> boardSearchList = null;
	        System.out.println("BoardServiceImpl listSearchBoard Start...");
	        boardSearchList = bd.boardSearchList(board);
	        System.out.println("BoardServiceImpl listSearchBoard boardSearchList.size()->" + boardSearchList.size());
	        return boardSearchList;
	    }


}
 
	
	


