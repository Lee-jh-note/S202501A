package org.oracle.s202501a;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class S202501AApplication {

	public static void main(String[] args) {
		SpringApplication.run(S202501AApplication.class, args);
	}

}
