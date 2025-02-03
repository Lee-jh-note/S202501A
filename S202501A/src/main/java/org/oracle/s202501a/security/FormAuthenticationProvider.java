package org.oracle.s202501a.security;

import org.oracle.s202501a.dto.sh_dto.EmpContext;	
import org.springframework.security.authentication.AuthenticationProvider;	
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;



import lombok.RequiredArgsConstructor;

@Component("authenticationProvider")
@RequiredArgsConstructor
// DB에서 가져온 정보와 input 된 정보가 비교되서 체크되는 로직이 포함되어있는 인터페이스
public class FormAuthenticationProvider implements AuthenticationProvider {

	private final UserDetailsService userDetailsService;
	private final PasswordEncoder passwordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
	        String loginId = authentication.getName();
	        String password = (String) authentication.getCredentials();

	        EmpContext empContext =	(EmpContext) userDetailsService.loadUserByUsername(loginId);

	        System.out.println("FormAuthenticationProvider empContext->"+empContext);
	        System.out.println("FormAuthenticationProvider password1->"+password);
	        
	        
	        if (!passwordEncoder.matches(password, empContext.getPassword())) {
	            throw new BadCredentialsException("Invalid password");
	        }
	        System.out.println("FormAuthenticationProvider password2->"+password);

	        String secretKey = ((FormWebAuthenticationDetails) authentication.getDetails()).getSecretKey();
	        if (secretKey == null || !secretKey.equals("secret")) {
	            throw new SecretException("Invalid Secret");
	        }

	        return new UsernamePasswordAuthenticationToken(empContext.getEmpDTO(), null, 
	        		                                       empContext.getAuthorities());

	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return authentication.isAssignableFrom(UsernamePasswordAuthenticationToken.class);
	}

}
