package org.oracle.s202501a.controller.jh_controller;


import lombok.RequiredArgsConstructor;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
public class HeaderController {

    private final UserService userService;

    @ResponseBody
    @GetMapping("/headerData")
    public String headerData() {
        return userService.getSe().getEmpName() == null ? "" : userService.getSe().getEmpName();
    }
}
