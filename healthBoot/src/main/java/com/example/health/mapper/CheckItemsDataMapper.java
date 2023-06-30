package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.CheckItems;
import com.example.health.entity.CheckItemsData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 检查项目持久层
 */
@Mapper
public interface CheckItemsDataMapper extends BaseMapper<CheckItemsData> {

    List<CheckItems> getItemsListByPre(Map map);

    List<Map<String,String>> getGroupAndDocter(@Param("userId") Integer userId, @Param("appointmentId") Integer appointmentId);
}
