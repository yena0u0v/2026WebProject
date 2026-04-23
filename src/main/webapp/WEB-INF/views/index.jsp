<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuclear Policy Analysis System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body class="bg-light">

<!-- ── 헤더 ──────────────────────────────────── -->
<nav class="navbar navbar-dark bg-dark px-4 py-3 mb-4">
    <span class="navbar-brand fw-bold fs-5">Nuclear Policy Analysis System</span>
    <div class="d-flex gap-3">
        <a href="/" class="text-white text-decoration-none small">Dashboard</a>
        <a href="/analysis/timeseries" class="text-white text-decoration-none small">Time Series</a>
        <a href="/analysis/keyword" class="text-white text-decoration-none small">Keyword</a>
    </div>
</nav>

<div class="container-fluid px-4">

    <!-- ── 요약 카드 ──────────────────────────── -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card card-nuclear text-white" style="background:#2563eb">
                <div class="card-body py-3">
                    <div class="small fw-bold opacity-75">Total Articles</div>
                    <div class="fs-3 fw-bold">${fn:length(articles)}</div>
                    <div class="small opacity-75">수집된 뉴스 기사</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-nuclear text-white" style="background:#16a34a">
                <div class="card-body py-3">
                    <div class="small fw-bold opacity-75">Keywords Tracked</div>
                    <div class="fs-3 fw-bold">${fn:length(keywordFreq)}</div>
                    <div class="small opacity-75">분석 키워드</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-nuclear text-white" style="background:#9333ea">
                <div class="card-body py-3">
                    <div class="small fw-bold opacity-75">Time Series Points</div>
                    <div class="fs-3 fw-bold">${fn:length(timeSeriesData)}</div>
                    <div class="small opacity-75">시계열 데이터</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-nuclear text-white" style="background:#f97316">
                <div class="card-body py-3">
                    <div class="small fw-bold opacity-75">TF-IDF Keywords</div>
                    <div class="fs-3 fw-bold">${fn:length(keywordTfidf)}</div>
                    <div class="small opacity-75">중요도 분석 키워드</div>
                </div>
            </div>
        </div>
    </div>

    <!-- ── 시계열 차트 + 키워드 차트 ─────────── -->
    <div class="row g-3 mb-4">
        <div class="col-lg-8">
            <div class="card card-nuclear">
                <div class="card-header fw-bold bg-dark text-white">
                    Time Series Analysis — 연도별 키워드 빈도 & 이벤트 단계
                </div>
                <div class="card-body">
                    <canvas id="timeSeriesChart" height="100"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card card-nuclear">
                <div class="card-header fw-bold bg-dark text-white">
                    Top Keywords — 빈도 기반
                </div>
                <div class="card-body">
                    <canvas id="keywordChart" height="200"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- ── 뉴스 기사 목록 ─────────────────────── -->
    <div class="row g-3 mb-4">
        <div class="col-12">
            <div class="card card-nuclear">
                <div class="card-header fw-bold bg-dark text-white d-flex justify-content-between align-items-center">
                    <span>News Article Management</span>
                    <input type="text" id="searchInput" class="form-control form-control-sm w-auto"
                           placeholder="Search News...">
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle" style="font-size:0.85rem">
                            <thead class="table-light">
                                <tr>
                                    <th>제목</th>
                                    <th>출처</th>
                                    <th>기간 유형</th>
                                    <th class="text-end">감성 점수</th>
                                    <th>게시일</th>
                                </tr>
                            </thead>
                            <tbody id="articleTable">
                                <c:forEach var="article" items="${articles}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty article.url}">
                                                <a href="${article.url}" target="_blank"
                                                   class="text-decoration-none text-dark fw-semibold">
                                                    ${article.title}
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fw-semibold">${article.title}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="badge bg-secondary">${article.source}</span></td>
                                    <td><span class="badge bg-info text-dark">${article.periodType}</span></td>
                                    <td class="text-end">
                                        <c:choose>
                                            <c:when test="${article.sentimentScore >= 0}">
                                                <span class="text-success fw-bold">
                                                    <fmt:formatNumber value="${article.sentimentScore}"
                                                                      maxFractionDigits="1"/>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${article.sentimentScore}"
                                                                      maxFractionDigits="1"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <%-- publishedDate는 String(YYYY-MM-DD) 형태로 직접 출력 --%>
                                    <td>${article.publishedDate}</td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ── TF-IDF 키워드 테이블 ───────────────── -->
    <div class="row g-3 mb-5">
        <div class="col-md-6">
            <div class="card card-nuclear">
                <div class="card-header fw-bold bg-dark text-white">
                    TF-IDF Keyword Importance
                </div>
                <div class="card-body p-0">
                    <table class="table table-sm table-hover mb-0" style="font-size:0.82rem">
                        <thead class="table-light">
                            <tr><th>키워드</th><th>카테고리</th><th class="text-end">TF-IDF</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="kw" items="${keywordTfidf}">
                            <tr>
                                <td>${kw.keyword}</td>
                                <td><span class="badge bg-light text-dark border">${kw.category}</span></td>
                                <td class="text-end fw-bold text-primary">
                                    <fmt:formatNumber value="${kw.tfidfScore}" maxFractionDigits="4"/>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card card-nuclear">
                <div class="card-header fw-bold bg-dark text-white">
                    Keyword Frequency Top 20
                </div>
                <div class="card-body p-0">
                    <table class="table table-sm table-hover mb-0" style="font-size:0.82rem">
                        <thead class="table-light">
                            <tr><th>키워드</th><th>카테고리</th><th class="text-end">빈도</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="kw" items="${keywordFreq}" end="19">
                            <tr>
                                <td>${kw.keyword}</td>
                                <td><span class="badge bg-light text-dark border">${kw.category}</span></td>
                                <td class="text-end fw-bold">${kw.frequency}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div><!-- /container -->

