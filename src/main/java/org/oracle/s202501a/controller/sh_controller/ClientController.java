package org.oracle.s202501a.controller.sh_controller;
		
import java.util.List;							

import org.oracle.s202501a.dto.sh_dto.ClientDTO;
import org.oracle.s202501a.dto.sh_dto.CommDto;
import org.oracle.s202501a.dto.sh_dto.DeptDTO;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.sh_service.ClientService;
import org.oracle.s202501a.service.sh_service.Paging;
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
public class ClientController {
	
	private final ClientService cs;
	
	@RequestMapping(value="All/Sales/listClient")
	public String listClient(ClientDTO client, Model model) {
		System.out.println("ClientController Start listClient...");
		
		int totalClient = cs.totalClient();
		System.out.println("ClientController listClient totalClient->"+totalClient);
		if (client.getCurrentPage() == null) client.setCurrentPage("1");
		
		Paging page = new Paging(totalClient,client.getCurrentPage());
		
		client.setStart(page.getStart());
		client.setEnd(page.getEnd());
		
		List<ClientDTO> listClient = cs.listClient(client);
		System.out.println("ClientController list listClient.size()=>" + listClient.size());
		
		model.addAttribute("totalClient"	, totalClient);
		model.addAttribute("listClient"		, listClient);
		model.addAttribute("page"			,page);
		return "sh_views/list";
	}
	
	@GetMapping(value="All/Sales/detailClient")
	public String detailClient(ClientDTO client1, Model model) {
		System.out.println("ClientController Strat detailClient");
		
		System.out.println("client->"+client1);
		ClientDTO client = cs.detailClient(client1.getClient_No());
		
		model.addAttribute("client",client);
		
		return "sh_views/detailClient";
	}
	
	@GetMapping(value = "/Sales/updateFormClient")
	public String updateFormClient(ClientDTO client1, Model model) {
		System.out.println("ClientController Start updateForm");
		ClientDTO client = cs.detailClient(client1.getClient_No());
		System.out.println("ClientController Start updateForm...");
		String reg_Date = "";
		if (client.getReg_Date() !=null) {
			reg_Date = client.getReg_Date().substring(0,10);
			client.setReg_Date(reg_Date);
		}
		System.out.println("reg_Date->"+reg_Date);
		
		model.addAttribute("client",client);
		return "sh_views/updateFormClient";
	}
	
	@PostMapping(value = "/Sales/updateClient")
	public String updateClient(ClientDTO client, Model model) {
		log.info("updateClient Start...");
		
		int updateCount = cs.updateClient(client);
		System.out.println("clientController cs.updateClient updateCount-->"+updateCount);
		model.addAttribute("uptCnt", updateCount);
		model.addAttribute("kk3","Message Test");
		
		return "redirect:/All/Sales/listClient";

	}
	
	@RequestMapping(value="/Sales/writeFormClient")
	public String writeFormClient(Model model) {
		System.out.println("clientController wirteFromClient Start...");
		List<ClientDTO> clientList = cs.listManeger();
		System.out.println("ClientController writeForm clientList.size->"+clientList.size());
		
		// client_Type 변환
	    for (ClientDTO client : clientList) {
	        if (client.getClient_Type() == 1) {
	            client.setClient_Type_Desc("매입처");
	        } else if (client.getClient_Type() == 0) {
	            client.setClient_Type_Desc("매출처");
	        }
	    }
		
		model.addAttribute("clientMngList",clientList);
		
		List<EmpDTO> empList = cs.empSelect();	
		model.addAttribute("empList", empList);
		System.out.println("ClientController writeForm empList.size->"+empList.size());
	
		return "sh_views/writeFormClient";	
				}	
	
	@PostMapping(value = "/Sales/writeClient")
	public String wrtieClient(ClientDTO client, Model model) {
		System.out.println("ClientController Start writeClient...");
		int insertResult = cs.insertClient(client);
		if(insertResult > 0) return "redirect:/All/Sales/listClient";
		else {
			model.addAttribute("msg","입력 실패 확인해보세요");

			return "forward:writeFormClient";
		}			
		
	}
	
	
	 @RequestMapping(value = "/Sales/deleteClient")
	   public String deleteClient(ClientDTO client, Model model) {
	       log.info("deleteClient Start...");
	          System.out.println("컨트롤러 " + client);

	          int result = cs.deleteClient(client); // 서비스 호출
	          if (result > 0) {
	              System.out.println("삭제 성공: client_Delete = 1");
	              model.addAttribute("msg", "직원 삭제(삭제 여부 1) 성공");
	          } else {
	              System.out.println("삭제 실패 또는 이미 삭제된 직원");
	              model.addAttribute("msg", "직원 삭제 실패");
	          }
	          model.addAttribute("client", client);
	          return "redirect:/All/Sales/listClient"; 
	      }
	 
			/*
			 * @RequestMapping(value = "writeFormEmp3") public String writeFormEmp3(Model
			 * model) { System.out.println("empController writeFormEmp3 Start...");
			 * 
			 * // 부서 선택 List<DeptDTO> deptList = cs.deptSelect();
			 * model.addAttribute("deptList", deptList);
			 * System.out.println("EmpController writeFormEmp3 deptList.size->" +
			 * deptList.size()); System.out.println("EmpController writeFormEmp3 deptList->"
			 * + deptList);
			 * 
			 * // 직급 선택 List<EmpDTO> empList = cs.empSelect(); model.addAttribute("empList",
			 * empList); System.out.println("EmpController writeFormEmp3 empList.size->" +
			 * empList.size()); System.out.println("EmpController writeFormEmp3 empList->" +
			 * empList);
			 * 
			 * // role 선택 int bcd = 100; // 권한(role) List<CommDto> roleList =
			 * cs.roleSelect(100); model.addAttribute("roleList", roleList);
			 * System.out.println("EmpController writeFormEmp3 roleList.size->" +
			 * roleList.size()); System.out.println("EmpController writeFormEmp3 roleList->"
			 * + roleList);
			 * 
			 * return "sh_views/writeFormEmp";
			 * 
			 * }
			 */
	 
	 @RequestMapping(value = "All/Sales/listSearchSh")
	   public String listSearch3(ClientDTO client, Model model) {
	      System.out.println("ClientController Start listSearchSh...");
	      System.out.println("EmpController listSearchSh client->"+client);
	      
	      int totalClient = cs.condTotalClient(client);
	      System.out.println("ClientController listSearchSh totalClient=>"+ totalClient);
	      
	      Paging page = new Paging(totalClient, client.getCurrentPage());
	      client.setStart(page.getStart());
	      client.setEnd(page.getEnd());
	      System.out.println("ClientController listSearchSh page=>" +page);
	      
	      List<ClientDTO> listSearchClient =cs.listSearchClient(client);
	      
	      System.out.println("ClientController listSearchSh listSearchClient.size()=>"+ listSearchClient.size());
	      System.out.println("ClientController listSearchSh listSearchEmp=>"+ listSearchClient);
	      
	      model.addAttribute("totalClient",totalClient );
	      model.addAttribute("listClient", listSearchClient);
	      model.addAttribute("page", page);
	      
	      
	      return "sh_views/list";
	   }

		
	
	
}
