package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.InventoryDao;
import org.oracle.s202501a.dao.jh_dao.ProductDao;
import org.oracle.s202501a.dto.jh_dto.*;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.repository.jh_repository.PriceHistoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductDao productDao;
    private final PriceHistoryRepository priceHistoryRepository;
    private final PriceHistoryService priceHistoryService;
    private final InventoryDao inventoryDao;
    private final ProdCategoryService prodCategoryService;
    private final PagingService pagingService;

    // 전체 리스트
    public ProdCatePagingDto getProdList(ProductDto productDto, String name, Integer type) {
        // 총 상품 수 조회
        int total = prodTotal();

        // 페이징 처리
        PagingJH page = pagingService.getPagingInfo(total, productDto.getCurrentPage());
        productDto.setStart(page.getStart());
        productDto.setEnd(page.getEnd());

        // 카테고리 정보 조회
        CategoriesDto categoriesDto = prodCategoryService.prodCateFindAll();
        List<CategoriesDto> cataDto = categoriesDto.getTopList();

        // 상품 검색 기능
        List<ProductDto> list;
        if (name != null) {
            productDto.setProduct_name(name);
            productDto.setCategory(type);
            total = prodSearchTotal(productDto);
            page = pagingService.getPagingInfo(total, productDto.getCurrentPage());
            productDto.setStart(page.getStart());
            productDto.setEnd(page.getEnd());
            list = prodSearch(productDto);
        } else {
            list = productDao.ProdFindAll(productDto);
        }

        return new ProdCatePagingDto(list, cataDto, page);
    }


    // 등록
    public void createProduct(ProductPriceDto productpriceDto) {
        // 제품 테이블 등록
        ProductDto dto = new ProductDto();
        dto.setProduct_name(productpriceDto.getProduct_name());
        dto.setDescription(productpriceDto.getDescription());
        dto.setCategory(productpriceDto.getCategory());
        dto.setMid_category(productpriceDto.getMid_category());
        productDao.CreateProd(dto);


        // 매퍼에서 셀렉트 키 사용해서 인서트 후 바로 product_no 반환 해서
        // 반환된 넘버로 가격 테이블 등록
        PriceHistoryModel priceHistoryModel = new PriceHistoryModel();
        priceHistoryModel.setProduct_no(dto.getProduct_no());
        priceHistoryModel.setPur_price(productpriceDto.getPur_price());
        priceHistoryModel.setSale_price(productpriceDto.getSale_price());
        priceHistoryService.priceCreateAct(priceHistoryModel);
    }

    // 상제 페이지
    public ProductPriceDto prodDetails(Long product_no) {
        List<ProductPriceDto> dtoList = productDao.ProdDetails(product_no);

        // dtd에 있는 구매 판매 구분과 판매 가격에 따라서 하나의 list > 하나의 dto로
        ProductPriceDto resultDto = new ProductPriceDto();

        for (ProductPriceDto dto : dtoList) {
            // 각 DTO에서 필요한 정보를 설정
            resultDto.setProduct_no(dto.getProduct_no());
            resultDto.setProduct_name(dto.getProduct_name());
            resultDto.setDescription(dto.getDescription());
            resultDto.setStatus(dto.getStatus());
            resultDto.setCategory(dto.getCategory());
            resultDto.setMid_category(dto.getMid_category());
            resultDto.setReg_date(dto.getReg_date());
            resultDto.setContent(dto.getContent());
            resultDto.setTitle(dto.getTitle());

            // sale_or_purchase 값에 따라 sale_price 또는 pur_price 값을 설정
            if (dto.getSale_or_purchase() == 1) {
                resultDto.setSale_price(dto.getPrice());  // sale_or_purchase == 1인 경우 sale_price에 값 설정
            }
            if (dto.getSale_or_purchase() == 0) {
                resultDto.setPur_price(dto.getPrice());   // sale_or_purchase == 0인 경우 pur_price에 값 설정
            }
        }
        return resultDto;
    }

    // 검색 조건 있는 리스트
    public List<ProductDto> prodSearch(ProductDto productDto) {
        return productDao.ProdSearch(productDto);

    }

    // 수정
    public void prodModify(ProductPriceDto productPriceDto) {
        // product 테이블 수정
        ProductDto dto = new ProductDto();
        dto.setProduct_name(productPriceDto.getProduct_name());
        dto.setDescription(productPriceDto.getDescription());
        dto.setCategory(productPriceDto.getCategory());
        dto.setProduct_no(productPriceDto.getProduct_no());
        dto.setMid_category(productPriceDto.getMid_category());
        dto.setStatus(productPriceDto.getStatus());
        productDao.ProdModify(dto);

        // priceHistory 테이블 구매 가격 수정
        PriceHistoryModel purModel = new PriceHistoryModel();
        purModel.setProduct_no(dto.getProduct_no());
        purModel.setPrice(productPriceDto.getPur_price());
        purModel.setSale_or_purchase(0);
        priceHistoryService.priceModifyAct(purModel);

        // priceHistory 테이블 판매 가격 수정
        PriceHistoryModel saleModel = new PriceHistoryModel();
        saleModel.setProduct_no(dto.getProduct_no());
        saleModel.setPrice(productPriceDto.getSale_price());
        saleModel.setSale_or_purchase(1);
        priceHistoryService.priceModifyAct(saleModel);

    }

    // 삭제
    public void prodDelete(ProductDto productDto) {
        long product_no = productDto.getProduct_no();
        // product, inventory, pricehistory 각각 테이블 연쇄 삭제
        productDao.ProdDelete(product_no);
        inventoryDao.ProdDelQuantModify(product_no);
        priceHistoryRepository.ProdDelDateModify(product_no);

    }

    // 상태 수정
    public void prodStatus(List<Long> product_nos) {

        List<ProductDto> list = productDao.ProdFindProdNo(product_nos);
        // 현재 상태가 0 이면 1 , 1 이면 0 으로 모든 리스트 변환
        list.forEach(productDto ->
                productDto.setStatus(productDto.getStatus() == 0 ? 1 : 0)
        );
        productDao.ProdStatus(list);
    }

    //프로덕트 총 갯수 페이징용
    public int prodTotal(){
        return productDao.ProdTotal();
    }

    //검색 총갯수 페이징용
    public int prodSearchTotal(ProductDto productDto) {
        return productDao.ProdSearchTotal(productDto);
    }

    public List<ProductDto> getProdNoName(){
        return productDao.getProdNoName();
    }

    // 중복 검사
    public String validProdName(String prodName) {
        int result = productDao.validProdName(prodName);

        if (result == 1) {
            return "1"; // 중복
        } else {
            return "0"; // 미중복
        }
    }
}
