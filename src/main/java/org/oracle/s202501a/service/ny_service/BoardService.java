package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;
import org.springframework.ui.Model;

public interface BoardService {

	int totalBoard();
	List<Board> listBoard(Board board); // 게시판 리스트
	
	Board contents(Long board_No); //게시판 세부내역
	
	int updateBoard(Board board); //게시판 수정
	
	int deleteBoard(Long board_No); //게시판 삭제
	 
	int insertBoard(Board board);   //게시판 등록                    
	void increaseHit(Long board_No); //게시글 조회수
	

	List<Board> listReply(Board board); //댓글 리스트
	int breply(Board board);  //댓글 등록
	
	int updateReply(Board board); //댓글 수정
	int deleteReply(Long board_No); //댓글 삭제
	
	
		
	
}
