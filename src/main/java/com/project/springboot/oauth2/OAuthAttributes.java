package com.project.springboot.oauth2;

import java.util.Map;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OAuthAttributes {
	private Map<String, Object> attributes;
	private String nameAttributeKey;
	private String name;
	private String email;
	private String picture;

	@Builder
	public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey,
			               String name, String email, String picture) 
	{
		this.attributes = attributes;
		this.nameAttributeKey = nameAttributeKey;
		this.name = name;
		this.email = email;
	}

	public static OAuthAttributes of(String registrationId, String userNameAttributeName,
			                         Map<String, Object> attributes) 
	{
//		System.out.println(registrationId);
//		System.out.println(userNameAttributeName);
		if (registrationId.equals("google")) {
			return ofGoogle(userNameAttributeName, attributes);
		} else if  (registrationId.equals("facebook")) {
			return ofFacebook(userNameAttributeName, attributes);
		} else if  (registrationId.equals("kakao")) {
			return ofKakao(userNameAttributeName, attributes);
		} else if  (registrationId.equals("naver")) {
			return ofNaver(userNameAttributeName, attributes);
		}
		return ofGoogle(userNameAttributeName, attributes);
	}

	private static OAuthAttributes ofGoogle(String userNameAttributeName, Map<String, Object> attributes) 
	{
		return OAuthAttributes.builder()
				.name((String) attributes.get("name"))
				.email((String) attributes.get("email"))
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.build();
	}
	
	private static OAuthAttributes ofFacebook(String userNameAttributeName, Map<String, Object> attributes) 
	{
//		System.out.println(attributes);
		String sName = (String) attributes.get("name");
		String sEmail = (String) attributes.get("email");
		Map<String, Object> pic1 = (Map<String, Object>) attributes.get("picture");
		Map<String, Object> pic2 = (Map<String, Object>) pic1.get("data");
		String pic3 = (String) pic2.get("url");
		
		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.picture(pic3)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.build();
	}

	private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) 
	{
//		System.out.println(attributes);
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("kakao_account");
		Map<String, Object> obj2 = (Map<String, Object>) obj1.get("profile");
		String sName = (String) obj2.get("nickname");
		String sEmail = (String) obj1.get("email");
		
		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.build();
	}

	private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) 
	{
//		System.out.println(attributes);
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("response");
		String sName = (String) obj1.get("name");
		String sEmail = (String) obj1.get("email");

		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.build();
	}

}