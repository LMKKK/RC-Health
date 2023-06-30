package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("check_group")
@Data
public class CheckGroup {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String itemsIds;
    private String number;
    private String name;
    private String suitSex;
    private String mnemonicCode;
    private Integer dutyDoctorId;
    private String dutyDoctorName;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private Integer isDel;
}
