@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;

    @GetMapping("/")
    public String index(Model model) {

        try {
            // 🔥 최소 1개라도 반드시 실행 (Render 응답 보장)
            model.addAttribute("articles", newsService.getAllArticles());

            // 나머지는 선택적으로
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());

        } catch (Exception e) {
            e.printStackTrace();

            // 🔥 핵심: JSP에서 null 터지는 거 방지
            model.addAttribute("articles", List.of());
            model.addAttribute("timeSeriesData", List.of());
            model.addAttribute("keywordFreq", List.of());
            model.addAttribute("keywordTfidf", List.of());

            model.addAttribute("error", "데이터 로딩 실패");
        }

        return "index";
    }

    // 🔥 Render 생존용 (필수)
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK";
    }
}