package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.Role;
import com.example.health.entity.UserRole;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RoleMapper extends BaseMapper<Role> {

    @Select("select * from user_role where user_id = #{userId}")
    List<UserRole> getUserRoleByUserId(Integer userId);


    @Delete("delete from user_role where user_id = #{userId}")
    void deleteRoleByUserId(Integer userId);

    @Insert("insert into user_role(user_id, role_id) values(#{userId}, #{roleId})")
    void insertUserRole(Integer userId, Integer roleId);
}
