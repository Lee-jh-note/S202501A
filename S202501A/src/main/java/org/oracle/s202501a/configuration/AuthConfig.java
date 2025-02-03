package org.oracle.s202501a.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class AuthConfig {
	@Bean
	PasswordEncoder passwordEncoder() {
		// 서비스에 저장된 비밀번호에 대한 암호화 알고리즘을 변경하는 일은 상당히 많은 노력을 요구
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

}
