package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.ProductDao;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
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

    // 그냥 처음에 전체 리스트 조회
    public List<ProductDto> findAll() {
        return productDao.ProdFindAll();
    }

    // 등록
    public void CreateProduct(ProductPriceDto productpriceDto) {
        // 제품 테이블 등록
        ProductDto dto = new ProductDto();
        dto.setProduct_name(productpriceDto.getProduct_name());
        dto.setDescription(productpriceDto.getDescription());
        dto.setCategory(productpriceDto.getCategory());
        productDao.CreateProd(dto);
//        System.out.println("savaProdNo: " + saveProdNo);

        // 매퍼에서 셀렉트 키 사용해서 인서트 후 바로 product_no 반환 해서
        // 반환된 넘버로 가격 테이블 등록

        PriceHistoryModel priceHistoryModel = new PriceHistoryModel();
        priceHistoryModel.setProduct_no(dto.getProduct_no());
        priceHistoryModel.setCategory(productpriceDto.getCategory());
        priceHistoryModel.setPur_price(productpriceDto.getPur_price());
        priceHistoryModel.setSale_price(productpriceDto.getSale_price());
        priceHistoryService.priceCreateAct(priceHistoryModel);
    }

    // 상제 페이지
    public ProductPriceDto ProdDetails(ProductPriceDto productpriceDto) {
        productDao.ProdDetails(productpriceDto.getProduct_no());
        return productpriceDto;
    }

    // 검색 조건이 추가된 리스트 조회
    public List<ProductDto> ProdSearch(ProductDto productDto) {
        return productDao.ProdSearch(productDto);
    }

    // 수정
    public void ProdModify(ProductPriceDto productPriceDto) {
        ProductDto dto = new ProductDto();
        dto.setProduct_name(productPriceDto.getProduct_name());
        dto.setDescription(productPriceDto.getDescription());
        dto.setCategory(productPriceDto.getCategory());
        dto.setProduct_no(productPriceDto.getProduct_no());
        productDao.ProdModify(dto);

        PriceHistoryModel purModel = new PriceHistoryModel();
        purModel.setProduct_no(dto.getProduct_no()); // 1
//        purModel.setCategory(productPriceDto.getCategory()); // 500
        purModel.setPrice(productPriceDto.getPur_price()); // 1500
        purModel.setSale_or_purchase(1);
        priceHistoryService.priceModifyAct(purModel);

        PriceHistoryModel saleModel = new PriceHistoryModel();
        saleModel.setProduct_no(dto.getProduct_no());
//        saleModel.setCategory(productPriceDto.getCategory());
        saleModel.setPrice(productPriceDto.getSale_price());
        saleModel.setSale_or_purchase(0);
        priceHistoryService.priceModifyAct(saleModel);

    }
}
