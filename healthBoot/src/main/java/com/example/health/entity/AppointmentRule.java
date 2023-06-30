package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 预约管理(规则)
 */
@TableName("appointment_rule")
@Data
public class AppointmentRule {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String month;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date day;
    private Integer limitPeople;
    private String remark;
    private String createPeople;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private Integer isDel;
}
