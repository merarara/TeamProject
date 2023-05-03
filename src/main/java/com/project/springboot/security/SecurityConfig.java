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

import com.project.springboot.oauth2.CustomOAuth2UserService;
@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	public AuthenticationFailureHandler authenticationFailureHandler;
	@Autowired
	public MyAuthenticationFailureHandler myAuthenticationFailureHandler; 
	@Autowired
	private CustomOAuth2UserService customOAuth2UserService;
	@Autowired
	private MyAuthenticationSuccessHandler myAuthenticationSuccessHandler;
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
			.antMatchers("/css/**","/js/**","/productimgs/**","/userimages/**","/revuploads/**","/favicon.ico",
							"/uploads/**", "/aUpload/**").permitAll()

			.antMatchers("/guest/**").permitAll()
			.antMatchers("/user/**").permitAll()
			.antMatchers("/views/**").permitAll()
			.antMatchers("/member/**").hasAnyRole("USER", "ADMIN")
           .antMatchers("/admin/**").hasRole("ADMIN")
           // 게시판
           .antMatchers("/cboard/**").hasAnyRole("USER", "ADMIN")
           .antMatchers("/fboard/**").permitAll()
           .antMatchers("/aboard/**").permitAll()
           // 상품
           .antMatchers("/product/**").permitAll()
           .antMatchers("/static/**").permitAll()
		   .anyRequest().authenticated();
		
		httpSecurity.formLogin()
	    .loginPage("/myLogin.do") // default: /login
	    // .loginPage("/main.jsp")
	    .loginProcessingUrl("/myLoginAction.do")
//	    .defaultSuccessUrl("/myLogin.do")
	    .failureUrl("/myError.do") // default: /login?error
	    .successHandler(myAuthenticationSuccessHandler)
	    .failureHandler(authenticationFailureHandler)
	    .usernameParameter("my_id") // default: username
	    .passwordParameter("my_pass") // default: password
	    
	    .permitAll();
		
		httpSecurity.logout()
			.logoutUrl("/myLogout.do") 			// default : /logout
	        .logoutSuccessUrl("/")
	        .deleteCookies("JSESSIONID")
	        .invalidateHttpSession(true)
			.permitAll();
	
		// 예외처리
		httpSecurity.exceptionHandling().accessDeniedPage("/denied.do");
		
		// ssl을 사용하지 않으면 true로 사용
		httpSecurity.csrf().disable()
			.headers().frameOptions().disable() // header 가 충돌 방지
	        .and()
	        .oauth2Login()
	            .userInfoEndpoint()
	            .userService(customOAuth2UserService)
				.and()
				.defaultSuccessUrl("/snsjoin", true);
				

		
		return httpSecurity.build();
			
	}

   @Autowired
   private DataSource dataSource;
  
   @Autowired
   protected void configure(AuthenticationManagerBuilder auth)
   		throws Exception {
   	auth.jdbcAuthentication()
   		.dataSource(dataSource)
   		.usersByUsernameQuery("select u_id, u_pw, u_enabled"
   					+ " from USER_INFO where u_id = ?")
   		.authoritiesByUsernameQuery("select u_id, u_authority "
   					+ " from USER_INFO where u_id = ?")
   		.passwordEncoder(passwordEncoder());
   }
  
   // passwordEncoder() 추가
   public PasswordEncoder passwordEncoder() {
       return PasswordEncoderFactories.createDelegatingPasswordEncoder();
   } 
   
   
}

