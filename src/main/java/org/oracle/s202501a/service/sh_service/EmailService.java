package org.oracle.s202501a.service.sh_service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;

    @Async  // 비동기 처리
    public void sendTempPasswordEmail(String toEmail, String tempPassword) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("your-email@gmail.com"); // 변경 필요
            helper.setTo(toEmail);
            helper.setSubject("HOTTHINK 임시 비밀번호 안내");
            helper.setText("안녕하세요.\n\n[" + toEmail + "]님의 임시 비밀번호는 [" + tempPassword + "]입니다.\n" +
                    "로그인 후 비밀번호를 변경해 주세요.");

            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
