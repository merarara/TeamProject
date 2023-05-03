package com.project.springboot.mail;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmailService {
    String sendSimpleMessage(String to)throws Exception;
}