package com.example.health.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.health.entity.CheckItems;
import org.apache.ibatis.annotations.Mapper;

/**
 * 检查项目持久层
 */
@Mapper
public interface CheckItemsMapper extends BaseMapper<CheckItems> {

}
