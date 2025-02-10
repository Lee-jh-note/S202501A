package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoIml implements BoardDao{
	private final SqlSession session; 
	
	
	
	// 게시판 리스트 
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

	
	
	//게시판 리스트 전체 수 
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
	
	
	
	// 게시판 상세조회
	@Override
	public Board contents(Long board_No) {
		System.out.println("BoardDaoImpl detail start..");
		Board board = new Board();
		
		try {
			//
			board = session.selectOne("nylistboardSelOne", board_No); // #기본키여서 셀렉트원?
			System.out.println("BoardDaoImpl detail board->" + board);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl detail Exception->" + e.getMessage());
		}
		return board;
	}
	
	
	
	// 게시판 수정
	@Override
	public int updateBoard(Board board) {
		System.out.println("BoardDaoImpl update start..");
		System.out.println("다오 업데이트" +board);
		int updateCount = 0;
		try {
			updateCount = session.update("nyUpdateBoard", board);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl updateBoard Exception->" + e.getMessage());
		}
		return updateCount;
	}
	
	
	
	//게시판 삭제
	@Override
	public int deleteBoard(Long board_No) {
		System.out.println("BoardDaoImpl delete start..");
		int result = 0;
		System.out.println("BoardDaoImpl delete Board_No->"+board_No);
		try {
			result  = session.delete("nydeleteBoard",board_No);
			System.out.println("BoardDaoImpl delete result->"+result);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl delete Exception->"+e.getMessage());
		}

		return result;
	}


	//게시판 등록
	@Override
	public int insertBoard(Board board) {
		int result = 0;
		System.out.println("BoardDaoImpl insertBoard Start...");
		try {
			System.out.println("BoardDaoImpl insertBoard ->"+board);
			result = session.insert("nyinsertBoard", board);
		} catch (Exception e) {
			System.out.println("BoardDaoImpl insertBoard Exception->" + e.getMessage());
		}
		return result;
	}

	
	//게시판 조회 
		@Override
	    public void increaseHit(Long board_No) {
	        System.out.println("BoardDAOImpl Start increaseHit... board_No: " + board_No);
	        int result =0;
	        result = session.update("nyincreaseHit", board_No);
	        System.out.println("BoardDAOImpl Start increaseHit result: " + result);
	    }

	
	//댓글 리스트
	@Override
	public List<Board> listReply(Board board) {
		List<Board> listReply = null;
		System.out.println("BoardDaoImpl listReply Start..." );
		try {
			listReply = session.selectList("nylistReply", board.getComment_Group());
		} catch (Exception e) {
			System.out.println("BoardDaoImpl listReply kk Exception->"+e.getMessage());
		}
		return listReply;

	}
	
	
	//댓글 등록
	@Override
	public int breply(Board board) {
	       System.out.println("BoardDaoImpl breply board->"+board);
	        int result = 0;
	        int comment_Step = 0;
	        try {
	        	comment_Step = session.selectOne("nyGetMaxStep", board);
	        	board.setComment_Step(comment_Step);
	            result = session.insert("nyInsertComment", board);
	        } catch (Exception e) {
	            System.out.println("BoardDaoImpl breply Exception->" + e.getMessage());
	        }
			 System.out.println("breply Dao  board->"+board);

	        return result;
	    }


	//댓글 수정
	@Override
	public int updateReply(Board board) {
	       System.out.println("BoardDaoImpl breply board->"+board);
	        int result = 0;
	        int comment_Step = 0;
	        try {
//	        	comment_Step = session.selectOne("nyGetMaxStep", board);
//	        	board.setComment_Step(comment_Step);
	            result = session.update("nyupdateReply", board);
	        } catch (Exception e) {
	            System.out.println("BoardDaoImpl breply Exception->" + e.getMessage());
	        }
	        return result;
	}


	//댓글 삭제
	@Override
	public int deleteReply(Long board_No) {
	    System.out.println("BoardDaoImpl breply board->"+board_No);
        int result = 0;
        try {
            result = session.delete("nydeleteReply", board_No);
        } catch (Exception e) {
            System.out.println("BoardDaoImpl breply Exception->" + e.getMessage());
        }
        return result;
	}





}
