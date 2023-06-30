package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.List;

//@TableName("area")
@Data
public class Area {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String label;
    private Integer pid;
    private String value;
    @TableField(exist = false)
    private List<Area> children;
}
