package org.oracle.s202501a.controller.ny_controller;



import org.oracle.s202501a.dto.ny_dto.Board;
import org.oracle.s202501a.service.ny_service.BoardService;
import org.oracle.s202501a.service.ny_service.Paging;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.query.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {
	private final BoardService bs;
	
	@RequestMapping(value = "BoardList")
	public String listBoard(Board board , Model model) {
		System.out.println("BoardController Start Boardlist..." );
	
		int totalBoard =  bs.totalBoard();	
		
		
		if (board.getCurrentPage() == null) 
			board.setCurrentPage("1"); 
		Paging page = new Paging(totalBoard, board.getCurrentPage());
		
		board.setStart(page.getStart());  
		board.setEnd(page.getEnd());  

		List<Board> listBoard = bs.listBoard(board);
		System.out.println("BoardController list listBoard.size()=>" + listBoard.size());
		
		
		model.addAttribute("totalBoard", totalBoard); 
		model.addAttribute("listBoard" , listBoard); 
		model.addAttribute("page"    , page);
		
		
		
	return "ny_views/BoardList";
}
	}
