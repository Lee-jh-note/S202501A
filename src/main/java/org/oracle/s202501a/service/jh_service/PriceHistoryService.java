package org.oracle.s202501a.service.jh_service;


import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
import org.oracle.s202501a.repository.jh_repository.PriceHistoryRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class PriceHistoryService {


    private final PriceHistoryRepository priceHistoryRepository;

    // 처음에 등록
    public void priceCreateAct(PriceHistoryModel model) {
        if (model.getSale_price() != 0) {
            model.setSale_or_purchase(0);
            model.setPrice(model.getSale_price());
            PriceHistory priceHistory = PriceHistoryMapper.toEntity(model);
            priceHistory.prePersist();
            priceHistoryRepository.save(priceHistory);
        }
        if (model.getPur_price() != 0) {
            model.setSale_or_purchase(1);
            model.setPrice(model.getPur_price());
            PriceHistory priceHistory = PriceHistoryMapper.toEntity(model);
            priceHistory.prePersist();
            priceHistoryRepository.save(priceHistory);
        }
    }

    // 지난 날짜의 판매가 구매가 변경
    public PriceHistoryModel oldPriceModify(PriceHistoryModel model) {

            model.setReg_date(new Date());
            PriceHistory oldHistory = PriceHistoryMapper.toEntity(model);
            System.out.println("이미 날짜 지나간거 변경 :" + oldHistory);
            priceHistoryRepository.save(oldHistory);
            return null;
    }

    // 제품 수정에서의 변경 앞으로의 판매가 구매가 변경
    public PriceHistoryModel priceModifyAct(PriceHistoryModel model) {
            priceHistoryRepository.price_prc(model.getProduct_no(),model.getPrice(),model.getSale_or_purchase());
        return null;
    }


    public List<PriceHistoryModel> listAll() {
        return priceHistoryRepository.findAll()
                .stream()
                .map(PriceHistoryMapper::toModel)
                .toList();

    }

    public PriceHistoryModel findById(Long id) {
        PriceHistory priceHistory = priceHistoryRepository.findById(id).orElse(null);
        System.out.println(priceHistory);
        return PriceHistoryMapper.toModel(priceHistory);
    }

    public List<PriceHistoryProductModel> findByProductName(String name) {

        List<Object[]> list = priceHistoryRepository.findByProductName(name);
        //
        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
                .toList();
    }

    public List<PriceHistoryProductModel> findNyProdNamePur(String name, int type){
        List<Object[]> list = priceHistoryRepository.findByProdNameType(name, type);
        //

        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
                .toList();
    }
    public List<PriceHistoryProductModel> findByProdType(int type){
        List<Object[]> list = priceHistoryRepository.findByProdType(type);
        return list.stream()
                .map(PriceHistoryMapper::toPriceProductFormObj)
                .toList();
    }

}
