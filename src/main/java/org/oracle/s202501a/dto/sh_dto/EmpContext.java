package org.oracle.s202501a.dto.sh_dto;

import java.util.Collection;	
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class EmpContext implements UserDetails {
	private EmpDTO empDTO;
	private final List<GrantedAuthority> roles;
	
	
	public EmpContext(EmpDTO empDTO, List<GrantedAuthority> roles) {
		this.empDTO = empDTO;
		this.roles = roles;
	}
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return roles;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return empDTO.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return empDTO.getUsername();
	}
	

	public boolean isEmpNonLocked() {
	        return true;
	    }
   @Override
	 public boolean isCredentialsNonExpired() {
	        return true;
	   }
   @Override
	 public boolean isEnabled() {
	        return true;
	    }
}
