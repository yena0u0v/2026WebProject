# 1. 빌드 단계
FROM gradle:9.4.1-jdk21 AS build
WORKDIR /app
COPY . .

RUN chmod +x gradlew && ./gradlew bootJar -x test

# 2. 실행 단계
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

# Render 표준 포트
EXPOSE 8080

# Render가 주는 PORT 환경변수 사용 (핵심)
ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=$PORT"]