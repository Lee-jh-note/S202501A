package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.ProductDao;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.oracle.s202501a.service.jh_service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProductController {

    private final ProductService productService;
    private final ProductDao productDao;

    // 리스트
    @GetMapping("/Prod/ProdList")
    public String prodList(Model model,
                           @RequestParam(value = "ProductDto", required = false) ProductDto productDto) {
        List<ProductDto> list = null;
        if (productDto == null) {
            list = productService.findAll();
        } else {
            list = productService.ProdSearch(productDto);
        }
        model.addAttribute("list", list);
        return "jh_views/prodList";
    }

    //
//    // 검색 조건이 초가 된 리스트
//    @GetMapping("/Prod/ProdSearch")
//    public String prodSearch(Model model, ProductDto productDto) {
//        List<ProductDto> list = productService.ProdSearch(productDto);
//        model.addAttribute("list", list);
//        return "redirect:/Prod/ProdList";
//    }
    // 등록
    @GetMapping("/Prod/ProdCreate")
    public String prodCreate(Model model) {

        return "jh_views/prodCreateForm";
    }

    // 등록 액션
    @PostMapping("/Prod/ProdCreateAct")
    public String prodCreateAct(ProductPriceDto productPriceDtoDto, Model model) {
        productService.CreateProduct(productPriceDtoDto);
        return "forward:/jh_views/prodList";
    }

    // 상세 페이지
    @GetMapping("/Prod/ProdDetails")
    public String prodDetails(ProductPriceDto productPriceDtoDto, Model model) {
        ProductPriceDto dto = productService.ProdDetails(productPriceDtoDto);
        model.addAttribute("ProductPrice", dto);

        return "디테일 페이지 아직 미완";
    }

    @GetMapping("Prod/ProdModify")
    public String prodModify(Model model) {
        return "jh_views/prodModifyForm"; // 안만듬
    }
    @PostMapping("/Prod/ProdModifyAct")
    public String prodModifyAct(ProductPriceDto productPriceDtoDto, Model model) {
        productService.ProdModify(productPriceDtoDto);
        return "forward:/jh_views/prodList"; //

    }
}
