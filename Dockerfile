# 1단계: Gradle로 빌드
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# 의존성 캐싱을 위해 gradle 파일 먼저 복사
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew ./
RUN gradle dependencies --no-daemon || true

# 소스 전체 복사 후 빌드
COPY src ./src
RUN gradle bootJar -x test --no-daemon

# 2단계: 실행 이미지
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
