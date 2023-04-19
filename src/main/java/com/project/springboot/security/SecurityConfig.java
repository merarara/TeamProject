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
			.antMatchers("/css/**","/js/**","/productimgs/**").permitAll()
			.antMatchers("/guest/**").permitAll()
			.antMatchers("/user/**").permitAll()
			.antMatchers("/member/**").hasAnyRole("USESR", "ADMIN")
            .antMatchers("/admin/**").hasRole("ADMIN")
            .antMatchers("/faq/**").permitAll()
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
	
	// ROLE_ADMIN 에서 ROLE_는 자동으로 붙는다.
//	@Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//		String passEncode = passwordEncoder().encode("1234");
//        auth.inMemoryAuthentication()
//        	.withUser("user").password(passEncode).roles("USER")
//        	.and()
//        	.withUser("admin").password(passEncode).roles("ADMIN");
//        System.out.println("비밀번호:"+ passEncode);
//    }
	
	/*
	application.properties에 설정된 오라클 접속 정보를 통해 즉시 연결하고
	자동으로 빈을 주입받는다. 
	 */
    @Autowired
    private DataSource dataSource;
    
    /*
    usersByUsernameQuery()
    	: 사용자의 아이디, 패스워드, 활성화여부를 판단하기 위한 쿼리를
    	실행한다. 즉 인증을 진행한다. 
    authoritiesByUsernameQuery()
    	: 사용자의 권한을 확인하기 위한 쿼리를 실행한다. 
    	즉 인가를 진행한다. 
     */
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
    
    // 회원가입 기능
    
    
}
