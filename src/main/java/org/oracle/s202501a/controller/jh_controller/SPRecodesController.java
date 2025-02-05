package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.oracle.s202501a.dto.jh_dto.SPRecodesPagingDto;
import org.oracle.s202501a.service.jh_service.SPRecodesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequiredArgsConstructor
@Slf4j
public class SPRecodesController {

    private final SPRecodesService spRecodesService;

    @GetMapping("/Recodes/List")
    public String recodeList(Model model, SPRecodesDto spRecodesDto,
                             @RequestParam(value = "yymmdd", required = false) String yymmdd,
                             @RequestParam(value = "product_name", required = false) String productName) {

        SPRecodesPagingDto response = spRecodesService.getSPRecodesList(spRecodesDto, yymmdd, productName);

        model.addAttribute("recode", response.getList());
        model.addAttribute("page", response.getPage());
        model.addAttribute("yymmdd", response.getYymmdd());
        model.addAttribute("name", response.getProductName());

        return "jh_views/recodes/recodeList";


    }

}
