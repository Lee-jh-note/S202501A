package org.oracle.s202501a.controller.ny_controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.query.Page;
import org.oracle.s202501a.dto.ny_dto.Dept;
import org.oracle.s202501a.dto.ny_dto.Emp;
import org.oracle.s202501a.dto.sh_dto.CommDto;
import org.oracle.s202501a.service.ny_service.EmpService;
import org.oracle.s202501a.service.ny_service.Paging;
import org.oracle.s202501a.service.sh_service.ClientService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j

public class EmpController {
	private final EmpService es;
	private final ClientService cs;
	
	// 직원 리스트
	@RequestMapping(value = "All/HR/listEmp")
	public String listEmp(Emp emp, Model model) {
		System.out.println("EmpController na Ye Start listEmp...");

		int totalEmp = es.totalEmp();

		// Paging 작업
		if (emp.getCurrentPage() == null)
			emp.setCurrentPage("1");
		Paging page = new Paging(totalEmp, emp.getCurrentPage()); //

		emp.setStart(page.getStart());
		emp.setEnd(page.getEnd());

		List<Emp> listEmp = es.listEmp(emp);
		System.out.println("EmpController list listEmp.size()=>" + listEmp.size()); // # listEmp의 사이즈 보기

		model.addAttribute("listEmp", listEmp);
		model.addAttribute("totalEmp", totalEmp);
		model.addAttribute("page", page);

		
		// 부서 목록 항상 추가
	    List<Dept> deptList = es.deptSelect();
	    model.addAttribute("deptList", deptList);
		
		return "ny_views/listEmp";
	}
	
	
	// listemp의 부서 리스트
	@RequestMapping(value = "/All/HR/listDept")
	public String listDept (Dept dept1, Model model) {
		System.out.println("EmpController Start listDept...");
		List<Dept> listDept = es.listDept(dept1);
		System.out.println("EmpController list listDept.size()=>" + listDept.size());
		
		
		model.addAttribute("listDept", listDept);
		return "ny_views/listDept";
		
	}
	
	// 부서 전체 리스트
	@RequestMapping(value = "/All/HR/listDept3")
	public String listDept3 (Model model) {
		System.out.println("EmpController Start listDept3...");
		List<Dept> listDept = es.listDept3();
		System.out.println("EmpController list listDept3.size()=>" + listDept.size());
		
		
		model.addAttribute("listDept", listDept);
		return "ny_views/listDept";
		
	}	
	
	
	 // 부서 삭제
	
	 @RequestMapping(value="/HR/deleteDept")
	 public String deleteDept(Dept dept, Model model)  { 
		 System.out.println("EmpController Start deleteDept..." ); 
		
	 String result = es.deleteDept(dept.getDept_No()); 
	
	 
	 return "redirect:/All/HR/listDept"; 
	 }
	 
	 
	 
	
	// 부서에 있는 직원 수를 반환하는 컨트롤러 메소드
	 @RequestMapping(value="/HR/countEmpInDept")
	 @ResponseBody
	 public int countEmpInDept(@RequestParam("dept_No") Long dept_No) {
	     return es.countEmpInDept(dept_No);  // 직원 수를 계산하는 서비스 호출
	 }
	 
	 
	 // 부서 등록1
	 @RequestMapping(value = "/HR/writeFormDept")
		public String writeFormDept(Model model) {
			System.out.println("empController writeFormDept Start...");
			return "ny_views/writeFormDept";

	 }
	 //부서 등록2
	 @PostMapping(value = "/HR/writeDept")
		public String writeDept(Dept dept, Model model) {
			System.out.println("EmpController Start writeDept...");
			System.out.println("EmpController writeDept Dept ->" + dept);

			int insertResult = es.insertDEPT(dept);
			if (insertResult > 0)
				return "redirect:/All/HR/listDept";
			else {
				model.addAttribute("msg", "입력 실패 확인해 보세요");
				return "redirect:/HR/writeFormDept";
			}
		}

	 
	 
