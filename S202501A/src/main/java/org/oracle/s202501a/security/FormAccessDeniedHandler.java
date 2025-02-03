package org.oracle.s202501a.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.access.AccessDeniedHandler;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FormAccessDeniedHandler implements AccessDeniedHandler {
	private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	private final String errorPage;
	
	public FormAccessDeniedHandler(String errorPage) {
		this.errorPage = errorPage;
	}
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String deniedUrl = errorPage + "?exception=" + accessDeniedException.getMessage();
		System.out.println("FormAccessDeniedHandler deniedUrl->"+deniedUrl);
		redirectStrategy.sendRedirect(request, response, deniedUrl);

	}

}
