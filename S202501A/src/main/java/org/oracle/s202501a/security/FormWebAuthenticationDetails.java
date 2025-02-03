package org.oracle.s202501a.security;

import org.springframework.security.web.authentication.WebAuthenticationDetails;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;

@Getter
public class FormWebAuthenticationDetails extends WebAuthenticationDetails {

    private final String secretKey;

    public FormWebAuthenticationDetails(HttpServletRequest request) {
        super(request);
        System.out.println("FormWebAuthenticationDetails secret_key->"+request.getParameter("secret_key"));
        secretKey = request.getParameter("secret_key");
	}
}
