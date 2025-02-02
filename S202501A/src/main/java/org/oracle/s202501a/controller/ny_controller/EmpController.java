package org.oracle.s202501a.controller.ny_controller;

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
	@RequestMapping(value = "listEmp")
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

		return "ny_views/list";
	}
	
	
	// listemp의 부서 리스트
	@RequestMapping(value = "listDept")
	public String listDept (Dept dept1, Model model) {
		System.out.println("EmpController Start listDept...");
		List<Dept> listDept = es.listDept(dept1);
		System.out.println("EmpController list listDept.size()=>" + listDept.size());
		
		
		model.addAttribute("listDept", listDept);
		return "ny_views/listDept";
		
	}
	
	// 부서 전체 리스트
	@RequestMapping(value = "listDept3")
	public String listDept3 (Model model) {
		System.out.println("EmpController Start listDept3...");
		List<Dept> listDept = es.listDept3();
		System.out.println("EmpController list listDept3.size()=>" + listDept.size());
		
		
		model.addAttribute("listDept", listDept);
		return "ny_views/listDept";
		
	}	
	
	
	 // 부서 삭제
	
	 @RequestMapping(value="deleteDept") 
	 public String deleteDept(Dept dept, Model model)  { 
		 System.out.println("EmpController Start deleteDept..." ); 
		
	 String result = es.deleteDept(dept.getDept_No()); 
	
	 
	 return "redirect:listDept"; 
	 }
	
	// 부서에 있는 직원 수를 반환하는 컨트롤러 메소드
	 @RequestMapping(value="countEmpInDept")
	 @ResponseBody
	 public int countEmpInDept(@RequestParam("dept_No") Long dept_No) {
	     return es.countEmpInDept(dept_No);  // 직원 수를 계산하는 서비스 호출
	 }
	 
	 
	 // 부서 등록
	 @RequestMapping(value = "writeFormDept")
		public String writeFormDept(Model model) {
			System.out.println("empController writeFormDept Start...");
			return "ny_views/writeFormDept";

	 }
	 
	 @PostMapping(value = "writeDept")
		public String writeDept(Dept dept, Model model) {
			System.out.println("EmpController Start writeDept...");
			System.out.println("EmpController writeDept Dept ->" + dept);

			int insertResult = es.insertDEPT(dept);
			if (insertResult > 0)
				return "redirect:listDept";
			else {
				model.addAttribute("msg", "입력 실패 확인해 보세요");
				return "forward:writeFormDept";
			}
		}

	 
	 
	 
	 
	@GetMapping(value = "detailEmp")
	public String detailEmp(Emp emp1, Model model) {
		System.out.println("EmpController Start detailEmp...");

		System.out.println("EmpController detailEmp emp1->" + emp1);
		Emp emp = es.detailEmp(emp1.getEmp_No());
		System.out.println("EmpController detailEmp emp2->" + emp);

		Dept dept = es.detailDept(emp.getDept_No());
		System.out.println("EmpController detailEmp dept->" + dept);
		emp.setDept_Name(dept.getDept_Name());
		System.out.println("EmpController detailEmp emp3->" + emp);

		model.addAttribute("emp", emp);
		return "ny_views/detailEmp";

	}
	
	
	//부서 수정 
		@GetMapping(value = "updateFormDept")
		public String updateFormDept(Dept dept1, Model model) {
			System.out.println("EmpController Start updateForm...");
			Dept dept = es.detailDept(dept1.getDept_No());
			System.out.println("EmpController updateFormEmp emp->" + dept);
			System.out.println(dept1.getDept_No());
			
			return "ny_views/updateFormDept";
		}

		@PostMapping(value = "updateDept")
		public String updateDept(Dept dept, Model model) {
			log.info("updateDept Start...");
			System.out.println("컨트롤러 " +  dept);
			int updateDeptCount = es.updateDept(dept);
			return "forward:listDept";
		}

	//직원 수정 
	@GetMapping(value = "updateFormEmp")
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

	
	@PostMapping(value = "updateEmp")
	public String updateEmp(Emp emp, Model model) {
		log.info("updateEmp Start..."); 
		int updateCount = es.updateEmp(emp);
		System.out.println("컨트롤러 " + emp);
		System.out.println("empController es.updateEmp updateCount-->" + updateCount);

		/*
		 * model.addAttribute("uptCnt", updateCount); // #서비스임플에서 업데이트된 개수
		 * model.addAttribute("mt", "Message Test"); // # 메세지 테스트
		 */

		return "forward:listEmp";
	}
	
	// 유
	/*
	 * //직원 등록
	 * 
	 * @RequestMapping(value = "writeFormEmp") public String writeFormEmp(Model
	 * model) { System.out.println("empController writeFormEmp Start...");
	 * 
	 * // 부서 선택 List<Dept> deptList = es.deptSelect();
	 * model.addAttribute("deptList", deptList);
	 * System.out.println("EmpController deptList.size->" + deptList.size());
	 * 
	 * // 직급 선택 List<Emp> empList = es.empPosSelect(); model.addAttribute("empList",
	 * empList); System.out.println("EmpController empList.size->" +
	 * deptList.size());
	 * 
	 * // role 선택 int bcd = 100; // 권한(role) List<CommDto> roleList =
	 * cs.roleSelect(100); model.addAttribute("roleList", roleList);
	 * System.out.println("EmpController writeFormEmp3 roleList.size->" +
	 * roleList.size()); System.out.println("EmpController writeFormEmp3 roleList->"
	 * + roleList);
	 * 
	 * return "ny_views/writeFormEmp";
	 * 
	 * }
	 */

	
	// 직원 등록
	@RequestMapping(value = "writeFormEmp")
	public String writeFormEmp(Model model) {
	    System.out.println("empController writeFormEmp Start...");

	    // 부서 선택
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


	
	/*
	 * 직원번호 중복 여부
	 * 
	 * @GetMapping(value = "confirm") public String confirm(Emp emp1, Model model) {
	 * System.out.println("empController confirm START.. "); Emp emp =
	 * es.detailEmp(emp1.getDept_No()); model.addAttribute("empno",
	 * emp1.getDept_No()); if (emp != null) {
	 * System.out.println("empController confirm 중복된 사번.. ");
	 * model.addAttribute("msg", "중복된 사번입니다"); // return "forward:writeFormEmp"; }
	 * else { System.out.println("empController confirm 사용 가능한 사번.. ");
	 * model.addAttribute("msg", "사용 가능한 사번입니다"); // return "forward:writeFormEmp";
	 * } return "forward:writeFormEmp";
	 * 
	 * }
	 */

	
	// 업데이트 삭제 직원
	@RequestMapping(value = "deleteEmp")
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
		return "redirect:listEmp";
	}

	
	
	// 조회 관련
	// 상세조회, 전체조회X condTotalEmp / listSearchEmp(empSearchList3)
	@RequestMapping(value = "listSearch3")
	public String listSearch3(Emp emp, Model model) {
		System.out.println("EmpController Start listSearch3...");
		System.out.println("EmpController listSearch3 emp->" + emp);

		int totalEmp = es.condTotalEmp(emp);
		System.out.println("EmpController listSearch3 totalEmp=>" + totalEmp);

		Paging page = new Paging(totalEmp, emp.getCurrentPage());
		emp.setStart(page.getStart());
		emp.setEnd(page.getEnd());
		System.out.println("EmpController listSearch3 page=>" + page);

		List<Emp> listSearchEmp = es.listSearchEmp(emp);

		System.out.println("EmpController listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
		System.out.println("EmpController listSearch3 listSearchEmp=>" + listSearchEmp);

		model.addAttribute("totalEmp", totalEmp);
		model.addAttribute("listEmp", listSearchEmp);
		model.addAttribute("page", page);

		return "ny_views/list";
	}


}
