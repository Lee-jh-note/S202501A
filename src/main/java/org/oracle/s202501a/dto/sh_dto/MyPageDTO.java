package org.oracle.s202501a.dto.sh_dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MyPageDTO {
	  private String oldPassword;
	  private String newPassword;
}
