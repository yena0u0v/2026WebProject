package com.project.nuclear.model;

import lombok.Data;

@Data
public class NewsArticle {
    private Integer articleId;
    private Integer plantId;
    private String  title;
    private String  content;
    private String  source;
    private String  url;
    private String  publishedDate;
    private Double  sentimentScore;
    private String  periodType;
}

