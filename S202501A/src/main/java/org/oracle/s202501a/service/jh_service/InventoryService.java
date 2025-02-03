package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.InventoryDao;
import org.oracle.s202501a.dto.jh_dto.ClosingDto;
import org.oracle.s202501a.dto.jh_dto.InvenPagingDto;
import org.oracle.s202501a.dto.jh_dto.InventoryDto;
import org.oracle.s202501a.dto.jh_dto.PagingJH;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class InventoryService {

    private final InventoryDao inventoryDao;
    private final PagingService pagingService;


    public InvenPagingDto getInventoryList(InventoryDto inventoryDto, String product_name, String yymm) {
        // 1. 기본값 처리 및 날짜 형식 변경

        System.out.println("서비스 프로 네임 : " + product_name);
        System.out.println("서비스 yymm : " + yymm);
        if (inventoryDto.getCurrentPage() == null) {
            inventoryDto.setCurrentPage("1");
        }
        if (yymm != null && !yymm.isEmpty()) {
            String formattedYymm = yymm.substring(2).replace('-', '/');
            inventoryDto.setYymm(formattedYymm);
        }
        if (yymm == null) {
            yymm = new SimpleDateFormat("yy/MM").format(new Date());
            inventoryDto.setYymm(yymm);
        }
        if (product_name != null && !product_name.isEmpty()) {
            inventoryDto.setProduct_name(product_name);
        }

        // 2. 데이터 조회 및 페이징 처리
        int total;
        List<InventoryDto> list;
        PagingJH page;

            total = searchCount(inventoryDto);
            page = pagingService.getPagingInfo(total, inventoryDto.getCurrentPage());
            inventoryDto.setStart(page.getStart());
            inventoryDto.setEnd(page.getEnd());
            list = invenSearchList(inventoryDto);

        // 3. 응답 DTO 반환
        return new InvenPagingDto(list, page);
    }


    public List<InventoryDto> invenSearchList(InventoryDto inventoryDto) {

        return inventoryDao.SearchInvenList(inventoryDto);

    }

    public void optimalModify(Long productNo, int optimal) {
        InventoryDto inventoryDto = new InventoryDto();
        inventoryDto.setProduct_no(productNo);
        inventoryDto.setOptimal_quantity(optimal);
        inventoryDao.OptimalModify(inventoryDto);
    }


    public int searchCount(InventoryDto inventoryDto) {
        return inventoryDao.SearchCount(inventoryDto);
    }

    public void invenCreate(InventoryDto inventoryDto) {
        String date = inventoryDto.getYymm().replace("-","/").substring(2);
        inventoryDto.setYymm(date);
        inventoryDao.invenCreate(inventoryDto);
    }

    public void closing(ClosingDto dto) {
        String date = dto.getYymm().replace("-","/").substring(2);
        dto.setYymm(date);
        dto.setEmp_no(1); // 세션에서 가져와야하지만 임시로
        inventoryDao.closing(dto);
    }

    public boolean closingCheck(String yymm) {
       return inventoryDao.closingCheck(yymm);
    }
}
