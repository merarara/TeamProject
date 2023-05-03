package com.project.springboot.oauth2;

import java.io.Serializable;

import lombok.Getter;

@Getter
public class SessionUser implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String email;

	public SessionUser(String name, String email) {
		this.name = name;
		this.email = email;
	}
}