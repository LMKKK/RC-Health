package com.example.health.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckItems;
import com.example.health.entity.Report;
import com.example.health.entity.User;
import com.example.health.service.CheckItemsDataService;
import com.example.health.service.CheckItemsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 检查项控制层
 */
@RestController
@RequestMapping("/checkItemsData")
@Slf4j
public class CheckItemsDataController extends BaseController {

    @Resource
    private CheckItemsService checkItemsService;
    @Resource
    private CheckItemsDataService checkItemsDataService;

    @PostMapping
    public Result<?> save(@RequestBody CheckItems checkItems) {

        return checkItemsService.addCheckItems(checkItems);
    }


    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {

        return checkItemsService.findCheckItemsPage(pageNum, pageSize, search);
    }

    /**
     * 通过预约查询检查项List
     *
     * @return
     */
    @PostMapping("/getItemsListByPre")
    public Result<?> getItemsListByPre(@RequestBody Map map) {
        return checkItemsDataService.getItemsListByPre(map);
    }

    /**
     * 批量存储体检项信息
     *
     * @return
     */
    @PostMapping("/batchSaveCheckItemsData")
    public Result<?> batchSaveCheckItemsData(@RequestBody Map map) {
        return checkItemsDataService.batchSaveCheckItemsData(map);
    }

    /**
     * 查询用户体检报告信息
     *
     * @return
     */
    @PostMapping("/getCheckReportByUser")
    public Result<?> getCheckReportByUser(@RequestBody Appointment appointment) {
        Report resport = checkItemsDataService.getCheckReportByUser(appointment);
        return Result.success(resport);
    }

    @GetMapping("/export")
    public void export(@RequestParam("appointmentId") Integer appointmentId, HttpServletResponse response) throws IOException {
        log.debug("用户打印体检报告");
        checkItemsDataService.export(appointmentId, response);
    }

}
