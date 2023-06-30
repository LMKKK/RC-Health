package com.example.health.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.health.entity.News;

import java.util.List;

public interface NewsService {

    Page<News> getNewsByAuthor(String username, String nickName, Integer pageNum, Integer pageSize, String search);

}
