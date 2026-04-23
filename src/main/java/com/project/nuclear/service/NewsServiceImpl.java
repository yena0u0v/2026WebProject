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
        return newsMapper.selectTimeSeriesAnalysis();
    }

    @Override
    public List<Map<String, Object>> getKeywordFreq() {
        return newsMapper.selectKeywordFreq();
    }

    @Override
    public List<Map<String, Object>> getKeywordTfidf() {
        return newsMapper.selectKeywordTfidf();
    }
}



