# 1. 빌드 단계
FROM gradle:9.4.1-jdk21 AS build
WORKDIR /app
COPY . .
RUN chmod +x gradlew
# build 과정에서 bootJar가 실행되도록 합니다.
RUN ./gradlew bootJar -x test

# 2. 실행 단계
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
# 빌드된 jar 파일 복사
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
# JSP 리소스 인식을 돕기 위한 옵션 추가
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]