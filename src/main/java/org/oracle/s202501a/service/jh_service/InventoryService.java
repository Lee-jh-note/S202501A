package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.InventoryDao;
import org.oracle.s202501a.dto.jh_dto.ClosingDto;
import org.oracle.s202501a.dto.jh_dto.InvenPagingDto;
import org.oracle.s202501a.dto.jh_dto.InventoryDto;
import org.oracle.s202501a.dto.jh_dto.PagingJH;
import org.oracle.s202501a.service.sh_service.UserService;
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
    private final UserService userService;


    public InvenPagingDto getInventoryList(InventoryDto inventoryDto, String product_name, String yymm) {

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
        String date = inventoryDto.getYymm().replace("-", "/").substring(2);
        inventoryDto.setYymm(date);
        inventoryDao.invenCreate(inventoryDto);
    }

    public void closing(ClosingDto dto) {

        String date = dto.getYymm().replace("-", "/").substring(2);
        dto.setYymm(date);

        long emp_no = userService.getSe().getEmp_No();
        dto.setEmp_no((int)emp_no);
        inventoryDao.closing(dto);
    }

    public boolean closingCheck(String yymm) {

        String ym = yymm.substring(2).replace("-", "/");
        return inventoryDao.closingCheck(ym) == 0; // 반환 0 이면 트루 리턴 1 이면 펄스 리턴
    }

//    public InventoryDto InvenFindByProdName(Long prodNo) {
//        return inventoryDao.InvenFindByProdName(prodNo);
//    }

    public void QuantityModify(Long prodNo, int quantity) {

//        System.out.println("서비스 수정 타겟 : " + prodNo + " / " + quantity);
        // 기말 체크
        InventoryDto ClosingDto = inventoryDao.findStockByProdStock(prodNo, 1);
//        System.out.println("기말 : " + ClosingDto);
        // 기초 체크
        InventoryDto BeginningDto = inventoryDao.findStockByProdStock(prodNo, 0);
//        System.out.println("기초 : " + BeginningDto);
        int result;

        // 기초도 있고 기말고 있을경우
        if (ClosingDto != null && BeginningDto != null) {
            int closingQuantity = quantity - ClosingDto.getQuantity();
            ClosingDto.setQuantity(quantity);
            inventoryDao.quantityModify(ClosingDto);

            result = Math.max((BeginningDto.getQuantity() + closingQuantity), 0);

            BeginningDto.setQuantity(result);
            inventoryDao.quantityModify(BeginningDto);
        }
        // 기말은 없고 기초만 있을경우
         else if (BeginningDto != null) {
            BeginningDto.setQuantity(quantity);
             inventoryDao.quantityModify(BeginningDto);

             // 기초는 없고 기말만 있을경우
        } else if(ClosingDto != null) {
             // 타겟값 이랑 현재 값 비교
            int closingQuantity = Math.max(quantity - ClosingDto.getQuantity(), 0);
            // 기말 업데이트
            ClosingDto.setQuantity(quantity);
            inventoryDao.quantityModify(ClosingDto);

            // 새로운 기초도 등록
            SimpleDateFormat sdf = new SimpleDateFormat("yy/MM");
            String date = sdf.format(new Date());
            InventoryDto inventoryDto = new InventoryDto();
            inventoryDto.setProduct_no(prodNo);
            inventoryDto.setQuantity(closingQuantity);
            inventoryDto.setYymm(date);
            inventoryDto.setOptimal_quantity(0);
            inventoryDao.invenCreate(inventoryDto);
        }

    }

    public void dayClosing() {
        ClosingDto dto = new ClosingDto();
        String yymm = new SimpleDateFormat("yy/MM").format(new Date());
        long emp_no = userService.getSe().getEmp_No();
        dto.setEmp_no((int)emp_no);
        dto.setYymm(yymm);

        System.out.println("Tyymm : " + yymm);
        System.out.println("Temp_no : " + emp_no);

        inventoryDao.dayClosing(dto);
    }
}
