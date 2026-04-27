# 1. 빌드 단계 (Gradle 9 버전대가 포함된 이미지를 사용하거나 프로젝트 래퍼 사용)
FROM gradle:9.4.1-jdk17 AS build
WORKDIR /app

# 전체 프로젝트 복사
COPY . .

# 권한 부여 및 빌드 (./gradlew를 사용하면 설정된 9.4.1 버전을 정확히 사용합니다)
RUN chmod +x gradlew
RUN ./gradlew build -x test

# 2. 실행 단계
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# 빌드된 jar 파일 복사 (build/libs 폴더 안에 생성된 jar 파일을 가져옵니다)
COPY --from=build /app/build/libs/*.jar app.jar

# Render에서 포트 감지를 위해 EXPOSE 추가 (보통 8080)
EXPOSE 8080

# 서버 실행
ENTRYPOINT ["java", "-jar", "app.jar"]