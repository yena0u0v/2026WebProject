<script>
    /* 🔥 서버 대신 API로 데이터 로딩 */
    fetch('/api/data')
        .then(res => res.json())
        .then(data => {

            console.log("API DATA:", data);

            const articles = data.articles || [];
            const timeSeriesData = data.timeSeriesData || [];
            const keywordFreq = data.keywordFreq || [];
            const keywordTfidf = data.keywordTfidf || [];

            /* ---------- 요약 카드 ---------- */
            document.querySelectorAll('.fs-3')[0].innerText = articles.length;
            document.querySelectorAll('.fs-3')[1].innerText = keywordFreq.length;
            document.querySelectorAll('.fs-3')[2].innerText = timeSeriesData.length;
            document.querySelectorAll('.fs-3')[3].innerText = keywordTfidf.length;

            /* ---------- 뉴스 테이블 ---------- */
            const table = document.getElementById('articleTable');
            table.innerHTML = '';

            articles.forEach(a => {
                const row = `
                <tr>
                    <td>${a.title || ''}</td>
                    <td><span class="badge bg-secondary">${a.source || ''}</span></td>
                    <td><span class="badge bg-info text-dark">${a.periodType || ''}</span></td>
                    <td class="text-end">${a.sentimentScore ?? 0}</td>
                    <td>${a.publishedDate || ''}</td>
                </tr>
            `;
                table.insertAdjacentHTML('beforeend', row);
            });

            /* ---------- Time Series Chart ---------- */
            const years = [...new Set(timeSeriesData.map(d => d.year))].sort();

            const keywords = [...new Set(timeSeriesData.map(d => d.keyword))].slice(0,5);

            const datasets = keywords.map(kw => ({
                label: kw,
                data: years.map(y => {
                    const row = timeSeriesData.find(d => d.year === y && d.keyword === kw);
                    return row ? row.totalCount : 0;
                })
            }));

            new Chart(document.getElementById('timeSeriesChart'), {
                type: 'line',
                data: { labels: years, datasets: datasets }
            });

            /* ---------- Keyword Chart ---------- */
            const top10 = keywordFreq.slice(0,10);

            new Chart(document.getElementById('keywordChart'), {
                type: 'bar',
                data: {
                    labels: top10.map(d => d.keyword),
                    datasets: [{
                        data: top10.map(d => d.frequency)
                    }]
                }
            });

        })
        .catch(err => {
            console.error("API ERROR:", err);

            document.body.innerHTML =
                "<h2 style='padding:20px;color:red;'>데이터 로딩 실패 (서버는 살아있음)</h2>";
        });
</script>