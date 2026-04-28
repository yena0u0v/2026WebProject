package com.project.nuclear.controller;

import com.project.nuclear.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;

    /** ✅ 메인 (SSR 유지, 절대 안 죽는 구조) */
    @GetMapping("/")
    public String index(Model model) {

        try {
            model.addAttribute("articles", newsService.getAllArticles());
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            e.printStackTrace();

            // 🔥 핵심: 절대 null 금지 → emptyList
            model.addAttribute("articles", Collections.emptyList());
            model.addAttribute("timeSeriesData", Collections.emptyList());
            model.addAttribute("keywordFreq", Collections.emptyList());
            model.addAttribute("keywordTfidf", Collections.emptyList());

            model.addAttribute("error", "DB 연결 지연 또는 실패");
        }

        return "index";
    }

    /** 시계열 */
    @GetMapping("/analysis/timeseries")
    public String timeseries(Model model) {
        try {
            model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
        } catch (Exception e) {
            model.addAttribute("timeSeriesData", Collections.emptyList());
        }
        return "analysis/timeseries";
    }

    /** 키워드 */
    @GetMapping("/analysis/keyword")
    public String keyword(Model model) {
        try {
            model.addAttribute("keywordFreq", newsService.getKeywordFreq());
            model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            model.addAttribute("keywordFreq", Collections.emptyList());
            model.addAttribute("keywordTfidf", Collections.emptyList());
        }
        return "analysis/keyword";
    }

    /** ✅ Render 헬스 체크 (필수) */
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK";
    }
}