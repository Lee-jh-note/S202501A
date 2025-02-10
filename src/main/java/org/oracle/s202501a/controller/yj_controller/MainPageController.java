package org.oracle.s202501a.controller.yj_controller;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Board;
import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.ny_service.BoardService;
import org.oracle.s202501a.service.ny_service.EmpService;
import org.oracle.s202501a.service.ny_service.Paging;
import org.oracle.s202501a.service.sh_service.UserService;
import org.oracle.s202501a.service.yj_service.MainPageService;
import org.oracle.s202501a.service.yj_service.PurchaseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainPageController {
	
	// 승환님 UserService 사용
	private final UserService f;
	// 나예언니 EmpService 사용
	private final EmpService es;

	private final MainPageService ms;
	
	// emp_Name Position님 환영합니다
	// 사원번호: emp_No / 부서: dept_Name / 직급: Position / 입사일: hiredate.subString(0,10)
	@RequestMapping(value = "mainPage")
	public String mainPage(Notice notice, Model model) {
		
		// 세션 받아오기
		EmpDTO dto = f.getSe();
		String emp_name = dto.getEmpName();
		String position = dto.getPosition();
		Long emp_no = dto.getEmp_No();
		String hiredate = dto.getHiredate().substring(0,10);
		
	    model.addAttribute("emp_name", emp_name);
	    model.addAttribute("position", position);
	    model.addAttribute("emp_no", emp_no);
	    model.addAttribute("hiredate", hiredate);
	    
	    // 부서번호 가져오기
	    Long dept_No = dto.getDept_No();
	    Dept dept = es.detailDept(dept_No);
	    
	    String dept_name = dept.getDept_Name();
	    model.addAttribute("dept_name", dept_name);
	    

 		// 공지사항 리스트
	    List<Notice> listNotice = ms.mainNotice(notice);
 		System.out.println("MainPageController list listBoard.size()=>" + listNotice.size());

 		model.addAttribute("listNotice", listNotice);

 		return "mainPage";
	}
	
	
}
