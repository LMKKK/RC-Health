package com.example.health.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.CheckGroup;
import com.example.health.entity.CheckItems;
import com.example.health.mapper.CheckGroupMapper;
import com.example.health.mapper.CheckItemsMapper;
import com.example.health.service.CheckGroupService;
import com.example.health.service.CheckItemsService;
import com.example.health.utils.NumberFormatUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class CheckItemsServiceImpl extends ServiceImpl<CheckItemsMapper, CheckItems> implements CheckItemsService {

    @Resource
    private CheckItemsMapper checkItemsMapper;


    @Override
    public Result<?> findCheckItemsPage(Integer pageNum, Integer pageSize, String search) {
        LambdaQueryWrapper<CheckItems> wrapper = Wrappers.<CheckItems>lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(CheckItems::getName, search);
        }
        wrapper.eq(CheckItems::getIsDel,0);
        Page<CheckItems> newsPage = checkItemsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @Override
    public Result<?> addCheckItems(CheckItems checkItems) {
        //先查询检查组总共有多少条数据，编号往上叠加
        CheckItems params=new CheckItems();
        params.setIsDel(0);
        QueryWrapper<CheckItems> queryWrapper=new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckItems> dataList=checkItemsMapper.selectList(queryWrapper);
        Integer groupNumberExist=dataList.size()+1;
        NumberFormatUtils numberFormatUtils=new NumberFormatUtils();
        String groupNumber=numberFormatUtils.fillString(groupNumberExist,4);
        checkItems.setNumber(groupNumber);
        Integer result=checkItemsMapper.insert(checkItems);
        if(result>0){
            return Result.success("添加成功");
        }else{
            return Result.error("-1","添加失败");
        }

    }

    @Override
    public Result<?> getCheckItemsList(CheckItems checkItems) {
        CheckItems params=new CheckItems();
        params.setIsDel(0);
        QueryWrapper<CheckItems> queryWrapper=new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckItems> dataList=checkItemsMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }

    @Override
    public Result<?> update(CheckItems checkItems) {
        Integer result=checkItemsMapper.updateById(checkItems);
        if(result>0){
            return Result.success("修改成功");
        }else{
            return Result.error("-1","修改失败");
        }
    }


}
