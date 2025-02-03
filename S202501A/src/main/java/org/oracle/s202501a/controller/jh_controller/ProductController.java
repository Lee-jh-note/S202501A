package org.oracle.s202501a.controller.jh_controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.ProductDao;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.oracle.s202501a.dto.jh_dto.ProdCatePagingDto;
import org.oracle.s202501a.service.jh_service.ProdCategoryService;
import org.oracle.s202501a.service.jh_service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProductController {

    private final ProductService productService;
    private final ProductDao productDao;
    private final ProdCategoryService prodCategoryService;

    @GetMapping("/tttt")
    public String prodMain(Model model) {

        return "jh_views/ProdTest";
    }

    @RequestMapping("/Prod/ProdList")
    public String prodList(Model model,
                           ProductDto productDto,
                           @RequestParam(value = "name", required = false) String name,
                           @RequestParam(value = "type", required = false) Integer type) {

        ProdCatePagingDto response = productService.getProdList(productDto, name, type);

        model.addAttribute("name", name);
        model.addAttribute("type", type == null ? 0 : type);
        model.addAttribute("list", response.getProductList());
        model.addAttribute("page", response.getPagingJH());
        model.addAttribute("category", response.getCategoriesList());
        return "jh_views/product/prodList";
    }

    // 등록
    @GetMapping("/Prod/ProdCreate")
    public String prodCreate(Model model) throws JsonProcessingException {
        CategoriesDto category = prodCategoryService.ProdCateFindAll();

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonTopList = objectMapper.writeValueAsString(category.getTopList());
        String jsonMidList = objectMapper.writeValueAsString(category.getMidList());

        model.addAttribute("jsonTopList", jsonTopList);
        model.addAttribute("jsonMidList", jsonMidList);

        return "jh_views/product/prodCreateForm";
    }

    // 등록 액션
    @PostMapping("/Prod/ProdCreateAct")
    public String prodCreateAct(ProductPriceDto productPriceDtoDto, Model model) {
        System.out.println("등록 들어오자마자 컨트롤러 : " + productPriceDtoDto);
        productService.createProduct(productPriceDtoDto);
        return "redirect:/Prod/ProdList";
    }

    // 상세 페이지
    @GetMapping("/Prod/ProdDetails")
    public String prodDetails(@RequestParam("productNo") Long productNo, Model model) {
        ProductPriceDto dto = productService.prodDetails(productNo);
        model.addAttribute("ProductPrice", dto);
        return "jh_views/product/prodDetails";
    }

    // 수정 폼 이동
    @GetMapping("Prod/ProdModify")
    public String prodModify(Model model, @RequestParam("productNo") Long productNo) throws JsonProcessingException {

        ProductPriceDto dto = productService.prodDetails(productNo);
        CategoriesDto category = prodCategoryService.ProdCateFindAll();

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonTopList = objectMapper.writeValueAsString(category.getTopList());
        String jsonMidList = objectMapper.writeValueAsString(category.getMidList());

        model.addAttribute("jsonTopList", jsonTopList);
        model.addAttribute("jsonMidList", jsonMidList);
        model.addAttribute("ProductPrice", dto);

        return "jh_views/product/prodModifyForm";
    }

    // 수정 액션
    @PostMapping("/Prod/ProdModifyAct")
    public String prodModifyAct(ProductPriceDto productPriceDtoDto, Model model) {
        productService.prodModify(productPriceDtoDto);
        return "redirect:/Prod/ProdList"; // 수정 후 다시 리스트로

    }

    //제품 삭제
    @PostMapping("/Prod/ProdDelete")
    public String prodDelete(ProductDto productDto, Model model) {
        productService.prodDelete(productDto);
        return "redirect:/Prod/ProdList"; // 삭제 후 다시 리스트로
    }

    // 상태 일괄 변경
    @PostMapping("/Prod/Status")
    public String status(@RequestParam(value = "product_no", required = false) List<Long>product_no) {
        System.out.println("체크 들어오는지만 : " + product_no);
        productService.prodStatus(product_no);
        return "redirect:/Prod/ProdList"; // 수정 후 다시 리스트
    }
}
