# 1단계: Gradle로 WAR 빌드
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew ./
COPY src ./src

RUN gradle bootWar -x test --no-daemon

# 2단계: 실행 (내장 Tomcat으로 WAR 실행)
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

COPY --from=build /app/build/libs/*.war app.war

EXPOSE 10000

ENTRYPOINT ["java", "-Dserver.port=${PORT:-10000}", "-jar", "app.war"]
