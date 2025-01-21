package org.oracle.s202501a.service.jh_service;


import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dto.jh_dto.PagingJH;
import org.oracle.s202501a.dto.jh_dto.PricePagingDto;
import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
import org.oracle.s202501a.repository.jh_repository.PriceHistoryRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class PriceHistoryService {

    private final PriceHistoryRepository priceHistoryRepository;
    private final PagingService pagingService;


    // 처음에 등록 제품 등록에서 넘어올거임
    public void priceCreateAct(PriceHistoryModel model) {
            model.setSale_or_purchase(0);
            model.setPrice(model.getSale_price());
            PriceHistory priceHistory = PriceHistoryMapper.toEntity(model);
            priceHistory.prePersist();
            priceHistoryRepository.save(priceHistory);
            model.setSale_or_purchase(1);
            model.setPrice(model.getPur_price());
            priceHistory = PriceHistoryMapper.toEntity(model);
            priceHistory.prePersist();
            priceHistoryRepository.save(priceHistory);
    }

    // 지난 날짜의 판매가 구매가 변경
    public PriceHistoryModel oldPriceModify(PriceHistoryModel model) {

        System.out.println("지난 날짜 가격 변경 객체 : " + model);
            model.setReg_date(new Date());
            PriceHistory oldHistory = PriceHistoryMapper.toEntity(model);
            priceHistoryRepository.save(oldHistory);
            return null;
    }

    // 제품 수정에서의 변경 앞으로의 판매가 구매가 변경
    public PriceHistoryModel priceModifyAct(PriceHistoryModel model) {
            priceHistoryRepository.price_prc(model.getProduct_no(),model.getPrice(),model.getSale_or_purchase());
        return null;
    }


    public List<PriceHistoryProductModel> listAll(int start, int end) {

        List<Object[]> list = priceHistoryRepository.findAll(start,end);
        return list.stream().
                map(PriceHistoryMapper::toPriceProductFormObj).
                toList();
    }

    public PriceHistoryModel findById(Long id) {
        PriceHistory priceHistory = priceHistoryRepository.findById(id).orElse(null);
        System.out.println(priceHistory);
        return PriceHistoryMapper.toModel(priceHistory);
    }

    public List<PriceHistoryProductModel> findByProductName(String name, int start, int end) {

        List<Object[]> list = priceHistoryRepository.findByProductName(name, start, end);
        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
//                .peek(rr-> System.out.println("왜 아 무 것 도 없 나 요 ? " + rr))
                .toList();
    }
    public int countByProductName(String productName) {
        return priceHistoryRepository.countByProductName(productName);
    }

    public List<PriceHistoryProductModel> findNyProdNamePur(String name, int type, int start, int end){
        List<Object[]> list = priceHistoryRepository.findByProdNameType(name, type, start, end);
        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
                .toList();
    }
    public int countByProdNameType(String name, int type){
        return priceHistoryRepository.countByProdNameType(name, type);
    }


        public List<PriceHistoryProductModel> findByProdType(int type, int start, int end){
        List<Object[]> list = priceHistoryRepository.findByProdType(type, start, end);
        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
                .toList();
    }
    public int countByProdType(int type) {
        return priceHistoryRepository.countByProdType(type);
    }

        public int PriceTotal() {
        return priceHistoryRepository.PriceTotal();
    }

    public PricePagingDto getPriceHistoryList(PriceHistoryModel priceHistoryModel, String name, Integer type) {
        PagingJH page;
        if (priceHistoryModel.getCurrentPage() == null) {
            priceHistoryModel.setCurrentPage("1");
        }

        int total = 0;
        List<PriceHistoryProductModel> list = null;

        if (name != null && type != null) {
            total = countByProdNameType(name, type);
           page = pagingService.getPagingInfo(total, priceHistoryModel.getCurrentPage());
            priceHistoryModel.setStart(page.getStart());
            priceHistoryModel.setEnd(page.getEnd());
            list = findNyProdNamePur(name, type, page.getStart(), page.getEnd());
        } else if (name != null && type == null) {
            total = countByProductName(name);
            page = pagingService.getPagingInfo(total, priceHistoryModel.getCurrentPage());
            priceHistoryModel.setStart(page.getStart());
            priceHistoryModel.setEnd(page.getEnd());
            list = findByProductName(name, page.getStart(), page.getEnd());
        } else if (name == null && type != null) {
            total = countByProdType(type);
            page = pagingService.getPagingInfo(total, priceHistoryModel.getCurrentPage());
            priceHistoryModel.setStart(page.getStart());
            priceHistoryModel.setEnd(page.getEnd());
            list = findByProdType(type, page.getStart(), page.getEnd());
        } else {
            total = PriceTotal();
            page = pagingService.getPagingInfo(total, priceHistoryModel.getCurrentPage());
            priceHistoryModel.setStart(page.getStart());
            priceHistoryModel.setEnd(page.getEnd());
            list = listAll(page.getStart(), page.getEnd());
        }

        return new PricePagingDto(list, page);
    }


}
