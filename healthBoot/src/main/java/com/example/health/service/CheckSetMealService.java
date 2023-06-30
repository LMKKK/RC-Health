package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckSetMeal;

/**
 * 检查套餐接口
 */
public interface CheckSetMealService extends IService<CheckSetMeal> {

    Result<?> findCheckSetMealPage(Integer pageNum,Integer pageSize,String search);

    Result<?> addCheckSetMeal(CheckSetMeal checkSetMeal);

    Result<?> update(CheckSetMeal checkSetMeal);

    Result<?> getMealList(CheckSetMeal checkSetMeal);

}
