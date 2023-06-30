package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.controller.dto.UserAddressDto;
import com.example.health.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService extends IService<User> {

    Map<String,Long> getUserAddressByTown();

}
