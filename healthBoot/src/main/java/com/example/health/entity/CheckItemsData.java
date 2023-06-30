package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("check_items_data")
@Data
public class CheckItemsData {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer appointmentId;
    private Integer mealId;
    private String mealName;
    private Integer groupId;
    private String groupName;
    private Integer itemId;
    private String itemName;
    private String itemValue;
    private Integer userId;
    private String userName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date checkTime;
    private String createPeople;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private Integer isDel;
}
