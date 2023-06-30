package com.example.health.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.health.common.Result;
import com.example.health.entity.News;
import com.example.health.mapper.NewsMapper;
import com.example.health.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/news")
public class NewsController extends BaseController {

    @Resource
    NewsMapper newsMapper;

    @Autowired
    private NewsService newsService;

    @PostMapping
    public Result<?> save(@RequestBody News news) {
        news.setTime(new Date());
        newsMapper.insert(news);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody News news) {
        newsMapper.updateById(news);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        newsMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(newsMapper.selectById(id));
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<News> wrapper = Wrappers.<News>lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(News::getTitle, search);
        }
        Page<News> newsPage = newsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @GetMapping("/byAuthor")
    public Result<?> getNewsByAuthor(@RequestParam String username,
                                     @RequestParam String nickName,
                                     @RequestParam(defaultValue = "1") Integer pageNum,
                                     @RequestParam(defaultValue = "10") Integer pageSize,
                                     @RequestParam(defaultValue = "") String search){

        Page<News> newsPage = newsService.getNewsByAuthor(username, nickName, pageNum, pageSize, search);
        if(newsPage == null){
            return Result.error("-1","请检查是否登录");
        }
        return Result.success(newsPage);
    }

    /**
     * 查询资讯信息
     * @return
     */
    @PostMapping("/getNewsList")
    public Result<?> getNewsList(@RequestBody News news) {
        QueryWrapper<News> queryWrapper=new QueryWrapper<>();
        queryWrapper.setEntity(news);
        List<News> dataList=newsMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }
}
