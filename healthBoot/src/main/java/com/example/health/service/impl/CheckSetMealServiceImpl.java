package com.example.health.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckSetMeal;
import com.example.health.mapper.CheckSetMealMapper;
import com.example.health.service.CheckSetMealService;
import com.example.health.utils.NumberFormatUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CheckSetMealServiceImpl extends ServiceImpl<CheckSetMealMapper, CheckSetMeal> implements CheckSetMealService {

    @Resource
    private CheckSetMealMapper checkSetMealMapper;


    @Override
    public Result<?> findCheckSetMealPage(Integer pageNum, Integer pageSize, String search) {
        LambdaQueryWrapper<CheckSetMeal> wrapper = Wrappers.<CheckSetMeal>lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(CheckSetMeal::getName, search);
        }
        wrapper.eq(CheckSetMeal::getIsDel,0);
        Page<CheckSetMeal> newsPage = checkSetMealMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @Override
    public Result<?> addCheckSetMeal(CheckSetMeal CheckSetMeal) {
        //先查询检查组总共有多少条数据，编号往上叠加
        CheckSetMeal params=new CheckSetMeal();
        params.setIsDel(0);
        QueryWrapper<CheckSetMeal> queryWrapper=new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckSetMeal> dataList=checkSetMealMapper.selectList(queryWrapper);
        Integer groupNumberExist=dataList.size()+1;
        NumberFormatUtils numberFormatUtils=new NumberFormatUtils();
        String groupNumber=numberFormatUtils.fillString(groupNumberExist,4);
        CheckSetMeal.setNumber(groupNumber);
        Integer result=checkSetMealMapper.insert(CheckSetMeal);
        if(result>0){
            return Result.success("添加成功");
        }else{
            return Result.error("-1","添加失败");
        }

    }

    @Override
    public Result<?> update(CheckSetMeal checkSetMeal) {
        Integer result=checkSetMealMapper.updateById(checkSetMeal);
        if(result>0){
            return Result.success("修改成功");
        }else{
            return Result.error("-1","修改失败");
        }
    }

    @Override
    public Result<?> getMealList(CheckSetMeal checkSetMeal) {
        CheckSetMeal params=new CheckSetMeal();
        params.setIsDel(0);
        QueryWrapper<CheckSetMeal> queryWrapper=new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckSetMeal> dataList=checkSetMealMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }


}
