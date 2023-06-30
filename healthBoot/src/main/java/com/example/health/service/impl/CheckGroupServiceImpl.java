package com.example.health.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.CheckGroup;

import com.example.health.entity.CheckItems;
import com.example.health.entity.CheckSetMeal;
import com.example.health.mapper.CheckGroupMapper;
import com.example.health.mapper.CheckSetMealMapper;
import com.example.health.service.CheckGroupService;
import com.example.health.utils.NumberFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.NumberFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class CheckGroupServiceImpl extends ServiceImpl<CheckGroupMapper, CheckGroup> implements CheckGroupService {

    @Resource
    private CheckGroupMapper checkGroupMapper;
    @Autowired
    private CheckSetMealMapper checkSetMealMapper;

    @Override
    public Result<?> findCheckGroupPage(Integer pageNum, Integer pageSize, String search) {
        LambdaQueryWrapper<CheckGroup> wrapper = Wrappers.<CheckGroup>lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(CheckGroup::getName, search);
        }
        wrapper.eq(CheckGroup::getIsDel, 0);
        Page<CheckGroup> newsPage = checkGroupMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @Override
    public Result<?> addCheckGroup(CheckGroup checkGroup) {
        //先查询检查组总共有多少条数据，编号往上叠加
        CheckGroup params = new CheckGroup();
        params.setIsDel(0);
        QueryWrapper<CheckGroup> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckGroup> dataList = checkGroupMapper.selectList(queryWrapper);
        Integer groupNumberExist = dataList.size() + 1;
        NumberFormatUtils numberFormatUtils = new NumberFormatUtils();
        String groupNumber = numberFormatUtils.fillString(groupNumberExist, 4);
        checkGroup.setNumber(groupNumber);
        Integer result = checkGroupMapper.insert(checkGroup);
        if (result > 0) {
            return Result.success("添加成功");
        } else {
            return Result.error("-1", "添加失败");
        }

    }

    @Override
    public Result<?> update(CheckGroup checkGroup) {

        Integer result = checkGroupMapper.updateById(checkGroup);
        if (result > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("-1", "修改失败");
        }
    }

    @Override
    public Result<?> getCheckGroupList(CheckGroup checkGroup) {
        CheckGroup params = new CheckGroup();
        params.setIsDel(0);
        QueryWrapper<CheckGroup> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckGroup> dataList = checkGroupMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }

    @Override
    public Result<?> getgetCheckGroupListByMeal(Integer mealId) {
        // 获取套餐信息
        CheckSetMeal checkSetMeal = checkSetMealMapper.selectById(mealId);
        String groupIds = checkSetMeal.getGroupIds();
        if(StringUtils.isBlank(groupIds) ){
            // 该套餐没有设置检查组
            return Result.error("-1","该套餐尚未设置检查组,请重新选一个吧~~~");
        }
        // 从套餐中获取所有的检查组
        String[] idList = groupIds.split(",");

        // 返回所有的检查组
        List<CheckGroup> checkGroups = checkGroupMapper.selectBatchIds(Arrays.asList(idList));
        return Result.success(checkGroups);
    }


}
