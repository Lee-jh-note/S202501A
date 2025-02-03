package org.oracle.s202501a.controller.jh_controller;

import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;
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

    // 조회, 검색
    @GetMapping("/Inven/InvenList")
    public String invenList(Model model,
                            InventoryDto inventoryDto,
                            @RequestParam(value = "product_name", required = false) String product_name,
                            @RequestParam(value = "yymm", required = false) String yymm) {

        InvenPagingDto response = inventoryService.getInventoryList(inventoryDto, product_name, yymm);

        model.addAttribute("name", product_name);
        model.addAttribute("type", yymm);
        model.addAttribute("page", response.getPage());
        model.addAttribute("list", response.getList());
        model.addAttribute("inventoryDto", inventoryDto);
        List<ProductDto> prodList = productService.getProdNoName();
        model.addAttribute("prodList", prodList);

        return "jh_views/inventory/InvenList";
    }

    // 적정 수량 수정
    @PostMapping("/Inven/OptimalModify")
    public String optimalModify(@RequestParam(value = "product_no", required = false) Long product_no,
                                @RequestParam("optimal_quantity") int optimal) {

        System.out.println(product_no+ " 타겟 수량 : " + optimal);
        inventoryService.optimalModify(product_no, optimal);

        return "redirect:/Inven/InvenList";
    }

//    // 재고 수기 등록
//    @GetMapping("/Inven/Inven/Create")
//    public String create(Model model) {
//        List<ProductDto> prodList = productService.getProdNoName();
//        model.addAttribute("prodList", prodList);
//        return "jh_views/inventory/InvenList";
//    }

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

    // 마감 진행 확인
    @GetMapping("/Inven/Inven/ClosingCheck")
    @ResponseBody
    public String closingCheck(@RequestParam(name = "yymm") String yymm) {
        boolean isClosed = inventoryService.closingCheck(yymm);
//        System.out.println("마감 체킹 "+ isClosed);
        if (!isClosed) {
            return "0"; // false 가오면 마감 불가능
        } else {
            return "1"; // true 면 마감이 되어야 하는데 ..? 왜 ?
        }
    }

//    @ResponseBody
    @PostMapping("/Inven/QuantityModify")
    public String QuantityModify(@RequestParam("prodNo") Long prodNo,
                                 @RequestParam("quantity") int quantity) {

        inventoryService.QuantityModify(prodNo, quantity);

        return "redirect:/Inven/InvenList";
    }
}
