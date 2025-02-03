package org.oracle.s202501a.dao.sh__dao;

import java.util.List;		

import org.oracle.s202501a.dto.sh_dto.ClientDTO;


public interface ClientDAO {
	int					totalClient();
	List<ClientDTO>		listClient(ClientDTO client);
	ClientDTO				detailClient(int clientNo);
	int                 updateClient(ClientDTO client);
	List<ClientDTO>        listManger();
	int                 insertClient(ClientDTO client);
	int                 condTotalClient(ClientDTO client);
	List<ClientDTO>        clientSearchList3(ClientDTO client);
	int                 deleteClient(ClientDTO client);

}	
