package org.oracle.s202501a.service.sh_service;

import java.util.Optional;

import org.oracle.s202501a.entity.Emp;
import org.oracle.s202501a.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /**
     * 🔹 사용자 비밀번호 변경 (사용자가 직접 변경)
     */
    public boolean changePassword(String username, String oldPassword, String newPassword) {
        Optional<Emp> userOpt = userRepository.findByUsername(username);

        if (userOpt.isEmpty()) {
            return false; // 사용자 없음
        }

        Emp user = userOpt.get();
        
        System.out.println("user ->" + user);

        // 🔹 기존 비밀번호 검증 (암호화된 비밀번호 비교)
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            return false;
        }

        // 🔹 새로운 비밀번호 암호화 후 저장
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        return true;
    }

    /**
     * 🔹 사원 이름 & 이메일로 계정 찾기
     */
    public Optional<Emp> findByEmpNameAndEmpEmail(String empName, String empEmail) {
        return userRepository.findByEmpNameAndEmpEmail(empName, empEmail);
    }

    /**
     * 🔹 비밀번호 업데이트 (임시 비밀번호 적용 시 사용)
     */
    public void updatePasswordWithEncryption(Emp emp, String newPassword) {
        emp.setPassword(passwordEncoder.encode(newPassword)); // 🔹 비밀번호 암호화 적용
        userRepository.save(emp);
    }

    /**
     * 🔹 기존 비밀번호 업데이트 로직 (보존)
     */
    public void updatePassword(Emp emp) {
        userRepository.save(emp);
    }
}
