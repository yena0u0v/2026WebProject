document.addEventListener('DOMContentLoaded', function () {
    console.log("Nuclear Policy Analysis System — Loaded");

    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function () {
            const q = this.value.toLowerCase();
            document.querySelectorAll('#articleTable tr').forEach(row => {
                row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
            });
        });
    }
});