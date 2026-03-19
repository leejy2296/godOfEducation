package com.virtual.geo.config;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import jakarta.annotation.PostConstruct;

import org.springframework.context.annotation.Configuration;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void init() throws IOException {
        if (FirebaseApp.getApps().isEmpty()) {

            InputStream serviceAccount;

            String envJson = System.getenv("FIREBASE_SERVICE_ACCOUNT_JSON");

            if (envJson != null && !envJson.isBlank()) {
                // Render 환경: 환경변수에서 읽기
                serviceAccount = new ByteArrayInputStream(
                    envJson.getBytes(StandardCharsets.UTF_8)
                );
            } else {
                // 로컬 개발환경: 파일에서 읽기
                serviceAccount = getClass().getResourceAsStream("/firebase/serviceAccountKey.json");
            }

            FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .build();

            FirebaseApp.initializeApp(options);
        }
    }
}