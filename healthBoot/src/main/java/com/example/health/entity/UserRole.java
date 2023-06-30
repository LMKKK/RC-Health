package com.example.health.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@TableName("user_role")
public class UserRole {
    private Integer userId;
    private Integer roleId;
}
