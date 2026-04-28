package com.project.nuclear.mapper;

import com.project.nuclear.model.NewsArticle;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface NewsMapper {

    // 기본 뉴스 목록 조회
    List<NewsArticle> selectAllArticles();

    // 시계열 분석
    List<Map<String, Object>> selectTimeSeriesAnalysis();

    // 키워드 빈도 분석
    List<Map<String, Object>> selectKeywordFreq();

    // TF-IDF 분석
    List<Map<String, Object>> selectKeywordTfidf();
}