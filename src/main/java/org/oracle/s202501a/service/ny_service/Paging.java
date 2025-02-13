package org.oracle.s202501a.service.ny_service;

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

	//  새로운 생성자 (int)
		public Paging(int total, int currentPage) {
			this.total = total;
			this.currentPage = currentPage;
			initializePaging();
		}
		//  페이징 계산 메서드 분리
		private void initializePaging() {
			start = (currentPage - 1) * rowPage + 1;
			end = start + rowPage - 1;

			totalPage = (int) Math.ceil((double) total / rowPage);

			startPage = currentPage - (currentPage - 1) % pageBlock;
			endPage = startPage + pageBlock - 1;

			if (endPage > totalPage) {
				endPage = totalPage;
			}
		}
		
	public Paging(int total, String currentPage1) {
		this.total = total;    
		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);		
		}
	            
		start = (currentPage - 1) * rowPage + 1;   
		end   = start + rowPage - 1;              
		                
		totalPage = (int) Math.ceil((double)total / rowPage);  
		                   
		startPage = currentPage - (currentPage - 1) % pageBlock;   
		endPage = startPage + pageBlock - 1;  
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}


	

}
