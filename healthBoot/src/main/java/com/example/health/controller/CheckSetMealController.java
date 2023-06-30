package com.example.health.controller;

import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckItems;
import com.example.health.entity.CheckSetMeal;
import com.example.health.service.CheckSetMealService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 检查套餐控制层
 */
@RestController
@RequestMapping("/checkSetMeal")
public class CheckSetMealController extends BaseController {

    @Resource
    private CheckSetMealService checkSetMealService;

    @PostMapping
    public Result<?> save(@RequestBody CheckSetMeal checkSetMeal) {

        return checkSetMealService.addCheckSetMeal(checkSetMeal);
    }


    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {

        return checkSetMealService.findCheckSetMealPage(pageNum,pageSize,search);
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody CheckSetMeal checkSetMeal) {
        return checkSetMealService.update(checkSetMeal);
    }

    @PostMapping("/delete")
    public Result<?> delete(@RequestBody CheckSetMeal checkSetMeal) {
        checkSetMeal.setIsDel(1);
        checkSetMealService.update(checkSetMeal);
        return Result.success();
    }


    /**
     * 查询体检套餐List
     *
     * @return
     */
    @PostMapping("/getMealList")
    public Result<?> getMealList(CheckSetMeal checkSetMeal) {
        return checkSetMealService.getMealList(checkSetMeal);
    }
}
