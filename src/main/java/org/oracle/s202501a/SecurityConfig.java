package org.oracle.s202501a;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
	
	@Bean
	public BCryptPasswordEncoder encodPwd() {
		return new BCryptPasswordEncoder(); // 패스워드를 암호화 시키는 모듈
	}

	// 밑에껀 다 허용을 해주고 암호화를 하기 위해 걸어준 것
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http 
		    .cors(cors-> cors.disable())// cors : 외부에서 들어올 때 해결하기 위한. (근데 disable로 걸어주지 않음)
			.csrf(csrf->csrf.disable()) // csrf : 본인의 의사와 무관하게 공격자가 의도한 행위를 특정 웹사이트에 요청
		    ;
		
		return http.build();
	} // 원래 패스워드를 입력해야 했었는데 이제 로그인 창이 뜨지 않음
}
