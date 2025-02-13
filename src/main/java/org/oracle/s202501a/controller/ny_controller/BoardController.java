package org.oracle.s202501a.controller.ny_controller;

import org.oracle.s202501a.dto.ny_dto.Board;
import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.ny_service.BoardService;
import org.oracle.s202501a.service.ny_service.Paging;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	// 보드 리스트 (글 15개씩)
	@RequestMapping(value = "/All/Management/BoardList")
	public String listBoard(Board board, Model model) {
		System.out.println("BoardController Start Boardlist...");

		// 페이징
		int totalBoard = bs.totalBoard();
		if (board.getCurrentPage() == null)
			board.setCurrentPage("1");
		Paging page = new Paging(totalBoard, board.getCurrentPage());

		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		// 리스트
		List<Board> listBoard = bs.listBoard(board);
		System.out.println("BoardController list listBoard.size()=>" + listBoard.size());

		model.addAttribute("totalBoard", totalBoard);
		model.addAttribute("listBoard", listBoard);
		model.addAttribute("page", page);

		return "ny_views/BoardList";
	}

	// 게시판 상세조회 / 조회수
	@GetMapping("/All/Management/BoardContent")
	public String contents(Board board1, Model model) {
		System.out.println("EmpController Start ContentView...");

		 // 조회수 증가
	    bs.increaseHit(board1.getBoard_No());
		
	    
	    // 게시글 상세 조회
		Board board = bs.contents(board1.getBoard_No());
		System.out.println("EmpController ContentView ->" + board);

		model.addAttribute("board", board);

		// 로그인한 사용자 정보 가져오기
	 	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
    	Authentication authentication = securityContext.getAuthentication();
    	System.out.println("HomeController home authentication->"+authentication);
       	System.out.println("HomeController home authentication.getName()->"+authentication.getName());
        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
       	System.out.println("HomeController home empDTO->"+empDTO);
       	model.addAttribute("empDTO", empDTO);
        
       	// 해당 게시글의 댓글 리스트 조회
       	List<Board> listReply = bs.listReply(board);
		System.out.println("BoardController list listReply.size()=>" + listReply.size());
		System.out.println("BoardController list listReply=>" + listReply);
       	model.addAttribute("listReply", listReply);

		
		return "ny_views/BoardContent";
	}

	
	// 게시글 수정1 (폼)
	@GetMapping("/All/Management/updateBoardForm")
	public String updateForm(Board board1, Model model) {
		System.out.println("BController Start updateBoardForm...");

		Board board = bs.contents(board1.getBoard_No());
		System.out.println("BController updateBoardForm ->" + board);
		model.addAttribute("board", board);
		
		return "ny_views/updateBoardForm";

	}

	// 게시글 수정2
	@PostMapping("/All/Management/updateBoard")
	public String updateBoard(Board board, Model model) {
		System.out.println("BoardController Start updateBoard...");
		System.out.println("BoardController updateBoard board->"+board);

		int updateCount = bs.updateBoard(board);
		System.out.println(board);

		return "redirect:/All/Management/BoardContent?board_No="+board.getBoard_No();


	}

	// 게시글 삭제
	@RequestMapping(value = "/All/Management/deleteBoard")
	public String deleteBoard(Board board, Model model) {
		System.out.println("BoardController Start deleteBoard...");
		System.out.println("BoardController deleteBoard board.getBoard_No()->"+board.getBoard_No());
		 int result = bs.deleteBoard(board.getBoard_No());
		return "redirect:/All/Management/BoardList";
	}
	

	
	// 게시글등록1 폼
	@RequestMapping(value ="/All/Management/writeFormBoard")
	public String writeFormBoard(Model model) { 
	    System.out.println("BoardController writeFormBoard Start...");
	   	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
    	Authentication authentication = securityContext.getAuthentication();
    	System.out.println("HomeController home authentication->"+authentication);
       	System.out.println("HomeController home authentication.getName()->"+authentication.getName());
        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
       	System.out.println("HomeController home empDTO->"+empDTO);
       	model.addAttribute("empDTO", empDTO);

	    return "ny_views/writeFormBoard";
	    // return 문은 메소드의 마지막 실행문이 되어야 하며, 하나의 메소드에는 하나의 return 문만 실행될 수 있음
	}

	 
	 
	// 게시글등록2 
		@PostMapping(value ="/All/Management/writeBoard")
		 public String writeBoard(Board board, Model model) {
			 System.out.println("BoardController Start writeBoard...");
			 System.out.println("BoardController Start writeBoard..."+board);
			 int insertResult = bs.insertBoard(board);
			return "redirect:/All/Management/BoardList";
		 
	 }
		
		
		// 댓글 등록 뷰 
		// 삭제 대상 
		@RequestMapping(value ="/All/Management/BoardContent")
		public String replyContent(Board board,Model model) { 
			 System.out.println("BoardController Start replyContents...");
			   	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
		    	Authentication authentication = securityContext.getAuthentication();
		    	System.out.println("HomeController home authentication->"+authentication);
		       	System.out.println("HomeController home authentication.getName()->"+authentication.getName());
		        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
		       	System.out.println("HomeController home empDTO->"+empDTO);
		       	
		       	List<Board> listReply = bs.listReply(board);
				System.out.println("BoardController list listReply.size()=>" + listReply.size());

				// 리스트
				List<Board> listBoard = bs.listBoard(board);
				System.out.println("BoardController list listBoard.size()=>" + listBoard.size());


		       	
		       	model.addAttribute("empDTO", empDTO);
		       	
		       	model.addAttribute("listReply", listReply);
		       	model.addAttribute("listBoard", listBoard);
		       	
		       	
		        return "ny_views/BoardContent";
		}
		
		
		// 댓글 등록 	
		@RequestMapping(value ="/All/Management/reply")
		public String reply (Board board, Model model) {
			 System.out.println("controller board/reply start");
			 System.out.println("reply start board->"+board);
			 

			// 로그인한 사용자 정보 가져오기
		 	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
	    	Authentication authentication = securityContext.getAuthentication();
	    	//System.out.println("BoardController reply authentication->"+authentication);
	        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
	       	System.out.println("BoardController reply empDTO->"+empDTO);
	       	board.setEmp_No(empDTO.getEmp_No());
	       	// model.addAttribute("empDTO", empDTO);
		        
			 
			 
			 // model.addAttribute("Board", board);
			// bs.breply(model);
			 bs.breply(board);
			 
			 System.out.println("controller reply end board->"+board);

			 // 원글에 대한 조회 => .getComment_Group
			 return "redirect:/All/Management/BoardContent?board_No="+board.getComment_Group();
		}


		// 댓글 수정
		@PostMapping("/All/Management/updateReply")
		public String updateReply(Board board, Model model) {
		    System.out.println("BoardController Start updateReply...");
		    System.out.println("BoardController updateReply board->" + board);

		    int updateCount = bs.updateReply(board);
		    System.out.println("updateCount -> " + updateCount);

		    return "redirect:/All/Management/BoardContent?board_No=" + board.getComment_Group();  
		}

		// 댓글 삭제
		@RequestMapping(value = "/All/Management/deleteReply")
		public String deleteReply(Board board, Model model) {
		    System.out.println("BoardController Start deleteReply...");
		    System.out.println("BoardController deleteReply board->" + board);

		    int result = bs.deleteReply(board.getBoard_No());
		    System.out.println("deleteCount -> " + result);
             //   게시글의 번호로 돌아가도록
		    return "redirect:/All/Management/BoardContent?board_No=" + board.getComment_Group();
		}

		  // 제목 검색 (listSearchBoard)
	    @RequestMapping(value = "/All/Management/listSearchB")
	    public String listSearchBoard(Board board, Model model) {
	        System.out.println("BoardController Start listSearchBoard...");
	        System.out.println("BoardController listSearchBoard board->" + board);

	        int totalBoard = bs.condTotalBoard(board);
	        System.out.println("BoardController listSearchBoard totalBoard=>" + totalBoard);

	        Paging page = new Paging(totalBoard, board.getCurrentPage());
	        board.setStart(page.getStart());
	        board.setEnd(page.getEnd());
	        System.out.println("BoardController listSearchBoard page=>" + page);

	        List<Board> listSearchBoard = bs.listSearchBoard(board);

	        System.out.println("BoardController listSearchBoard listSearchBoard.size()=>" + listSearchBoard.size());
	        System.out.println("BoardController listSearchBoard listSearchBoard=>" + listSearchBoard);

	        model.addAttribute("totalBoard", totalBoard);
	        model.addAttribute("listBoard", listSearchBoard);
	        model.addAttribute("page", page);

	        return "ny_views/BoardList";
	    }

	 }
