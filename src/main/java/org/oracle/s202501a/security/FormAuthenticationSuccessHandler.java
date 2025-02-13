package org.oracle.s202501a.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class FormAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
    private final RequestCache requestCache = new HttpSessionRequestCache();
    //  Spring Security가 화면 이동에 대한 규칙을 정의하는 부분을 만든 인터페이스
    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
    		Authentication authentication) throws IOException, ServletException {
    	// TODO Auto-generated method stub
        setDefaultTargetUrl("/All/mainPage");

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if(savedRequest!=null) {
            String targetUrl = savedRequest.getRedirectUrl();
            System.out.println("FormAuthenticationSuccessHandler targetUrl->"+targetUrl);
            redirectStrategy.sendRedirect(request, response, targetUrl);
        }
        else {
            System.out.println("FormAuthenticationSuccessHandler savedRequest null getDefaultTargetUrl()->"
                                                                                +getDefaultTargetUrl());
            redirectStrategy.sendRedirect(request, response, getDefaultTargetUrl());
        }    
        
    }

}
