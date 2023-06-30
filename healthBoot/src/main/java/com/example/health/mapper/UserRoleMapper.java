package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.UserRole;
import org.apache.ibatis.annotations.Select;

/**
 * @author 太好听了吧
 * @version 1.0
 * @Description 用户角色数据层
 */
public interface UserRoleMapper extends BaseMapper<UserRole> {

    @Select("delete from user_role where user_id=#{userId}")
    void deleteByUserRoleId(Long userId);
}
