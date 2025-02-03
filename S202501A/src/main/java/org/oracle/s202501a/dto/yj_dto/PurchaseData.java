package org.oracle.s202501a.dto.yj_dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseData { // 발주서 insert 할 때 사용
    private Purchase01 purchase; // Purchase01 클래스
    private List<Purchase_details> purchaseDetails; // Purchase_details 클래스
}
