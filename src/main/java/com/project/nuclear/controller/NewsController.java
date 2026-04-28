@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;

    @GetMapping("/")
    public String index(Model model) {

        try {
            model.addAttribute("articles", newsService.getAllArticles());
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "데이터 로딩 실패");
        }

        return "index";
    }

    // 🔥 Render 헬스체크 (이거 없으면 죽는다)
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK";
    }
}