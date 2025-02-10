package org.oracle.s202501a.controller.sh_controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.service.sh_service.MyPageService;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MyPageController {

	private final UserService userservice;
	private final MyPageService myPageService;
	private final JavaMailSender mailSender;
	private final PasswordEncoder passwordEncoder;
	
    @GetMapping("/mypage")
    public String sessiontest(Model model) {
        EmpDTO dto = userservice.getSe();
        model.addAttribute("emp", dto);
        return "sh_views/mypage";
    }
   
    @PostMapping("/changePassword")
    public RedirectView changePassword(
            @RequestParam("username") String username,
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return new RedirectView("/login?error=unauthorized");
        }

        boolean isChanged = myPageService.changePassword(username, oldPassword, newPassword);

        if (!isChanged) {
            return new RedirectView("/mypage?error=wrongPassword"); // 마이페이지에서 경고창 띄우기
        }

        SecurityContextHolder.clearContext(); // 현재 로그인된 사용자 정보 제거
        return new RedirectView("/login?message=passwordChanged");
    }



   
    
    @GetMapping("/find_password")
    public String showFindPasswordPage() {
        return "sh_views/find_password";  
    }
    
    
    @PostMapping("/sendTemporaryPassword")
    public ResponseEntity<Map<String, String>> sendTemporaryPassword(
            @RequestParam(name = "empName") String empName, 
            @RequestParam(name = "empEmail") String empEmail) {

        Map<String, String> response = new HashMap<>();

        // 사원 이름과 이메일로 직원 조회
        Optional<Emp> empOpt = myPageService.findByEmpNameAndEmpEmail(empName, empEmail);

        if (empOpt.isPresent()) {
            Emp emp = empOpt.get();

            // 임시 비밀번호 생성 (영문 + 숫자 조합)
            String tempPassword = generateTemporaryPassword();

            // 이메일 전송
            boolean emailSent = sendTempPasswordEmail(empEmail, tempPassword);

            if (emailSent) {
                // **임시 비밀번호를 암호화해서 저장**
                emp.setPassword(passwordEncoder.encode(tempPassword));
                myPageService.updatePassword(emp);

                response.put("status", "success");
                response.put("message", "임시 비밀번호가 이메일로 전송되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("status", "error");
                response.put("message", "이메일 전송에 실패했습니다.");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
            }
        } else {
            response.put("status", "error");
            response.put("message", "입력한 정보와 일치하는 계정이 없습니다.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    // 임시 비밀번호 생성 메서드
    private String generateTemporaryPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    // 이메일 전송 메서드
    private boolean sendTempPasswordEmail(String toEmail, String tempPassword) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("your-email@gmail.com"); // 변경 필요
            helper.setTo(toEmail);
            helper.setSubject("HOTTHINK 임시 비밀번호 안내");
            helper.setText("안녕하세요.\n\n[" + toEmail + "]님의 임시 비밀번호는 [" + tempPassword + "]입니다.\n" +
                           "로그인 후 비밀번호를 변경해 주세요.");

            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
