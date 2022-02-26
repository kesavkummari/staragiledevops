package com.example.devops;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.ErrorMvcAutoConfiguration;

@SpringBootApplication
@EnableAutoConfiguration(exclude = { ErrorMvcAutoConfiguration.class })
public class DevopsApplication {

	public static void main(String[] args) {
		SpringApplication.run(DevopsApplication.class, args);
	}
}
