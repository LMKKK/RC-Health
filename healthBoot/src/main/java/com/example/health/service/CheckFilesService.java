package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;
import com.example.health.entity.CheckFiles;

/**
 * 检查套餐接口
 */
public interface CheckFilesService extends IService<CheckFiles> {

    Result<?> findCheckFilesPage(Integer pageNum,Integer pageSize,String search,Integer userId);

    Result<?> addCheckFiles(CheckFiles checkFiles);

    Result<?> update(CheckFiles checkFiles);

    Result<?> getMealList(CheckFiles checkFiles);

}
