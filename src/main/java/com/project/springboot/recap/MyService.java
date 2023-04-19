package com.project.springboot.recap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class MyService {
    @Value("${google.recaptcha.site-key}")
    private String siteKey;

    @Value("${google.recaptcha.secret-key}")
    private String secretKey;

   
}
