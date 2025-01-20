package org.oracle.s202501a.controller.jh_controller;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.oracle.s202501a.service.jh_service.Paging;
import org.oracle.s202501a.service.jh_service.ProductService;
import org.oracle.s202501a.service.jh_service.SPRecodesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class SPRecodesController {

    private final SPRecodesService spRecodesService;
    private final ProductService productService;

    @GetMapping("/Recodes/List")
    public String RecodeList(Model model, SPRecodesDto spRecodesDto,
                             @RequestParam(value = "yymmdd", required = false) String yymmdd,
                             @RequestParam(value = "product_name", required = false) String product_name) {


        if (yymmdd != null && !yymmdd.isEmpty()) {
            // 2025-01 형식으로 오는 데이터 25/01 형태로 변경
            String formattedYymm = yymmdd.substring(2).replace('-','/'); // '2025/01' -> '25/01'
            spRecodesDto.setYymmdd(formattedYymm);
        }
        // 초기 검색값이 없다면 당월값만 조회
//        System.out.println("널 체크 전에 : " + yymmdd);
        if (yymmdd == null) {
            yymmdd = new SimpleDateFormat("yy/MM").format(new Date());
//            System.out.println("널 들어옴 ");
        spRecodesDto.setYymmdd(yymmdd);
//            System.out.println("널 들어오고 나서 셋팅된 yymmdd :  " + spRecodesDto.getYymmdd());
        }

//        System.out.println("검색값 확인 : " + product_name);
//        System.out.println("검색값 확인2 : " + yymmdd);
        int total = spRecodesService.SPRecodesFindAllCnt(spRecodesDto);
        if (spRecodesDto.getCurrentPage() == null) {
//            System.out.println("겟 쿼런트 널 이라서 1로 함");
            spRecodesDto.setCurrentPage("1");
        }
        Paging page = new Paging(total, spRecodesDto.getCurrentPage());
        spRecodesDto.setStart(page.getStart());
        spRecodesDto.setEnd(page.getEnd());
        List<SPRecodesDto> list = spRecodesService.SPRecodesFindAll(spRecodesDto);


//        System.out.println("왜 3페이지 까지 나오지 토탈 몇개 ? " + total);
//        System.out.println("");
//        System.out.println("컨트로러에서 모델로 주기 전 : " + list);
        model.addAttribute("recode", list);
        model.addAttribute("page", page);
        model.addAttribute("yymmdd", yymmdd);
        model.addAttribute("name", product_name);

        return "jh_views/recodes/recodeList";
    }
}
