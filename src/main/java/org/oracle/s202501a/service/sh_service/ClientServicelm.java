package org.oracle.s202501a.service.sh_service;

import java.util.List;			

import org.oracle.s202501a.dao.sh__dao.ClientDAO;
import org.oracle.s202501a.dao.sh__dao.CommDAO;
import org.oracle.s202501a.dao.sh__dao.DeptDAO;
import org.oracle.s202501a.dao.sh__dao.EmpDAO;
import org.oracle.s202501a.dto.sh_dto.ClientDTO;
import org.oracle.s202501a.dto.sh_dto.CommDto;
import org.oracle.s202501a.dto.sh_dto.DeptDTO;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClientServicelm implements ClientService {
	
	private final ClientDAO  cd;
	private final EmpDAO ed;
	private final DeptDAO dd;
	private final CommDAO od;
	
	@Override
	public int totalClient() {
			System.out.println("ClientServicelm totalClient Start");
			int totClient = cd.totalClient();
			System.out.println("ClientServicelm totalClient totClient" + totClient);
		return totClient;
	}

	@Override
	public List<ClientDTO> listClient(ClientDTO client) {
		List<ClientDTO> clientList = null;
		System.out.println("ClientServicelm listManager Start...");
		clientList = cd.listClient(client);
		System.out.println("ClientServicelm listClient clientSize()->"+clientList.size());
		return clientList;
	}

	@Override
	public ClientDTO detailClient(int client_No) {
		System.out.println("ClientServicelm detailClient....");
		ClientDTO client = null;
		client = cd.detailClient(client_No);
		return client;
	}

	@Override
	public int updateClient(ClientDTO client) {
		System.out.println("ClientServicelm update...");
		int updateCount = 0;
		updateCount = cd.updateClient(client);
		return updateCount;
	}

	@Override
	public List<ClientDTO> listManeger() {
		List<ClientDTO> clientList = null;
		System.out.println("ClientServiceImpl listManger Start...");
		clientList = cd.listManger();
		System.out.println("ClientServiceImpl listClient clientList.size()->"+clientList.size());
		return clientList;
		

	}
	
	@Override
	public int insertClient(ClientDTO client) {
		int result = 0;
		System.out.println("ClientServicelm insert Start....");
		result = cd.insertClient(client);
		return result;
	}

	@Override
	public int condTotalClient(ClientDTO client) {
		System.out.println("ClientServicelm Start total...");
		int totClientCnt =cd.condTotalClient(client);
		System.out.println("ClientServicelm totalEmp totClientCnt->" + totClientCnt);
		return totClientCnt;
	}

	@Override
	public List<ClientDTO> listSearchClient(ClientDTO client) {
		List<ClientDTO> clientSearchList = null;
		System.out.println("ClientServicelm listClient Start...");
		clientSearchList = cd.clientSearchList3(client);
		System.out.println("ClientServicelm listSearchEmp empSearchList.size()->"+clientSearchList.size());
		return clientSearchList;
	}

	@Override
	   public int deleteClient(ClientDTO client) {
	      System.out.println("EmpServiceImpl deleteEmp Start...");
	          int deleteupdate = cd.deleteClient(client); // DAO 호출
	          if (deleteupdate > 0) {
	             System.out.println("삭제 성공: emp_Delete = 1");
	          } else {
	             System.out.println("삭제 실패 또는 이미 삭제된 직원");
	          }
	          return deleteupdate;
	      }

	@Override
	public List<EmpDTO> empSelect() {
		List<EmpDTO> empList = null;
		System.out.println("ClientServicelm empSelect Start...");
		empList = ed.empSelect();
		System.out.println("ClientServicelm empSelect empList.size()->"+ empList.size());
		return empList;
	}

	@Override
	   public List<DeptDTO> deptSelect() {
	      List<DeptDTO> deptList = null;
	      System.out.println("EmpServiceImpl deptSelect Start..." );
	      deptList =  dd.deptSelect();
	      System.out.println("EmpServiceImpl deptSelect deptList.size()->" +deptList.size());
	      return deptList;
	   }

	@Override
	   public DeptDTO detailDept(Long dept_No) {
	      System.out.println("EmpServiceImpl detailDept ...");
	      DeptDTO dept = null;
	      dept = dd.detailDept(dept_No);
	      return dept;
	   }
	   

	@Override
	public int insertEmp(EmpDTO emp) {
		int result = 0;
	      System.out.println("EmpServiceImpl insert Start..." );
	      result = ed.insertEmp(emp);
	      return result;
	}

	@Override
	public List<CommDto> roleSelect(int bcd) {
		List<CommDto> roleList = null;
		System.out.println("ClientServicelm empSelect Start...");
		roleList = od.roleSelect(bcd);
		System.out.println("ClientServicelm empSelect empList.size()->"+ roleList.size());
		return roleList;
	}   

	

}
