<body class="bg-light">

<nav class="navbar navbar-dark bg-dark px-4 py-3 mb-4">
    <span class="navbar-brand fw-bold fs-5">Nuclear Policy Analysis System</span>
</nav>

<div class="container-fluid px-4">

    <!-- 요약 카드 -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card text-white" style="background:#2563eb">
                <div class="card-body py-3">
                    <div class="small">Total Articles</div>
                    <div id="totalArticles" class="fs-3 fw-bold">0</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 차트 -->
    <div class="row g-3 mb-4">
        <div class="col-lg-8">
            <canvas id="timeSeriesChart"></canvas>
        </div>
        <div class="col-lg-4">
            <canvas id="keywordChart"></canvas>
        </div>
    </div>

    <!-- 뉴스 테이블 -->
    <table class="table">
        <thead>
        <tr>
            <th>제목</th>
            <th>출처</th>
            <th>점수</th>
        </tr>
        </thead>
        <tbody id="articleTable"></tbody>
    </table>

</div>

<script>
    async function loadData() {
        try {
            const res = await fetch('/api/data');
            const data = await res.json();

            /* ---------- 카드 ---------- */
            document.getElementById('totalArticles').innerText = data.articles.length;

            /* ---------- 테이블 ---------- */
            const tbody = document.getElementById('articleTable');
            tbody.innerHTML = '';
            data.articles.forEach(a => {
                tbody.innerHTML += `
                <tr>
                    <td>${a.title}</td>
                    <td>${a.source}</td>
                    <td>${a.sentimentScore}</td>
                </tr>
            `;
            });

            /* ---------- 차트 ---------- */
            const ts = data.timeSeriesData;

            const years = [...new Set(ts.map(d => d.year))];

            new Chart(document.getElementById('timeSeriesChart'), {
                type: 'line',
                data: {
                    labels: years,
                    datasets: [{
                        label: 'Count',
                        data: years.map(y => {
                            return ts.filter(t => t.year === y)
                                .reduce((sum, v) => sum + v.totalCount, 0);
                        })
                    }]
                }
            });

            const kw = data.keywordFreq.slice(0,10);

            new Chart(document.getElementById('keywordChart'), {
                type: 'bar',
                data: {
                    labels: kw.map(k => k.keyword),
                    datasets: [{
                        data: kw.map(k => k.frequency)
                    }]
                }
            });

        } catch (e) {
            console.error("🔥 데이터 로딩 실패", e);
            document.body.innerHTML += "<h3>데이터 로딩 실패</h3>";
        }
    }

    loadData();
</script>