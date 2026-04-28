# 1. 빌드 단계
FROM gradle:9.4.1-jdk21 AS build
WORKDIR /app
COPY . .

# bootJar 명령을 통해 위에서 설정한 JSP 포함 JAR 생성
RUN chmod +x gradlew && ./gradlew bootJar -x test

# 2. 실행 단계
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# 빌드된 JAR 파일만 실행 서버로 복사
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 10000

# JSP 인식을 위한 엔트로피 옵션 추가
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]