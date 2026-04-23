<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Time Series Analysis — Nuclear Policy</title>
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
    <div class="card card-nuclear mb-4">
        <div class="card-header bg-dark text-white fw-bold">
            📈 연도별 키워드 빈도 및 이벤트 단계 (Period Stage)
        </div>
        <div class="card-body">
            <canvas id="tsFullChart" height="80"></canvas>
        </div>
    </div>

    <div class="card card-nuclear">
        <div class="card-header bg-dark text-white fw-bold">데이터 테이블</div>
        <div class="card-body p-0">
            <table class="table table-sm table-hover mb-0" style="font-size:0.82rem">
                <thead class="table-light">
                    <tr><th>Year</th><th>Keyword</th><th>Period Stage</th><th class="text-end">Count</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="ts" items="${timeSeriesData}">
                    <tr>
                        <td>${ts.year}</td>
                        <td>${ts.keyword}</td>
                        <td><span class="badge bg-secondary">${ts.periodStage}</span></td>
                        <td class="text-end fw-bold">${ts.totalCount}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
const tsRaw = [
    <c:forEach var="ts" items="${timeSeriesData}" varStatus="s">
    { year: ${ts.year}, keyword: "${ts.keyword}", stage: "${ts.periodStage}", count: ${ts.totalCount} }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

const years    = [...new Set(tsRaw.map(d => d.year))].sort();
const keywords = [...new Set(tsRaw.map(d => d.keyword))];
const palette  = ['#2563eb','#16a34a','#9333ea','#f97316','#e11d48','#0891b2','#65a30d','#a855f7','#f43f5e','#14b8a6'];

const datasets = keywords.map((kw,i) => ({
    label: kw,
    data: years.map(yr => {
        const row = tsRaw.find(d => d.year === yr && d.keyword === kw);
        return row ? row.count : 0;
    }),
    borderColor: palette[i % palette.length],
    backgroundColor: palette[i % palette.length] + '20',
    tension: 0.3, fill: false, pointRadius: 4
}));

new Chart(document.getElementById('tsFullChart'), {
    type: 'line',
    data: { labels: years, datasets },
    options: {
        responsive: true,
        plugins: { legend: { position: 'bottom' }, tooltip: { mode: 'index' } },
        scales: {
            x: { title: { display: true, text: 'Year' } },
            y: { title: { display: true, text: 'Frequency' }, beginAtZero: true }
        }
    }
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
