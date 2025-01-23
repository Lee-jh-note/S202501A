package org.oracle.s202501a.dto.jh_dto;


import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SPRecodesPagingDto {

    private List<SPRecodesDto> list;
    private PagingJH page;
    private String yymmdd;
    private String productName;


}
