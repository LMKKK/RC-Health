package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;

import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckItems;

/**
 * 检查项接口
 */
public interface CheckItemsService extends IService<CheckItems> {

    Result<?> findCheckItemsPage(Integer pageNum,Integer pageSize,String search);

    Result<?> addCheckItems(CheckItems checkItems);

    Result<?> getCheckItemsList(CheckItems checkItems);

    Result<?> update(CheckItems checkItems);

}
