package org.oracle.s202501a.controller.jh_controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.oracle.s202501a.service.jh_service.ProdCategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProdCategoryController {

    private final ProdCategoryService prodCategoryService;

    // 리스트 where top = 500
    @GetMapping("/Prod/Category/List")
    public String ProdCategoryList(Model model) {
        CategoriesDto dto = prodCategoryService.ProdCateFindAll();
        List<CategoriesDto> topList = dto.getTopList();
        List<CategoriesDto> midList = dto.getMidList();

        model.addAttribute("topList", topList);
        model.addAttribute("midList", midList);
        return "jh_views/category/categoryPopup";
    }
    // 생성 폼
    @GetMapping("/Prod/Category/Create")
    public String ProdCategoryCreate(Model model) {

        return "jh_views/category/ProdCateCreateForm";
    }
    // 생성 act
    @PostMapping("/Prod/Category/CreateAct")
    public String ProdCategoryCreateAct(@ModelAttribute CategoriesDto categoriesDto) {
        prodCategoryService.ProdCateCreate(categoriesDto);
        return "redirect:/Prod/Category/List";
    }

    // 상세 에서 수정 삭제까지 구현 해야함
    @GetMapping("/Prod/Category/Detail")
    public String ProdCategoryDetail(Model model, @ModelAttribute CategoriesDto categoriesDto) {
        CategoriesDto dto = prodCategoryService.ProdCateDetails(categoriesDto);
        model.addAttribute("CateDetails", dto);
        return "jh_views/ProdCateDetail";
    }

    // 수정 및 삭제 폼
    @GetMapping("/Prod/Category/Modify")
    public String ProdCategoryModify(Model model, @ModelAttribute CategoriesDto categoriesDto) {
        CategoriesDto dto = prodCategoryService.ProdCateDetails(categoriesDto);
        model.addAttribute("category", dto);
        return "jh_views/category/ProdCateModifyForm";
    }

    // 수정 act
    @PostMapping("/Prod/Category/ModifyAct")
    public String ProdCategoryModify(@ModelAttribute CategoriesDto categoriesDto) {
        System.out.println("수정 액션 들어온 내용 :" + categoriesDto);
        prodCategoryService.ProdCateModify(categoriesDto);
        return "redirect:/Prod/Category/List";
    }

    // 삭제
    @PostMapping("/Prod/Category/Delete")
    public String ProdCategoryDelete(@ModelAttribute CategoriesDto categoriesDto) {
        prodCategoryService.ProdCateDelete(categoriesDto);
        return "redirect:/Prod/Category/List";
    }


}
