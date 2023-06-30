package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.AppointmentRule;

import java.text.ParseException;
import java.util.Map;

public interface AppointmentService extends IService<Appointment> {

    Result<?> findAppointmentPage(Integer pageNum,Integer pageSize,String search,Integer userId);

    Result<?> addAppointment(Appointment appointment);

    Result<?> update(Appointment appointment);

    Result<?> getAppointmentList(Appointment appointment);

    Result<?> batchSaveAppointmentRule(Map map);

    Result<?> saveAppointmentRule(AppointmentRule appointmentRule);

    Result<?> getAppointmentRuleList(AppointmentRule appointmentRule);

    //查询当日预约信息
    Result<?> getDayAppointment(Map map);

    //校验预约人数是否已满
    Result<?> validateCount(Map map) throws ParseException;


    Appointment getAppointmentById(Integer id);




}
