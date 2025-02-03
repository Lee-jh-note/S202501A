package org.oracle.s202501a;

import lombok.RequiredArgsConstructor;	
import org.oracle.s202501a.dto.TestEmpDto;
import org.oracle.s202501a.service.TestEmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class TestController {

    private final TestEmpService testEmpService;

    @GetMapping("test")
    public String test() {
        return "test";
    }

        @GetMapping("/empTest")
        public String boardTest(Model model) {
        List<TestEmpDto> emplist = testEmpService.findAll();

        model.addAttribute("emplist", emplist);
        return "empTest";
    }
}
