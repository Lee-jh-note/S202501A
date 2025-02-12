package org.oracle.s202501a.configuration;

import org.oracle.s202501a.security.FormAccessDeniedHandler;
//import org.oracle.s202501a.security.FormAccessDeniedHandler;	
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.expression.WebExpressionAuthorizationManager;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {
    private final AuthenticationProvider authenticationProvider;
    private final AuthenticationDetailsSource<HttpServletRequest, WebAuthenticationDetails> authenticationDetailsSource;
    private final AuthenticationSuccessHandler successHandler;
    private final AuthenticationFailureHandler failureHandler;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        //  :: -> 메소드 참조라고 하며 람다식에서 불필요한 매개변수를 제거하는 것이 목적

        http
                .csrf(AbstractHttpConfigurer::disable)
                // 인가
                .authorizeHttpRequests(auth -> auth
                                .requestMatchers("/css/**", "/images/**", "/js/**", "/favicon.*", "/*/icon-*"
                                        , "/WEB-INF/views/**", "/vendor/**", "/css1/**").permitAll()
                                .requestMatchers("/", "/writeFormEmp3", "/login", "/error").permitAll()
                                .requestMatchers("/Sales").hasAuthority("ROLE_SALES")
                                .requestMatchers("/Logistics").hasAuthority("ROLE_LOGISTICS")
                                .requestMatchers("/HR").hasAuthority("ROLE_HR")
//                                .requestMatchers("/all/**").authenticated()// /all/~ url 은 로그인된 모든 사용자 접근 허용
                                .requestMatchers("/Prod/**").hasAnyAuthority("ROLE_LOGISTICS")
//							.requestMatchers("/**").permitAll()
//                            .requestMatchers("/admanager").access(new WebExpressionAuthorizationManager("hasRole('ADMIN') or hasRole('MANAGER')"))
                                .anyRequest().authenticated()
                )
                // 인증
                .formLogin(form -> form
                        .loginPage("/login")  // UsernamePasswordAuthenticationFilter 생성 폼방식의 인증처리
                        .authenticationDetailsSource(authenticationDetailsSource)
                        .successHandler(successHandler)
                        .failureHandler(failureHandler)
                        .permitAll()
                )
//                .authenticationProvider(authenticationProvider)
//                .exceptionHandling(
//                        exception -> exception
//                                .accessDeniedHandler(new FormAccessDeniedHandler("/denied"))
//                )
                .authenticationProvider(authenticationProvider)
                .exceptionHandling(
                        exception -> exception
                                .accessDeniedHandler(new FormAccessDeniedHandler())
                )
        ;

        return http.build();

    }
}