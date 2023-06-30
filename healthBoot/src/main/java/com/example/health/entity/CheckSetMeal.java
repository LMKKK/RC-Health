package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 提交套餐实体类
 */
@TableName("check_set_meal")
@Data
public class CheckSetMeal {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String number;
    private String groupIds;
    private String name;
    private String suitSex;
    private String suitAge;
    private String mnemonicCode;
    private String createPeople;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date create_time;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date update_time;
    private Integer state;
    private Integer isDel;
}
