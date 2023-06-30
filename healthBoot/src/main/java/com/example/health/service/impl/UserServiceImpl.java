package com.example.health.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.entity.User;
import com.example.health.mapper.UserMapper;
import com.example.health.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 根据城镇统计用户
     *
     * @return
     */
    @Override
    public Map<String, Long> getUserAddressByTown() {
        List<User> userList = userMapper.selectList(null);
//        log.debug("全部的用户信息为{}",userList);
        HashMap<String, Long> map = new HashMap<String, Long>();
        System.out.println("所有的用户的地址是");
        userList.forEach(new Consumer<User>() {
            @Override
            public void accept(User user) {
                String town = getTownByAddress(user.getAddress());
                if (!map.containsKey(town)) {
                    map.put(town, 0L);
                }
                map.put(town, map.get(town) + 1);
            }
        });
        return map;
    }

    private String getTownByAddress(String address) {
        String town = null;
        if(address == null){
            return "未知";
        }
        String[] addStr = address.split("-");

        // 如果不存在
        if (" ".equals(addStr[1])) {
            town = "未知";
        } else {
            town = addStr[1];
        }
        return town;
    }

}
