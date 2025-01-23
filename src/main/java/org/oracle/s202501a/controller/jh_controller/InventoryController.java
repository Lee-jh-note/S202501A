package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.*;
import org.oracle.s202501a.service.jh_service.InventoryService;
import org.oracle.s202501a.service.jh_service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class InventoryController {
    private final InventoryService inventoryService;
    private final ProductService productService;


    @GetMapping("/Inven/InvenList")
    public String invenList(Model model,
                            InventoryDto inventoryDto,
                            @RequestParam(value = "product_name", required = false) String product_name,
                            @RequestParam(value = "yymm", required = false) String yymm) {

        // 서비스 호출: 조건에 맞는 결과 조회
        InvenPagingDto response = inventoryService.getInventoryList(inventoryDto, product_name, yymm);

        // 모델에 필요한 데이터 추가
        model.addAttribute("name", product_name);
        model.addAttribute("type", yymm);
        model.addAttribute("page", response.getPage());
        model.addAttribute("list", response.getList());
        model.addAttribute("inventoryDto", inventoryDto);

        return "jh_views/inventory/InvenList";  // 재고 목록 JSP 페이지
    }

    // 모달 이용해서 받아온 값으로 적정 수량만 업데이트 시키기
    @PostMapping("/Inven/OptimalModify")
    public String optimalModify(@RequestParam(value = "product_no", required = false) Long product_no,
                                @RequestParam("optimal_quantity") int optimal) {

        inventoryService.optimalModify(product_no, optimal);

        return "redirect:/Inven/InvenList";
    }

    // 재고 수기 등록
    @GetMapping("/Inven/Inven/Create")
    public String create(Model model) {
        List<ProductDto> prodList = productService.getProdNoName();
        model.addAttribute("prodList", prodList);
        return "jh_views/inventory/InvenCreate";
    }

    // 수기 등록 액션
    @PostMapping("/Inven/Inven/CreateAct")
    public String createAct(InventoryDto inventoryDto) {
        inventoryService.invenCreate(inventoryDto);
        return "redirect:/Inven/InvenList";
    }

    // 마감 처리
    @PostMapping("/Inven/Inven/Closing")
    public String closing(ClosingDto Dto) {

        inventoryService.closing(Dto);
        return "redirect:/Inven/InvenList";
    }

    @GetMapping("/Inven/Inven/ClosingCheck")
    @ResponseBody
    public String closingCheck(@RequestParam(name = "yymm") String yymm) {
        boolean isClosed = inventoryService.closingCheck(yymm);
        System.out.println("마감 체킹 "+ isClosed);
        if (isClosed) {
            return "1"; // 마감 이거나 데이터 없음
        } else {
            return "0"; // 마감 가능
        }
    }
}
