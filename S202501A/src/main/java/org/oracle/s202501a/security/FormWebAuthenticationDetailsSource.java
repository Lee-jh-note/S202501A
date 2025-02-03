package org.oracle.s202501a.security;

import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class FormWebAuthenticationDetailsSource implements 
                     AuthenticationDetailsSource<HttpServletRequest, WebAuthenticationDetails> {

	@Override
	public WebAuthenticationDetails buildDetails(HttpServletRequest request) {
		System.out.println("FormWebAuthenticationDetailsSource buildDetails request->"+request);
		return new FormWebAuthenticationDetails(request);
	}
	
}
