package com.example.health;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@SpringBootApplication
@EnableWebSecurity   //开启security
@MapperScan("com.example.health.mapper")
public class HealthBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(HealthBootApplication.class, args);
	}

}
