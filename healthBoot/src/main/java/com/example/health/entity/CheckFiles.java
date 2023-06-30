package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 健康档案实体
 */
@TableName("check_files")
@Data
public class CheckFiles {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer age;
    private String sex;
    private String userName;
    private String cardNumber;
    private String phone;
    private String address;
    private String weight;
    private String height;
    private String bloodType;
    private String medicalHistory;
    private String remark;
    private String createPeople;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private Integer isDel;
}
