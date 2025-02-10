package org.oracle.s202501a.controller.ny_controller;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.ny_service.NoticeService;
import org.oracle.s202501a.service.ny_service.Paging;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("notice")
public class NoticeController {

	private final NoticeService ns;
	
	// 공지 리스트 (글 15개씩)
		@RequestMapping(value = "NoticeList")
		public String listBoard(Notice notice, Model model) {
			System.out.println("NoticeController Start Boardlist...");

			// 페이징
			int totalNotice = ns.totalNotice();
			if (notice.getCurrentPage() == null)
				notice.setCurrentPage("1");
			Paging page = new Paging(totalNotice, notice.getCurrentPage());

			notice.setStart(page.getStart());
			notice.setEnd(page.getEnd());

			// 리스트
			List<Notice> listNotice = ns.listNotice(notice);
			System.out.println("NoticeController list listBoard.size()=>" + listNotice.size());

			model.addAttribute("totalNotice", totalNotice);
			model.addAttribute("listNotice", listNotice);
			model.addAttribute("page", page);

			return "ny_views/NoticeList";
		}
	
	
	
		// 공지 상세조회 / 조회수
		@GetMapping("NoticeContent")
		public String contents(Notice notice1, Model model) {
			System.out.println("NoticeController Start ContentView...");

			 // 조회수 증가
			ns.increaseHitNT(notice1.getBoard_No());				    
		    // 공지 상세 조회
		    Notice notice = ns.ntcontents(notice1.getBoard_No());
			
		    
		    System.out.println("NoticeController ContentView ->" + notice);
			model.addAttribute("notice", notice);

			// 로그인한 사용자 정보 가져오기
		 	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
	    	Authentication authentication = securityContext.getAuthentication();
	    	System.out.println("HomeController home authentication->"+authentication);
	       	System.out.println("HomeController home authentication.getName()->"+authentication.getName());
	        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
	       	System.out.println("HomeController home empDTO->"+empDTO);
	       	model.addAttribute("empDTO", empDTO);
	        
	      
			
			return "ny_views/NoticeContent";
		}
		
		
		
		// 공지 수정1 (폼)
		@GetMapping("updateNoticeForm")
		public String updateForm(Notice notice1, Model model) {
			System.out.println("NoticeController Start updateNoticeForm...");

			Notice notice = ns.ntcontents(notice1.getBoard_No());
			System.out.println("NoticeController updateBoardForm ->" + notice);
			model.addAttribute("notice", notice);
			
			return "ny_views/updateNoticeForm";

		}
		
		// 공지 수정2
		@PostMapping("updateNotice")
		public String updateBoard(Notice notice, Model model) {
			System.out.println("NoticeController Start updateNotice...");
			System.out.println("NoticeController updateNotice Notice->"+ notice);

			int updateCount = ns.updateNotice(notice);
			System.out.println(notice);

			return "redirect:NoticeContent?board_No="+notice.getBoard_No();

		}
		

		// 공지 삭제
		@RequestMapping(value = "deleteNotice")
		public String deleteBoard(Notice notice, Model model) {
			System.out.println("NoticeController Start deleteNotice...");
			System.out.println("NoticeController deleteBoard board.getBoard_No()->"+notice.getBoard_No());
			 int result = ns.deleteNotice(notice.getBoard_No());
			return "redirect:NoticeList";
		}
		

		// 게시글등록1 폼
		@RequestMapping(value ="writeFormNotice")
		public String writeFormNotice(Model model) { 
		    System.out.println("NoticeController writeFormBoard Start...");
		   	SecurityContext securityContext = SecurityContextHolder.getContextHolderStrategy().getContext();
	    	Authentication authentication = securityContext.getAuthentication();
	    	System.out.println("HomeController home authentication->"+authentication);
	       	System.out.println("HomeController home authentication.getName()->"+authentication.getName());
	        EmpDTO empDTO = (EmpDTO) authentication.getPrincipal();
	       	System.out.println("HomeController home empDTO->"+empDTO);
	       	model.addAttribute("empDTO", empDTO);

		    return "ny_views/writeFormNotice";
		    // return 문은 메소드의 마지막 실행문이 되어야 하며, 하나의 메소드에는 하나의 return 문만 실행될 수 있음
		}
		
		// 게시글등록2 
				@PostMapping(value ="writeNotice")
				 public String writeNotice(Notice notice, Model model) {
					 System.out.println("NoticeConntroller Start writeBoard...");
					 System.out.println("NoticeController Start writeBoard..."+notice);
					 int insertResult = ns.insertNotice(notice);
					return "redirect:NoticeList";
				 
			 }
	
}
