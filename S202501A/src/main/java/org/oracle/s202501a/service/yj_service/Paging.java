package org.oracle.s202501a.service.yj_service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Paging {

	private int currentPage = 1;	private int rowPage   = 15;
	private int pageBlock = 15;		
	private int start;				private int end;
	private int startPage;			private int endPage;
	private int total;				private int totalPage;

	public Paging(int total, String currentPage1) {
		this.total = total;    // 18
		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);	// 1		
		}
		//           1               10
		start = (currentPage - 1) * rowPage + 1;  // 시작시 1     11   
		end   = start + rowPage - 1;              // 시작시 10    20   
		                 //                 18  /   10 
		totalPage = (int) Math.ceil((double)total / rowPage);  // 시작시 2  
		            //   1         1
		startPage = currentPage - (currentPage - 1) % pageBlock; // 시작시 1    
		endPage = startPage + pageBlock - 1;  // 10
		//    10        14
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
}
