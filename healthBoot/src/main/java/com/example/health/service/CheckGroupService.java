package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;
import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckItems;

public interface CheckGroupService extends IService<CheckGroup> {

    Result<?> findCheckGroupPage(Integer pageNum,Integer pageSize,String search);

    Result<?> addCheckGroup(CheckGroup checkGroup);

    Result<?> update(CheckGroup checkGroup);

    Result<?> getCheckGroupList(CheckGroup checkGroup);


    Result<?> getgetCheckGroupListByMeal(Integer mealId);
}
