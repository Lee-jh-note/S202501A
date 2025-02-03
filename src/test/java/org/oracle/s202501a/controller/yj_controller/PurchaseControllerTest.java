package org.oracle.s202501a.controller.yj_controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.hamcrest.Matchers.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.service.yj_service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT) // ✅ 실제 서비스 연동
@AutoConfigureMockMvc // ✅ MockMvc 사용 가능하게 설정
@Transactional // ✅ 테스트 후 롤백 (데이터 정리)
public class PurchaseControllerTest {

    @Autowired
    private MockMvc mockMvc; // ✅ MockMvc 주입

    @Autowired
    private PurchaseService purchaseService; // ✅ 실제 서비스 사용

    private Purchase01 testPurchase01;

    @BeforeEach
    void setUp() {
        // ✅ `Purchase01` 객체 초기화
        testPurchase01 = new Purchase01();
        testPurchase01.setPurchase_date("2024-01-31");
        testPurchase01.setClient_no(1);
        testPurchase01.setStatus("0");

        // ✅ 실제 DB에 데이터 삽입
        purchaseService.insertPurchase(testPurchase01);
    }

    // 📌 1. listPurchase() 테스트 (GET 요청)
    @Test
    void testListPurchase() throws Exception {
        mockMvc.perform(get("/purchase/listPurchase"))
                .andExpect(status().isOk())
                .andExpect(view().name("yj_views/listPurchase"))
                .andExpect(model().attributeExists("listPurchase", "total"))
                .andExpect(model().attribute("listPurchase", hasSize(greaterThan(0)))); // ✅ 데이터가 있는지 확인
    }

    // 📌 2. searchPurchase() 테스트 (검색)
    @Test
    void testSearchPurchase() throws Exception {
        mockMvc.perform(get("/purchase/searchPurchase"))
                .andExpect(status().isOk())
                .andExpect(view().name("yj_views/listSearchPurchase"))
                .andExpect(model().attributeExists("searchListPurchase", "totalPurchase"))
                .andExpect(model().attribute("searchListPurchase", hasSize(greaterThanOrEqualTo(0)))); // ✅ 검색 결과 검증
    }

    // 📌 3. insertPurchaseAll() 테스트 (POST 요청)
    @Test
    void testInsertPurchaseAll() throws Exception {
        String requestBody = String.format(
                "{\"purchase\":{\"purchase_date\":\"%s\",\"client_no\":%d},\"purchaseDetails\":[]}",
                testPurchase01.getPurchase_date(), testPurchase01.getClient_no()
        );

        mockMvc.perform(post("/purchase/insertPurchaseAll")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true)); // ✅ JSON 응답값 검증
    }

    // 📌 4. getPrice() 테스트 (AJAX 요청)
    @Test
    void testGetPrice() throws Exception {
        int productNo = 1; // ✅ 동적으로 설정 가능

        mockMvc.perform(get("/purchase/getPrice").param("product_no", String.valueOf(productNo)))
                .andExpect(status().isOk())
                .andExpect(content().string("9500")); // ✅ 가격 응답 검증
    }
}
