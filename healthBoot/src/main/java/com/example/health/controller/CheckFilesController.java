package com.example.health.controller;

import com.example.health.common.Result;
import com.example.health.entity.CheckFiles;
import com.example.health.service.CheckFilesService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 检查套餐控制层
 */
@RestController
@RequestMapping("/checkFiles")
public class CheckFilesController extends BaseController {

    @Resource
    private CheckFilesService checkFilesService;

    @PostMapping
    public Result<?> save(@RequestBody CheckFiles checkFiles) {
        return checkFilesService.addCheckFiles(checkFiles);
    }


    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") Integer userId) {

        return checkFilesService.findCheckFilesPage(pageNum,pageSize,search,userId);
    }

    @PutMapping
    public Result<?> update(@RequestBody CheckFiles checkFiles) {
        return checkFilesService.update(checkFiles);
    }


    /**
     * 查询体检套餐List
     * @return
     */
    @PostMapping("/getMealList")
    public Result<?> getMealList(CheckFiles checkFiles) {
        return checkFilesService.getMealList(checkFiles);
    }
}