	 // 세부내역
	@GetMapping(value = "/All/HR/detailEmp")
	public String detailEmp(Emp emp1, Model model) {
		System.out.println("EmpController Start detailEmp...");
		System.out.println("EmpController detailEmp emp1->" + emp1);
		Emp emp = es.detailEmp(emp1.getEmp_No());
		System.out.println("EmpController detailEmp emp1->" + emp);

		Dept dept = es.detailDept(emp.getDept_No());
		System.out.println("EmpController detailEmp dept->" + dept);
		emp.setDept_Name(dept.getDept_Name());
		System.out.println("EmpController detailEmp emp3->" + emp);

		model.addAttribute("emp", emp);
		return "ny_views/detailEmp";

	}
	
	
//	//부서 수정 1
//		@GetMapping(value = "/HR/updateFormDept")
//		public String updateFormDept(Dept dept1, Model model) {
//			System.out.println("EmpController Start updateForm...");
//
//			Dept dept = es.detailDept(dept1.getDept_No());
//			System.out.println("EmpController updateFormEmp emp->" + dept);
//			System.out.println(dept1.getDept_No());
//
//			return "ny_views/updateFormDept";
//		}
		
		// 부서 수정 2
		@ResponseBody
		@PostMapping(value = "/HR/updateDept")
		public String updateDept(Dept dept, Model model) {
			log.info("updateDept Start...");
			System.out.println("컨트롤러 " +  dept);
			int updateDeptCount = es.updateDept(dept);
			return "0";
		}

		
		
	//직원 수정 1 폼
	@GetMapping(value = "/HR/updateFormEmp")
	public String updateFormEmp(Emp emp1, Model model) {
		System.out.println("EmpController Start updateForm...");
		
		Emp emp = es.detailEmp(emp1.getEmp_No());
		System.out.println("EmpController updateFormEmp emp->" + emp);
		System.out.println(emp1.getEmp_No());

		// 부서 수정
		List<Dept> deptList = es.deptSelect();
		model.addAttribute("deptList", deptList);
		System.out.println("EmpController deptList.size->" + deptList.size());

		// 사원 직급 수정 (empPosSelect 등록도 재활용)
		List<Emp> empList = es.empPosSelect();
		model.addAttribute("empList", empList);
		System.out.println("EmpController empList.size->" + empList.size());

		String birth = "";
		if (emp.getBirth() != null) {
			birth = emp.getBirth().substring(0, 10);
			emp.setBirth(birth);
		}
		System.out.println("birth->" + birth);

		String hiredate = "";
		if (emp.getHiredate() != null) {
			hiredate = emp.getHiredate().substring(0, 10);
			emp.setHiredate(hiredate);
		}
		System.out.println("hiredate->" + hiredate);
		System.out.println("반환 지건 " + emp);
		model.addAttribute("emp", emp);
		return "ny_views/updateFormEmp";

	}

	//직원 수정 2
	@PostMapping("/HR/updateEmp")
	public String updateEmp(Emp emp, Model model) {
		log.info("updateEmp Start..."); 
		int updateCount = es.updateEmp(emp);
		System.out.println("컨트롤러 " + emp);
		System.out.println("empController es.updateEmp updateCount-->" + updateCount);
		/* 0 이상 , 수정되었습니ㅏ */
		/*
		 * model.addAttribute("uptCnt", updateCount); // #서비스임플에서 업데이트된 개수
		 * model.addAttribute("mt", "Message Test"); // # 메세지 테스트
		 */
		
		return  "redirect:/All/HR/detailEmp?emp_No="+emp.getEmp_No();
	}
	
