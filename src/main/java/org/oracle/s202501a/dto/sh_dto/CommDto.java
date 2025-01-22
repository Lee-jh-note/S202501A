package org.oracle.s202501a.dto.sh_dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommDto {
	private int bcd;
	private int mcd;
	private String content;
	private String bigo;
}
