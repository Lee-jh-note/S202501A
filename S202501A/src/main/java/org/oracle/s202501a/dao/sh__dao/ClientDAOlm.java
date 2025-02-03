package org.oracle.s202501a.dao.sh__dao;

import java.util.List;					

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.sh_dto.ClientDTO;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ClientDAOlm implements ClientDAO {

	private final SqlSession session;
	
	@Override
	public int totalClient() {
		int totalClientCount = 0;
		System.out.println("Clientlm Start totalClient");
		try {
			totalClientCount = session.selectOne("clientTotal");
			System.out.println("Clientlm totalClient totClientCount->" +totalClientCount);
		} catch(Exception e) {
			System.out.println("Clientlm totalClient e.getMessage()->"+e.getMessage());
		}
		return totalClientCount;
	}

	@Override
	public List<ClientDTO> listClient(ClientDTO client) {
		List<ClientDTO> clientList = null;
		try {
			clientList = session.selectList("shlistClient", client);
			System.out.println("Clientlm listClient clientList.size()->"+clientList.size());
			System.out.println("Clientlm listClient clientList->"+clientList);
		} catch (Exception e) {
			System.out.println("Clientlm listClient e.getMessage()->"+e.getMessage());
		}
		return clientList;
	}

	@Override
	public ClientDTO detailClient(int client_no) {
		System.out.println("Clientlm detail start...");
		ClientDTO client = new ClientDTO();
		try {
			client = session.selectOne("shdetailClient", client_no);
			System.out.println("Clientlm detail client->"+client);
		} catch (Exception e) {
			System.out.println("Clientlm detail Exception->"+e.getMessage());
		}
		return client;
	}
	 
	@Override
	public int updateClient(ClientDTO client) {
		System.out.println("Client update start...");
		int updateCount = 0;
		try {
			updateCount = session.update("shupdateClient", client);
		} catch (Exception e) {
			System.out.println("ClientDaolm updateClient Exception->"+e.getMessage());
		}
		return updateCount;
	}

	@Override
	public List<ClientDTO> listManger() {
		List<ClientDTO> clientList = null;
		System.out.println("ClientDaolm listClient Start...");
		try {
			clientList = session.selectList("shListManger");
		} catch (Exception e) {
			System.out.println("ClientDaolm listClient Exception->"+e.getMessage());
		}
		
		
		return clientList;
	}

	@Override
	public int insertClient(ClientDTO client) {
		int result = 0;
		System.out.println("ClientDaolm insert Start...");
		System.out.println("ClientDaolm insert client->"+client);
		try {
				result = session.insert("shinsertClient",client);
		} catch (Exception e) {
			System.out.println("ClientDaolm insert Exception->"+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int condTotalClient(ClientDTO client) {
		int totClientCount = 0;
		System.out.println("ClientDaolm Start condTotalEmp");
		
		try {
			totClientCount = session.selectOne("condClientTotal", client);
			System.out.println("ClientDaolm totalClient totClientCount->"+totClientCount);
		} catch (Exception e) {
			System.out.println("ClientDaolm totalClient Exception->"+e.getMessage());
		}
		return totClientCount;
	}

	@Override
	public List<ClientDTO> clientSearchList3(ClientDTO client) {
		List<ClientDTO> clientSearchList3 = null;
		System.out.println("ClientDaolm clientSearchList3 Start...");
		try {
			clientSearchList3 = session.selectList("shClientSearchList3", client);
		} catch (Exception e) {
			System.out.println("ClientDaolm listClient Exception->"+e.getMessage());
		}
		return clientSearchList3;
	}

	@Override
	   public int deleteClient(ClientDTO client) {
	      System.out.println("ClientDaoImpl delete start..");
	      int deleteupdate = 0;
	      System.out.println("ClientDaoImpl delete client_No->" + client);
	      try {
	         deleteupdate = session.update("shDeleteClient", client);
	         System.out.println("ClientDaolm delete result->" + deleteupdate);
	      } catch (Exception e) {
	         System.out.println("ClientDaolm delete Exception->" + e.getMessage());
	      }

	      return deleteupdate;
	   }


}
