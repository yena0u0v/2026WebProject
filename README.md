# 🚀 Nuclear Policy Analysis System

**Version**: `NUCLEAR.April.ver`  
**Type**: Web-based Data Analysis Platform

---

## 📌 Overview

본 시스템은 뉴스 데이터를 기반으로 정책 이벤트(Event)와 담론 변화를 분석하는 웹 기반 데이터 분석 플랫폼이다.

> **Summary**: 정책 데이터와 뉴스 데이터를 결합한 **Policy–Discourse Integrated Analysis System**

---

## 💡 핵심 기능

* 뉴스 데이터 기반 담론 분석
  * 정책 이벤트 중심 시계열 분석
  * 키워드 기반 담론 구조 분석

---

## 🎯 Objectives

1. 정책 이벤트(Event) 중심 데이터 분석
   2. 뉴스 데이터 기반 담론 구조 정량화
   3. 시계열 기반 정책 변화 패턴 분석

---

## 🛠 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Backend** | Spring Boot 4.0.5 |
| **Language** | Java 21 |
| **Build Tool** | Gradle |
| **Database** | MySQL 5.x |
| **ORM** | MyBatis 4.0.1 |
| **View** | JSP (Jakarta Standard Tag Library) |
| **UI** | Bootstrap 5 (Custom Pastel Theme) |

---

## 🏗 Architecture

**Spring MVC 기반 계층형 구조**

```mermaid
graph TD
A[Client (Browser)] --> B[Controller Layer]
B --> C[Service Layer]
C --> D[Mapper (MyBatis)]
D --> E[(MySQL Database)]
```

---

## 📂 Project Structure

```text
src/main/java/com/project/nuclear/
├── common/          # Security 및 공통 환경 설정
├── controller/      # 웹 요청 처리 (NewsController 등)
├── mapper/          # MyBatis 매퍼 인터페이스
├── model/           # 데이터 객체 (DTO)
└── service/         # 비즈니스 로직

src/main/resources/
├── mappers/         # MyBatis SQL XML 파일
├── static/          # CSS, JS 정적 자원 (Pastel 스타일 적용)
└── application.yaml # DB 연결 및 시스템 설정

src/main/webapp/WEB-INF/views/
├── index.jsp        # 메인 분석 대시보드
└── error.jsp        # 파스텔톤 에러 알림 페이지
```

---

## 🗄 Database Structure

### Core Tables

- `news_article`
  - `keyword_dictionary`
  - `article_keyword_map`
  - `nuclear_event`

### Relationships

- Article ↔ Keyword : N:M 관계
  - Article ↔ Event : N:M 관계

👉 이벤트 기반 담론 분석 구조

---

## 🚀 Key Features

### News Article Management (뉴스 관리)
- 특정 원전과 관련된 뉴스 기사를 수집하고 감성 점수(Sentiment Score)를 분석합니다.

### Keyword Analysis
- 뉴스 키워드 추출
  - 빈도 기반 분석
  - TF-IDF 기반 중요도 분석

### Time Series Analysis (시계열 분석)
- 연도별 주요 키워드 빈도수와 이벤트 단계(Period Stage)를 시각화하여 트렌드를 분석합니다.

### Event-based Analysis
- 정책 이벤트 중심 데이터 분석
  - 담론 구조 변화 패턴 분석

---

## 🔧 Supporting Features (Optional)

※ 분석 핵심이 아닌 보조 데이터 기능

### Plant Management (원전 관리)
- 원전의 가동 상태(Active, Construction, Decommissioned) 및 상세 정보(위치, 준공연도)를 관리합니다.

### Radiation Data Visualization
- 시간대별 방사능 수치 변화를 차트로 시각화하여 모니터링합니다.

### International Framework Mapping
- 국제 규범 및 정책 프레임워크 관리

---

## 📊 Analysis System

### Visualization (Chart.js)

```javascript
new Chart(ctx, {
  type: 'line',
  data: {
    labels: years,
    datasets: [{ data: values }]
  }
});
```

### Text Mining

- Keyword Frequency Analysis
  - TF-IDF 기반 단어 중요도 분석

---

## ⚙️ Installation & Setup

### 1. Database Setup

sql12823259 데이터베이스를 생성하고 제공된 SQL 스크립트를 실행하여 테이블을 구성합니다.

### 2. Configuration

src/main/resources/application.yaml 파일에서 DB 계정(username, password) 정보를 본인의 환경에 맞게 수정합니다.

### 3. Run

./gradlew bootRun

### 4. Access

http://localhost:8080

---

## ⚠️ Error Handling

시스템 전반의 오류는 파스텔톤의 사용자 친화적인 error.jsp를 통해 안내됩니다.  
모든 오류 페이지에는 메인 대시보드로 즉시 돌아갈 수 있는 버튼이 포함되어 있습니다.

---

## 📌 Conclusion

데이터 기반 정책 분석 가능  
뉴스 담론 구조 시각화 구현  
정책–담론 통합 분석 시스템 구축 완료

---

Created by User - April 2026