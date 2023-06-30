package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.Appointment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AppointmentMapper extends BaseMapper<Appointment> {

    List<Map> getDayAppointment(Map map);

    Integer getDayLimit(String day);

    List<Appointment> getAppointmentPeople(Map map);
}
