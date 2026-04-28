package com.project.nuclear.controller;

import com.project.nuclear.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;

    /** 🔥 메인 페이지 — DB 호출 절대 금지 */
    @GetMapping("/")
    public String index() {
        return "index"; // JSP만 렌더링
    }

    /** 🔥 데이터 API (여기서만 DB 접근) */
    @GetMapping("/api/data")
    @ResponseBody
    public Map<String, Object> data() {

        Map<String, Object> map = new HashMap<>();

        try {
            map.put("articles", newsService.getAllArticles());
            map.put("timeSeriesData", newsService.getTimeSeriesData());
            map.put("keywordFreq", newsService.getKeywordFreq());
            map.put("keywordTfidf", newsService.getKeywordTfidf());
        } catch (Exception e) {
            e.printStackTrace();

            // 🔥 절대 null 방지
            map.put("articles", new Object[]{});
            map.put("timeSeriesData", new Object[]{});
            map.put("keywordFreq", new Object[]{});
            map.put("keywordTfidf", new Object[]{});
        }

        return map;
    }

    /** 🔥 Render Health Check */
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK";
    }
}