package com.example.health.controller;

import com.example.health.common.Result;
import com.example.health.entity.Appointment;
import com.example.health.entity.AppointmentRule;
import com.example.health.service.AppointmentService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.Map;

@RestController
@RequestMapping("/appointment")
public class AppointmentController extends BaseController {

    @Resource
    private AppointmentService appointmentService;

    @PostMapping
    public Result<?> save(@RequestBody Appointment appointment) {

        return appointmentService.addAppointment(appointment);
    }

    @PutMapping
    public Result<?> update(@RequestBody Appointment appointment) {
        return appointmentService.update(appointment);
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") Integer userId) {

        return appointmentService.findAppointmentPage(pageNum,pageSize,search,userId);
    }

    /**
     * 查询检查组List
     *
     * @return
     */
    @PostMapping("/getAppointmentList")
    public Result<?> getAppointmentList(Appointment appointment) {
        return appointmentService.getAppointmentList(appointment);
    }

    /**
     * 保存单条规则信息
     *
     * @return
     */
    @PostMapping("/saveAppointmentRule")
    public Result<?> saveAppointmentRule(@RequestBody AppointmentRule appointmentRule) {
        return appointmentService.saveAppointmentRule(appointmentRule);
    }

    /**
     * 批量保存规则信息
     *
     * @return
     */
    @PostMapping("/batchSaveAppointment")
    public Result<?> batchSaveAppointment(@RequestBody Map map) {
        return appointmentService.batchSaveAppointmentRule(map);
    }

    /**
     * 获取当月设置好的规则信息
     *
     * @return
     */
    @PostMapping("/getAppointmentRuleList")
    public Result<?> getAppointmentRuleList(AppointmentRule appointmentRule) {
        return appointmentService.getAppointmentRuleList(appointmentRule);
    }

    /**
     * 查询当日预约信息
     *
     * @return
     */
    @PostMapping("/getDayAppointment")
    public Result<?> getDayAppointment(@RequestBody Map map) {
        return appointmentService.getDayAppointment(map);
    }

    /**
     * 校验当天预约人数是否已满
     * @return
     */
    @PostMapping("/validateCount")
    public Result<?> validateCount(@RequestBody Map map) throws ParseException {

        return appointmentService.validateCount(map);
    }
}