<!-- ── Chart.js 데이터 바인딩 (JSTL → JS) ─── -->
<script>
/* ---------- Time Series 데이터 ---------- */
const tsRaw = [
    <c:forEach var="ts" items="${timeSeriesData}" varStatus="s">
    { year: ${ts.year}, keyword: "${ts.keyword}", stage: "${ts.periodStage}", count: ${ts.totalCount} }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

const years = [...new Set(tsRaw.map(d => d.year))].sort();
const topKeywords = Object.entries(
    tsRaw.reduce((acc, d) => {
        acc[d.keyword] = (acc[d.keyword] || 0) + d.count;
        return acc;
    }, {})
).sort((a,b) => b[1]-a[1]).slice(0,5).map(e => e[0]);

const palette = ['#2563eb','#16a34a','#9333ea','#f97316','#e11d48'];

const tsDatasets = topKeywords.map((kw, i) => ({
    label: kw,
    data: years.map(yr => {
        const row = tsRaw.find(d => d.year === yr && d.keyword === kw);
        return row ? row.count : 0;
    }),
    borderColor: palette[i],
    backgroundColor: palette[i] + '22',
    tension: 0.3,
    fill: false
}));

new Chart(document.getElementById('timeSeriesChart'), {
    type: 'line',
    data: { labels: years, datasets: tsDatasets },
    options: {
        responsive: true,
        plugins: {
            legend: { position: 'top' },
            tooltip: { mode: 'index', intersect: false }
        },
        scales: {
            x: { title: { display: true, text: 'Year' } },
            y: { title: { display: true, text: 'Frequency' }, beginAtZero: true }
        }
    }
});

/* ---------- Keyword 빈도 차트 (Top 10) ---------- */
const kwRaw = [
    <c:forEach var="kw" items="${keywordFreq}" end="9" varStatus="s">
    { keyword: "${kw.keyword}", frequency: ${kw.frequency} }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

new Chart(document.getElementById('keywordChart'), {
    type: 'bar',
    data: {
        labels: kwRaw.map(d => d.keyword),
        datasets: [{
            label: '빈도',
            data: kwRaw.map(d => d.frequency),
            backgroundColor: palette,
            borderRadius: 6
        }]
    },
    options: {
        indexAxis: 'y',
        responsive: true,
        plugins: { legend: { display: false } },
        scales: { x: { beginAtZero: true } }
    }
});

/* ---------- 검색 필터 ---------- */
document.getElementById('searchInput').addEventListener('keyup', function() {
    const q = this.value.toLowerCase();
    document.querySelectorAll('#articleTable tr').forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/script.js"></script>
</body>
</html>
