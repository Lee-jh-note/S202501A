package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
import org.oracle.s202501a.service.jh_service.PriceHistoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class PriceController {

    private final PriceHistoryService priceHistoryService;

    @GetMapping("/Prod/PriceList")
    public String priceList(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "type", required = false) Integer type,
            Model model) {
        List<PriceHistoryProductModel> list = null;
        System.out.println("검색 이름 :" + name );
        System.out.println("검색 타입 : " + type);
        // type 0 = 매출, 1 = 매입

        // name != null, type 0 or 1 = 제품별 매입 또는 매출
        if(name != null && type != null) {
            list = priceHistoryService.findNyProdNamePur(name, type);
        }
        // name != null, type null = 제품별 매출, 매입 전체
        if (name != null && type == null) {
            list = priceHistoryService.findByProductName(name);
        }
        // name == null, type 0 or 1 = 모든 제품의 매입 내역
        if (name == null && type != null) {
            list = priceHistoryService.findByProdType(type);
        }
        // name == null, type == null 아무내역 없음.
        if (name == null && type == null) {
           List<PriceHistoryModel> priceList = priceHistoryService.listAll();
            model.addAttribute("priceList", priceList);
           return "jh_views/priceList";
        }

        model.addAttribute("priceList", list);
        return "jh_views/priceList";
    }

    //가격 생성인데 이게 왜 있지 필요없는거 같은데 ..
    @GetMapping("/Prod/PriceCreate")
    public String priceCreate(Model model) {

        return "jh_views/priceCreateForm";
    }
    //가격 생성인데 이게 왜 있지 필요없는거 같은데 ..
    @PostMapping("/Prod/PriceCreateAct")
    public String priceCreateAct(Model model, PriceHistoryModel priceHistoryModel) {


        if (priceHistoryModel.getPur_price() != null){
            priceHistoryService.priceCreateAct(priceHistoryModel);
        }
        if (priceHistoryModel.getSale_price() != null){
            priceHistoryService.priceCreateAct(priceHistoryModel);
        }

        return "empTest";
    }

    // 지나간 날짜에 대한 가격 수정
    @GetMapping("/Prod/PriceModify")
    public String priceModify(Model model, PriceHistoryModel priceHistoryModel) {

        PriceHistoryModel model1 = priceHistoryService.findById(priceHistoryModel.getId());

        model.addAttribute("priceHistoryModel", model1);
        return "jh_views/priceModifyForm";
    }

    // 지나간 날짜에 대한 가격 수정
    @PostMapping("/Prod/PriceModifyAct")
    public String priceModifyAct(Model model, @ModelAttribute("PriceHistoryModel") PriceHistoryModel priceHistoryModel) {
        System.out.println(priceHistoryModel);
        priceHistoryService.oldPriceModify(priceHistoryModel);

        return null;
    }
}
