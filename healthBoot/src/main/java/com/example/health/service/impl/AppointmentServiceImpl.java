package com.example.health.service.impl;

import cn.hutool.core.util.StrUtil;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.AppointmentRule;
import com.example.health.mapper.AppointmentMapper;
import com.example.health.mapper.AppointmentRuleMapper;
import com.example.health.service.AppointmentService;
import com.example.health.utils.NumberFormatUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class AppointmentServiceImpl extends ServiceImpl<AppointmentMapper, Appointment> implements AppointmentService {

    @Resource
    private AppointmentMapper appointmentMapper;
    @Resource
    private AppointmentRuleMapper appointmentRuleMapper;


    @Override
    public Result<?> findAppointmentPage(Integer pageNum, Integer pageSize, String search, Integer userId) {
        LambdaQueryWrapper<Appointment> wrapper = Wrappers.<Appointment>lambdaQuery();
        wrapper.eq(Appointment::getIsDel, 0);
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(Appointment::getRemark, search);
        }
        if (userId != null) {
            wrapper.eq(Appointment::getAppointmentPeopleId, userId);
        }

        Page<Appointment> newsPage = appointmentMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(newsPage);
    }

    @Override
    public Result<?> addAppointment(Appointment appointment) {
        if(appointment.getMealId() == 0){
            log.debug("用户自定义套餐");
            log.debug("自定义检查组有{}",appointment.getGroupIds());
        }

        Appointment params = new Appointment();
        params.setIsDel(0);
        QueryWrapper<Appointment> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(params);


        Integer result = appointmentMapper.insert(appointment);
        if (result > 0) {
            return Result.success("添加成功");
        } else {
            return Result.error("-1", "添加失败");
        }

    }

    @Override
    public Result<?> update(Appointment Appointment) {

        Integer result = appointmentMapper.updateById(Appointment);
        if (result > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("-1", "修改失败");
        }
    }

    @Override
    public Result<?> getAppointmentList(Appointment appointment) {
        Appointment params = new Appointment();
        params.setIsDel(0);
        QueryWrapper<Appointment> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(params);
        List<Appointment> dataList = appointmentMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }

    @Override
    public Result<?> batchSaveAppointmentRule(Map map) {
        System.out.println("参数信息：：" + map);
        List<Map> list = (List<Map>) map.get("appointmentList");
        int saveSize = 0;
        String createPeople = "";
        if (map.get("createPeople") != null) {
            createPeople = (String) map.get("createPeople");
        }
        for (Map mapEntity : list) {
            AppointmentRule appointmentRule = JSON.parseObject(JSON.toJSONString(mapEntity), AppointmentRule.class);
            appointmentRule.setCreatePeople(createPeople);
            if (appointmentRule.getId() == null) {
                saveSize += appointmentRuleMapper.insert(appointmentRule);
            } else {
                saveSize += appointmentRuleMapper.updateById(appointmentRule);
            }

        }
        System.out.println(list);
        return Result.success(saveSize);
    }

    @Override
    public Result<?> saveAppointmentRule(AppointmentRule appointmentRule) {
        Integer result = 0;
        if (appointmentRule.getId() == null) {
            result += appointmentRuleMapper.insert(appointmentRule);
        } else {
            result += appointmentRuleMapper.updateById(appointmentRule);
        }
        if (result > 0) {
            return Result.success("保存成功");
        } else {
            return Result.error("-1", "保存失败");
        }
    }

    @Override
    public Result<?> getAppointmentRuleList(AppointmentRule appointmentRule) {

        appointmentRule.setIsDel(0);
        QueryWrapper<AppointmentRule> queryWrapper = new QueryWrapper<>();
        queryWrapper.setEntity(appointmentRule);
        List<AppointmentRule> dataList = appointmentRuleMapper.selectList(queryWrapper);
        return Result.success(dataList);
    }

    @Override
    public Result<?> getDayAppointment(Map map) {
        log.debug("预约查询参数是{}", map);
        //查询当月每一天预约了多少人
        List<Map> dataList = appointmentMapper.getDayAppointment(map);
        log.debug("查询每日预约信息结果为{}",dataList);
        for (Map mapEntity : dataList) {
            if (mapEntity.get("limitPeople") != null) {
//                Integer limitPeople = (Integer) mapEntity.get("limitPeople");
                Long limitPeople = (Long) mapEntity.get("limitPeople");
                Long preCount = (Long) mapEntity.get("preCount");
                Long residue = limitPeople - preCount;
                mapEntity.put("residue", residue);
            } else {
                Long preCount = (Long) mapEntity.get("preCount");
                mapEntity.put("residue", preCount);
            }

        }
        return Result.success(dataList);
    }

    @Override
    public Result<?> validateCount(Map map) throws ParseException {
        if (map.get("appointmentDay") == null) {
            return Result.error("-1", "参数错误");
        }
        String appointmentDay = (String) map.get("appointmentDay");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date day = dateFormat.parse(appointmentDay);
        //查询当日的预约规则
        QueryWrapper<AppointmentRule> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("day", day);
        AppointmentRule appointmentRule = appointmentRuleMapper.selectOne(queryWrapper);

        log.debug("当日预约规则{}",appointmentRule);

        if (appointmentRule == null) {
            return Result.error("-1", "当天还未设置规则，请请联系管理员设置可预约人数");
        }

        Integer limitPeople = appointmentRule.getLimitPeople();

        //查询当日已经预约的人数
        List<Appointment> dataList = appointmentMapper.getAppointmentPeople(map);
        log.debug("当天限约人数是{}",limitPeople);
        log.debug("当天预约人数{}",dataList);
        // 如果如果已约人数大于等于 限约人数， 没有名额了
        if (limitPeople <= dataList.size()) {
            return Result.error("-1", "当天预约人数已满");
        } else {
            return Result.success("当日还可以预约" + (limitPeople - dataList.size()) + "人");
        }

    }




    @Override
    public Appointment getAppointmentById(Integer id) {
        Appointment appointment = appointmentMapper.selectById(id);
        return appointment;
    }


}
