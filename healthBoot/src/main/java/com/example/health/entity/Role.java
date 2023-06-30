package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.List;

@TableName("role")
@Data
public class Role {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String name;
    private String comment;
    @TableField(exist = false)
    private List<Integer> permissions;
}
