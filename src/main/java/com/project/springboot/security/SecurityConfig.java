package com.project.springboot.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	public AuthenticationFailureHandler authenticationFailureHandler;

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration
			authConfiguration) throws Exception {
		return authConfiguration.getAuthenticationManager();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity httpSecurity) 
			throws Exception {
		httpSecurity.authorizeRequests()
			.antMatchers("/").permitAll()
			.antMatchers("/css/**","/js/**","/productimgs/**","/userimages/**").permitAll()
			.antMatchers("/guest/**").permitAll()
			.antMatchers("/user/**").permitAll()
			.antMatchers("/member/**").hasAnyRole("USER", "ADMIN")
            .antMatchers("/admin/**").hasRole("ADMIN")
            .antMatchers("/faq/**").permitAll()
            .antMatchers("/aboard/**").permitAll()
            // 게시판
            .antMatchers("/cboard/**").permitAll()
            // 상품
            .antMatchers("/product/**").permitAll()
            .antMatchers("/static/**").permitAll()
			.anyRequest().authenticated();
		
		httpSecurity.formLogin()
	    .loginPage("/myLogin.do") // default: /login
	    // .loginPage("/main.jsp")
	    .loginProcessingUrl("/myLoginAction.do")
	    .defaultSuccessUrl("/myLogin.do")
	    // .failureUrl("/myError.do") // default: /login?error
	    .failureHandler(authenticationFailureHandler)
	    .usernameParameter("my_id") // default: username
	    .passwordParameter("my_pass") // default: password
	    .permitAll();

		
		httpSecurity.logout()
			.logoutUrl("/myLogout.do") 			// default : /logout
	        .logoutSuccessUrl("/")
			.permitAll();
	
		httpSecurity.exceptionHandling().accessDeniedPage("/denied.do");
		
		// ssl을 사용하지 않으면 true로 사용
		httpSecurity.csrf().disable();
		
		return httpSecurity.build();
	}
	
    @Autowired
    private DataSource dataSource;
    
    @Autowired
    protected void configure(AuthenticationManagerBuilder auth) 
    		throws Exception {
    	auth.jdbcAuthentication()
    		.dataSource(dataSource)
    		.usersByUsernameQuery("select U_Id, U_Pw, U_Enabled"
    					+ " from USER_INFO where U_Id = ?")
    		.authoritiesByUsernameQuery("select U_Id, U_authority "
    					+ " from USER_INFO where U_Id = ?")
    		.passwordEncoder(passwordEncoder());
    }
    
    // passwordEncoder() 추가
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
       
    
}
