package com.example.health.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckItems;
import com.example.health.entity.CheckItemsData;
import com.example.health.entity.Report;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 检查项接口
 */
public interface CheckItemsDataService extends IService<CheckItemsData> {

    Result<?> findCheckItemsPage(Integer pageNum,Integer pageSize,String search);

    Result<?> addCheckItems(CheckItems checkItems);

    /**
     * 根据预约的人,获取所有可以录入、修改的检查项
     * @param map
     * @return
     */
    Result<?> getItemsListByPre(Map map);

    Result<?> batchSaveCheckItemsData(Map map);

    Report getCheckReportByUser(Appointment appointment);


    void export(Integer appointmentId,HttpServletResponse response);
}
