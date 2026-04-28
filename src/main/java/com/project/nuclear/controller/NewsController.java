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

    /** 메인 대시보드 — index.jsp */
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("articles",        newsService.getAllArticles());
        model.addAttribute("timeSeriesData",  newsService.getTimeSeriesData());
        model.addAttribute("keywordFreq",     newsService.getKeywordFreq());
        model.addAttribute("keywordTfidf",    newsService.getKeywordTfidf());
        return "index";
    }

    /** 시계열 분석 페이지 — analysis/timeseries.jsp */
    @GetMapping("/analysis/timeseries")
    public String timeseries(Model model) {
        model.addAttribute("timeSeriesData", newsService.getTimeSeriesData());
        return "analysis/timeseries";
    }

    /** 키워드 분석 페이지 — analysis/keyword.jsp */
    @GetMapping("/analysis/keyword")
    public String keyword(Model model) {
        model.addAttribute("keywordFreq",  newsService.getKeywordFreq());
        model.addAttribute("keywordTfidf", newsService.getKeywordTfidf());
        return "analysis/keyword";
    }
}