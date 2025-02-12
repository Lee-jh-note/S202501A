package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.PricePagingDto;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
import org.oracle.s202501a.service.jh_service.PriceHistoryService;
import org.oracle.s202501a.service.jh_service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class PriceController {

    private final PriceHistoryService priceHistoryService;

    // 조회, 검색
    @GetMapping("/All/Sales/PriceList")
    public String priceList(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "type", required = false) Integer type,
            PriceHistoryModel priceHistoryModel,
            Model model) {

        PricePagingDto response = priceHistoryService.getPriceHistoryList(priceHistoryModel, name, type);

        model.addAttribute("priceList", response.getList());
        model.addAttribute("page", response.getPage());
        model.addAttribute("SName", name);
        model.addAttribute("SType", type);
        return "jh_views/pricehistory/priceList";
    }

    // 지나간 날짜에 대한 가격 수정
    @GetMapping("/Sales/PriceModify")
    public String priceModify(Model model, PriceHistoryProductModel model2) {
        PriceHistoryModel model1 = priceHistoryService.findById(model2.getId());
        Map<String, Object> map = new HashMap<>();
        map.put("price", model1);
        map.put("product", model2.getProduct_name());
        map.put("prodNo", model2.getProduct_no());
//        System.out.println(model2.getProduct_name());
        model.addAttribute("priceHistoryModel", map);
        return "jh_views/pricehistory/priceModifyForm";
    }

    // 지나간 날짜에 대한 가격 수정
    @PostMapping("/Sales/PriceModifyAct")
    public String priceModifyAct(PriceHistoryModel priceHistoryModel) {
//        System.out.println(priceHistoryModel);
        priceHistoryService.oldPriceModify(priceHistoryModel);
        return "redirect:/All/Sales/PriceList";
    }
}
