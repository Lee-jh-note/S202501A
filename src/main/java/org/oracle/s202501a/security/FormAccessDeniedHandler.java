package org.oracle.s202501a.security;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.access.AccessDeniedHandler;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FormAccessDeniedHandler implements AccessDeniedHandler {
	private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
//	private final String errorPage;
//
//	public FormAccessDeniedHandler(String errorPage) {
//
//		this.errorPage = errorPage;
//	}
	
//	@Override
//	public void handle(HttpServletRequest request, HttpServletResponse response,
//			AccessDeniedException accessDeniedException) throws IOException, ServletException {
//		// TODO Auto-generated method stub
//		String deniedUrl = errorPage + "?exception=" + accessDeniedException.getMessage();
//		System.out.println("FormAccessDeniedHandler deniedUrl->"+deniedUrl);
//		redirectStrategy.sendRedirect(request, response, deniedUrl);
//
//	}

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println("<script src=\"https://code.jquery.com/jquery-3.6.0.min.js\"></script>");
		writer.println("<script type=\"text/javascript\">");
		writer.println("alert('권한이 없습니다.');");
		writer.println("if (window.opener) {");
		writer.println("    window.close();");
		writer.println("} else {");
		writer.println("    history.back();");
		writer.println("}");
		writer.println("</script>");
	}

}
