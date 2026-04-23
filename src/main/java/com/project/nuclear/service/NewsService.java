package com.project.nuclear.service;

import com.project.nuclear.model.NewsArticle;
import java.util.List;
import java.util.Map;

public interface NewsService {
    List<NewsArticle> getAllArticles();
    List<Map<String, Object>> getTimeSeriesData();
    List<Map<String, Object>> getKeywordFreq();
    List<Map<String, Object>> getKeywordTfidf();
}