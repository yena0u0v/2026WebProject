package com.project.nuclear.controller;

import com.project.nuclear.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;

    /** 메인 대시보드 */
    @GetMapping("/")
    public String index(Model model) {

        try {
            model.addAttribute("articles", newsService.getAllArticles());
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            // 🔥 핵심: 에러 나도 화면은 뜨게
            e.printStackTrace();
            model.addAttribute("error", "데이터 로딩 실패");
        }

        return "index"; // /WEB-INF/views/index.jsp
    }

    /** 시계열 분석 */
    @GetMapping("/analysis/timeseries")
    public String timeseries(Model model) {
        try {
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "시계열 데이터 로딩 실패");
        }
        return "analysis/timeseries";
    }

    /** 키워드 분석 */
    @GetMapping("/analysis/keyword")
    public String keyword(Model model) {
        try {
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "키워드 데이터 로딩 실패");
        }
        return "analysis/keyword";
    }

    /** 🔥 디버깅용 (이걸로 404 vs JSP 문제 구분) */
    @GetMapping("/test")
    public String test() {
        return "index";
    }
}