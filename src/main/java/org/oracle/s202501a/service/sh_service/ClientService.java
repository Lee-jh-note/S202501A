package org.oracle.s202501a.service.sh_service;

import java.util.List;	


import org.oracle.s202501a.dto.sh_dto.ClientDTO;
import org.oracle.s202501a.dto.sh_dto.CommDto;
import org.oracle.s202501a.dto.sh_dto.DeptDTO;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public interface ClientService {
	int					   totalClient();
	List<ClientDTO>		   listClient(ClientDTO client);
	ClientDTO			   detailClient(int client_No);
	int                    updateClient(ClientDTO client);
	List<ClientDTO>        listManeger();
	int                    insertClient(ClientDTO client);
	int                    condTotalClient(ClientDTO client);
	List<ClientDTO>        listSearchClient(ClientDTO client);
	int                    deleteClient(ClientDTO client);
	List<EmpDTO>           empSelect();
	List<DeptDTO>          deptSelect();
	DeptDTO                detailDept(Long dept_No);
	int                    insertEmp(EmpDTO emp);
	List<CommDto>          roleSelect(int bcd); // role -> 100
	
	


	
}
