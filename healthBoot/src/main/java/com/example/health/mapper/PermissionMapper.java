package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.Permission;
import com.example.health.entity.RolePermission;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PermissionMapper extends BaseMapper<Permission> {

    @Select("select * from role_permission where role_id = #{roleId}")
    List<RolePermission> getRolePermissionByRoleId(Integer roleId);

    @Delete("delete from role_permission where role_id = #{roleId}")
    void deletePermissionsByRoleId(Integer roleId);

    @Insert("insert into role_permission(role_id, permission_id) values(#{roleId}, #{permissionId})")
    void insertRoleAndPermission(@Param("roleId") Integer roleId, @Param("permissionId") Integer permissionId);

}
