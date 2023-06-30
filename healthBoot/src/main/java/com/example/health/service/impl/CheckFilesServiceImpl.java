package com.example.health.service.impl;

import cn.hutool.core.util.IdcardUtil;
import cn.hutool.core.util.ReUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.CheckFiles;
import com.example.health.entity.User;
import com.example.health.mapper.CheckFilesMapper;
import com.example.health.mapper.UserMapper;
import com.example.health.service.CheckFilesService;
import com.example.health.utils.NumberFormatUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CheckFilesServiceImpl extends ServiceImpl<CheckFilesMapper, CheckFiles> implements CheckFilesService {

    @Resource
    private CheckFilesMapper checkFilesMapper;
    @Resource
    private UserMapper userMapper;


    @Override
    public Result<?> findCheckFilesPage(Integer pageNum, Integer pageSize, String search, Integer userId) {
        LambdaQueryWrapper<CheckFiles> wrapper = Wrappers.<CheckFiles>lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(CheckFiles::getUserName, search);
        }
        wrapper.eq(CheckFiles::getIsDel, 0);
        if (userId != null) {
            wrapper.eq(CheckFiles::getUserId, userId);
        }
        Page<CheckFiles> newsPage = checkFilesMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @Override
    public Result<?> addCheckFiles(CheckFiles checkFiles) {
        //根据用户idg更新user表的数据
        Integer userId = checkFiles.getUserId();
        User user = userMapper.selectById(userId);
        user.setAge(checkFiles.getAge());
        user.setAddress(checkFiles.getAddress());
        user.setSex(checkFiles.getSex());
        userMapper.updateById(user);
        // 校验手机号
        String pattern = "^1[3|4|5|7|8][0-9]{9}$";
        if (!ReUtil.isMatch(pattern, checkFiles.getPhone())) {
            return Result.error("-1", "手机号错误");
        }
        // 校验身份证
        if (!IdcardUtil.isValidCard(checkFiles.getCardNumber())) {
            return Result.error("-1", "身份证号错误");
        }

        Integer result = checkFilesMapper.insert(checkFiles);
        if (result > 0) {
            return Result.success("添加成功");
        } else {
            return Result.error("-1", "添加失败");
        }

    }

    @Override
    public Result<?> update(CheckFiles checkFiles) {
        Integer userId = checkFiles.getUserId();
        User user = userMapper.selectById(userId);
        user.setAge(checkFiles.getAge());
        user.setAddress(checkFiles.getAddress());
        user.setSex(checkFiles.getSex());
        userMapper.updateById(user);
        Integer result = checkFilesMapper.updateById(checkFiles);
        if (result > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("-1", "修改失败");
        }
    }

    @Override
    public Result<?> getMealList(CheckFiles checkFiles) {
        CheckFiles params = new CheckFiles();
        params.setIsDel(0);
        QueryWrapper<CheckFiles> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<CheckFiles> dataList = checkFilesMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }


}
