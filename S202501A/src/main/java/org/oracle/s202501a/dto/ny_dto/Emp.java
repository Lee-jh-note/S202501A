package org.oracle.s202501a.dto.ny_dto;


import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Emp {

	   private Long emp_No;       // 사원 번호
	   @NotEmpty
	    private String emp_Name;   // 이름
	    private Long dept_No;      // 부서 번호
	    private String Position; //직급
	    private String emp_Tel;    // 전화번호
	    private String emp_Email;  // 이메일
		
		private String birth; 		// 생년월일
		private String hiredate; // 입사일
		
		private String username; //id => username으로 변경
		private String password;
		
		private String dept_Name; //부서이름
		private String dept_Tel;  // 부서전화번호
		
		
		
	    //페이징 조회용
		private String search;   	   private String keyword;
		private String pageNum;  
		private int start; 		 	   private int end;
		// Page 정보
		private String currentPage;


	    
}