	// 유
	// 직원 등록
	@RequestMapping(value = "/HR/writeFormEmp")
	public String writeFormEmp(Model model) {
	    System.out.println("empController writeFormEmp Start...");

	    // 부서 목록 가져오기
	    List<Dept> deptList = es.deptSelect();
	    model.addAttribute("deptList", deptList);
	    System.out.println("EmpController deptList.size->" + deptList.size());

	    // 직급 선택
	    List<Emp> empList = es.empPosSelect();
	    model.addAttribute("empList", empList);
	    System.out.println("EmpController empList.size->" + deptList.size());

	    // role 선택
	    int bcd = 100; // 권한(role)
	    List<CommDto> roleList = cs.roleSelect(100);
	    model.addAttribute("roleList", roleList);
	    System.out.println("EmpController writeFormEmp3 roleList.size->" + roleList.size());
	    System.out.println("EmpController writeFormEmp3 roleList->" + roleList);

	    return "ny_views/writeFormEmp";
	}


	


	
	//  삭제(업데이트)직원
	@RequestMapping(value = "/HR/deleteEmp")
	public String deleteEmp(Emp emp, Model model) {
		log.info("deleteEmp Start...");
		System.out.println("컨트롤러 " + emp);

		int result = es.deleteEmp(emp); // 서비스 호출
		if (result > 0) {
			System.out.println("삭제 성공: emp_Delete = 1");
			model.addAttribute("msg", "직원 삭제(삭제 여부 1) 성공");
		} else {
			System.out.println("삭제 실패 또는 이미 삭제된 직원");
			model.addAttribute("msg", "직원 삭제 실패");
		}
		model.addAttribute("emp", emp);
		return "redirect:/All/HR/listEmp";
	}

	
	
	// 조회 관련
	// 상세조회, 전체조회X condTotalEmp / listSearchEmp(empSearchList3)
	@RequestMapping(value = "/All/HR/listSearch3")
	public String listSearch3(Emp emp, Model model) {
		System.out.println("EmpController Start listSearch3...");
		System.out.println("EmpController listSearch3 emp->" + emp);

		   // 부서 목록 가져오기
	    List<Dept> deptList = es.deptSelect();
	    if (deptList == null || deptList.isEmpty()) {
	        System.out.println("EmpController listSearch3 deptList is NULL or EMPTY!");
	    } else {
	        System.out.println("EmpController listSearch3 deptList.size() => " + deptList.size());
	    }
	    model.addAttribute("deptList", deptList);
	    
	    
		// 검색한 직원 수 계산
	    int totalEmp = es.condTotalEmp(emp);
	    System.out.println("EmpController listSearch3 totalEmp=>" + totalEmp);

	    // 페이징 처리
	    Paging page = new Paging(totalEmp, emp.getCurrentPage());
	    emp.setStart(page.getStart());
	    emp.setEnd(page.getEnd());
	    System.out.println("EmpController listSearch3 page=>" + page);
		
	    // 검색된 직원 리스트 조회
	    List<Emp> listSearchEmp = es.listSearchEmp(emp);
		System.out.println("EmpController listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
		System.out.println("EmpController listSearch3 listSearchEmp=>" + listSearchEmp);
		
		// Model에 값 추가
		model.addAttribute("totalEmp", totalEmp);
		model.addAttribute("listEmp", listSearchEmp);
		model.addAttribute("page", page);

		 // 검색 필터 유지
	    model.addAttribute("search", emp.getSearch());
	    model.addAttribute("keyword", emp.getKeyword());
	    model.addAttribute("dept_No", emp.getDept_No());  // 선택된 부서 유지
		
		return "ny_views/listEmp";
	}
	
	//부서 번호 중복여부
   @ResponseBody // ajax를 json으로 보내기
   @GetMapping(value = "/HR/deptConfirm")
   public Map<String, Object> deptConfirm(Dept dept1) {
      System.out.println("EmpController confirm start,,");

      Dept dept = es.deptConfirm(dept1.getDept_No());

      Map<String, Object> response = new HashMap<>();

      if (dept != null) {
         System.out.println("deptConfirm 중복된 부서번호 .. ");
         response.put("isDuplicate", true);
      } else {
         System.out.println("deptConfirm 중복 되지 않은 부서번호.. ");
         response.put("isDuplicate", false);
      }

      return response;
   }
   
   
   // 직원 이름 중복여부
   @ResponseBody // ajax를 json으로 보내기
   @GetMapping(value = "/HR/empConfirm")
   public Map<String, Object> deptConfirm(Emp emp1) {
      System.out.println("EmpController confirm start,,");

      Emp emp = es.empConfirm(emp1.getEmp_Name());

      Map<String, Object> response = new HashMap<>();

      if (emp != null) {
         System.out.println("empConfirm 중복된 이름.. ");
         response.put("isDuplicate", true);
      } else {
         System.out.println("empConfirm 중복되지 않은 이름.. ");
         response.put("isDuplicate", false);
      }

      return response;
   }

} 
   