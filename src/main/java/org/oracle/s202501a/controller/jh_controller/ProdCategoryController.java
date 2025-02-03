package org.oracle.s202501a.controller.jh_controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.oracle.s202501a.service.jh_service.ProdCategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProdCategoryController {

    private final ProdCategoryService prodCategoryService;


    @GetMapping("/Prod/Category/List")
    public String ProdCategoryList(Model model) {
        CategoriesDto dto = prodCategoryService.prodCateFindAll();
        List<CategoriesDto> topList = dto.getTopList();
        List<CategoriesDto> midList = dto.getMidList();
        model.addAttribute("topList", topList);
        model.addAttribute("midList", midList);
        return "jh_views/category/categoryPopup";
    }

    // 생성 폼
    @GetMapping("/Prod/Category/Create")
    public String ProdCategoryCreate(Model model) throws JsonProcessingException {
        CategoriesDto category = prodCategoryService.prodCateFindAll();

        List<CategoriesDto> dto = category.getTopList();
        model.addAttribute("top_list", dto);
        return "jh_views/category/ProdCateCreateForm";
    }

    //  한번에 추가
    @PostMapping("/Prod/Category/add")
    @ResponseBody
    public String addSubCategory(@RequestParam(value = "newMidCategory", required = false) String newMidCategory,
                                 @RequestParam(value = "newTopCategory", required = false) String newTopCategory) {
        prodCategoryService.prodCateCreate(newMidCategory, newTopCategory);
        return "redirect:/Prod/Category/List";
    }

    // 대분류 선택 후 추가
    @PostMapping("/Prod/Category/Create")
    public String createSubCategory(CategoriesDto dto) {
//        System.out.println("컨트롤러 : " + dto);
        prodCategoryService.prodCateCreateMid(dto);

        return "redirect:/Prod/Category/List";
    }

    // 수정 및 삭제 폼
    @GetMapping("/Prod/Category/Modify")
    public String ProdCategoryModify(Model model, @ModelAttribute CategoriesDto categoriesDto) {
//        System.out.println("컨트롤러 수정 타겟 : " + categoriesDto);
        CategoriesDto dto = prodCategoryService.prodCateDetails(categoriesDto);
//        System.out.println("컨트롤러 수정: " + dto);
        model.addAttribute("category", dto);
        return "jh_views/category/ProdCateModifyForm";
    }

    // 수정 act
    @PostMapping("/Prod/Category/ModifyAct")
    public String ProdCategoryModify(@ModelAttribute CategoriesDto categoriesDto) {
//        System.out.println("수정 액션 들어온 내용 :" + categoriesDto);
        prodCategoryService.prodCateModify(categoriesDto);
        return "redirect:/Prod/Category/List";
    }

    // 삭제
    @PostMapping("/Prod/Category/Delete")
    public String ProdCategoryDelete(@ModelAttribute CategoriesDto categoriesDto) {
        prodCategoryService.prodCateDelete(categoriesDto);
        return "redirect:/Prod/Category/List";
    }


}
