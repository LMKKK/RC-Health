package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 预约信息实体
 */
@TableName("appointment")
@Data
public class Appointment {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer appointmentPeopleId;
    private String appointmentPeople;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date appointmentTime;
    private Integer mealId;
    private String mealName;
    private String remark;
    private String createPeople;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private Integer isDel;
    private String groupIds;
}
