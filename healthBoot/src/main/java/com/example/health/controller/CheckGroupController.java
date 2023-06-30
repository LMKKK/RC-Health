package com.example.health.controller;

import com.example.health.common.Result;
import com.example.health.entity.CheckGroup;
import com.example.health.service.CheckGroupService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/checkGroup")
public class CheckGroupController extends BaseController {

    @Resource
    private CheckGroupService checkGroupService;

    @PostMapping
    public Result<?> save(@RequestBody CheckGroup checkGroup) {
        return checkGroupService.addCheckGroup(checkGroup);
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody CheckGroup checkGroup) {
        return checkGroupService.update(checkGroup);
    }

    @PostMapping("/delete")
    public Result<?> delete(@RequestBody CheckGroup checkGroup) {
        checkGroup.setIsDel(1);
        checkGroupService.update(checkGroup);
        return Result.success();
    }

//    @GetMapping("/{id}")
//    public Result<?> getById(@PathVariable Long id) {
//        return Result.success(newsMapper.selectById(id));
//    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {

        return checkGroupService.findCheckGroupPage(pageNum,pageSize,search);
    }

    /**
     * 查询检查组List
     *
     * @return
     */
    @PostMapping("/getCheckGroupList")
    public Result<?> getCheckGroupList(CheckGroup checkGroup) {
        return checkGroupService.getCheckGroupList(checkGroup);
    }

    @GetMapping("/byMealId")
    public Result<?> getCheckGroupListByMealId(@RequestParam("mealId") Integer mealId){
        return checkGroupService.getgetCheckGroupListByMeal(mealId);
    }

}
