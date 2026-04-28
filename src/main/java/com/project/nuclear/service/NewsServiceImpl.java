package com.project.nuclear.service;

import com.project.nuclear.mapper.NewsMapper;
import com.project.nuclear.model.NewsArticle;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
class NewsServiceImpl implements NewsService {

    private final NewsMapper newsMapper;

    @Override
    public List<NewsArticle> getAllArticles() {
        return newsMapper.selectAllArticles();
    }

    @Override
    public List<Map<String, Object>> getTimeSeriesData() {
        try {
            return newsMapper.selectTimeSeriesAnalysis();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // 🔥 절대 null 금지
        }
    }

    @Override
    public List<Map<String, Object>> getKeywordFreq() {
        try {
            return newsMapper.selectKeywordFreq();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public List<Map<String, Object>> getKeywordTfidf() {
        try {
            return newsMapper.selectKeywordTfidf();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }