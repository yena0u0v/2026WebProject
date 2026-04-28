package com.project.nuclear.controller;

import com.project.nuclear.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@GetMapping("/")
public String index() {
    return "index"; // JSP만 렌더링
}

@GetMapping("/api/data")
@ResponseBody
public Map<String, Object> data() {
    Map<String, Object> map = new HashMap<>();

    map.put("articles", newsService.getAllArticles());
    map.put("timeSeriesData", newsService.getTimeSeriesData());
    map.put("keywordFreq", newsService.getKeywordFreq());
    map.put("keywordTfidf", newsService.getKeywordTfidf());

    return map;
}

@GetMapping("/health")
@ResponseBody
public String health() {
    return "ok";
}
    /*
    *//** 메인 대시보드 *//*
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

    *//** 시계열 분석 *//*
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

    *//** 키워드 분석 *//*
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

   */