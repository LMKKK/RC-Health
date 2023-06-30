package com.example.health.controller;

import com.example.health.common.Result;

import com.example.health.entity.CheckItems;

import com.example.health.service.CheckItemsService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 检查项控制层
 */
@RestController
@RequestMapping("/checkItems")
public class CheckItemsController extends BaseController {

    @Resource
    private CheckItemsService checkItemsService;

    @PostMapping
    public Result<?> save(@RequestBody CheckItems checkItems) {

        return checkItemsService.addCheckItems(checkItems);
    }


    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {

        return checkItemsService.findCheckItemsPage(pageNum,pageSize,search);
    }

    /**
     * 查询检查项List
     *
     * @return
     */
    @PostMapping("/getCheckItemsList")
    public Result<?> getCheckItemsList(CheckItems checkItems) {
        return checkItemsService.getCheckItemsList(checkItems);
    }

    @PostMapping("/delete")
    public Result<?> delete(@RequestBody CheckItems checkItems) {
        checkItems.setIsDel(1);
        checkItemsService.update(checkItems);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody CheckItems checkItems) {
        return checkItemsService.update(checkItems);
    }
}
