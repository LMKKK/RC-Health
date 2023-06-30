package com.example.health.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.health.common.Result;
import com.example.health.entity.Role;
import com.example.health.entity.RolePermission;
import com.example.health.entity.User;
import com.example.health.entity.UserRole;
import com.example.health.mapper.PermissionMapper;
import com.example.health.mapper.RoleMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Resource
    RoleMapper RoleMapper;

    @Resource
    PermissionMapper permissionMapper;

    @PostMapping
    public Result<?> save(@RequestBody Role Role) {
        RoleMapper.insert(Role);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Role Role) {
        RoleMapper.updateById(Role);
        return Result.success();
    }

    // 改变权限接口
    @PutMapping("/changePermission")
    public Result<?> changePermission(@RequestBody Role role) {
        // 先根据角色id删除所有的角色跟权限的绑定关系
        permissionMapper.deletePermissionsByRoleId(role.getId());
        // 再新增 新的绑定关系
        for (Integer permissionId : role.getPermissions()) {
            permissionMapper.insertRoleAndPermission(role.getId(), permissionId);
        }

        // 判断当前登录的用户角色是否包含了当前操作行的角色id，如果包含，则返回true，需要重新登录。
        User user = getUser();
        List<UserRole> userRoles = RoleMapper.getUserRoleByUserId(user.getId());
        if (userRoles.stream().anyMatch(userRole -> userRole.getRoleId().equals(role.getId()))) {
            return Result.success(true);
        }
//        如果不包含，则返回false，不需要重新登录。
        return Result.success(false);
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        RoleMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(RoleMapper.selectById(id));
    }

    @GetMapping("/all")
    public Result<?> all() {
        return Result.success(RoleMapper.selectList(null));
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Role> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(Role::getName, search);
        }
        Page<Role> RolePage = RoleMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Role> records = RolePage.getRecords();
        // 给角色设置绑定的权限id数组
        for (Role record : records) {
            Integer roleId = record.getId();
            List<Integer> permissions = permissionMapper.getRolePermissionByRoleId(roleId).stream().map(RolePermission::getPermissionId).collect(Collectors.toList());
            record.setPermissions(permissions);
        }
        return Result.success(RolePage);
    }
}
