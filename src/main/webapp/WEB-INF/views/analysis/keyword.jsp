<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Keyword Analysis — Nuclear Policy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark px-4 py-3 mb-4">
    <a href="/" class="navbar-brand fw-bold fs-5 text-decoration-none">☢ Nuclear Policy Analysis</a>
    <div class="d-flex gap-3">
        <a href="/" class="text-white text-decoration-none small">Dashboard</a>
        <a href="/analysis/timeseries" class="text-white text-decoration-none small">Time Series</a>
        <a href="/analysis/keyword" class="text-white text-decoration-none small">Keyword</a>
    </div>
</nav>

<div class="container-fluid px-4">
    <div class="row g-3 mb-4">
        <div class="col-lg-6">
            <div class="card card-nuclear">
                <div class="card-header bg-dark text-white fw-bold">Keyword Frequency Top 20</div>
                <div class="card-body"><canvas id="freqChart" height="200"></canvas></div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card card-nuclear">
                <div class="card-header bg-dark text-white fw-bold">TF-IDF Importance Top 20</div>
                <div class="card-body"><canvas id="tfidfChart" height="200"></canvas></div>
            </div>
        </div>
    </div>

    <!-- 키워드 빈도 테이블 -->
    <div class="row g-3 mb-5">
        <div class="col-md-6">
            <div class="card card-nuclear">
                <div class="card-header bg-dark text-white fw-bold">Keyword Frequency 전체 목록</div>
                <div class="card-body p-0">
                    <table class="table table-sm table-hover mb-0" style="font-size:0.82rem">
                        <thead class="table-light">
                            <tr><th>키워드</th><th>카테고리</th><th class="text-end">빈도</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="kw" items="${keywordFreq}">
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
        <div class="col-md-6">
            <div class="card card-nuclear">
                <div class="card-header bg-dark text-white fw-bold">TF-IDF 전체 목록</div>
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
    </div>
</div>

<script>
const freqRaw = [
    <c:forEach var="kw" items="${keywordFreq}" end="19" varStatus="s">
    { keyword: "${kw.keyword}", value: ${kw.frequency} }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];
const tfidfRaw = [
    <c:forEach var="kw" items="${keywordTfidf}" end="19" varStatus="s">
    { keyword: "${kw.keyword}", value: ${kw.tfidfScore} }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

function barChart(id, data, color) {
    new Chart(document.getElementById(id), {
        type: 'bar',
        data: {
            labels: data.map(d => d.keyword),
            datasets: [{ data: data.map(d => d.value), backgroundColor: color, borderRadius: 5 }]
        },
        options: {
            indexAxis: 'y', responsive: true,
            plugins: { legend: { display: false } },
            scales: { x: { beginAtZero: true } }
        }
    });
}

barChart('freqChart',  freqRaw,  '#2563eb');
barChart('tfidfChart', tfidfRaw, '#9333ea');
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
