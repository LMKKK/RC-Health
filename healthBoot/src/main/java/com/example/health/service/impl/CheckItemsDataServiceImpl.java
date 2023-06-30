package com.example.health.service.impl;

import cn.hutool.core.io.IoUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.health.common.Result;
import com.example.health.entity.*;
import com.example.health.mapper.*;
import com.example.health.service.CheckItemsDataService;
import com.example.health.utils.PDFUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wiki.xsx.core.pdf.template.doc.XEasyPdfTemplateDocument;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;
import java.util.function.Consumer;

@Service
@Slf4j
public class CheckItemsDataServiceImpl extends ServiceImpl<CheckItemsDataMapper, CheckItemsData> implements CheckItemsDataService {

    @Resource
    private CheckItemsDataMapper checkItemsDataMapper;
    @Resource
    private CheckItemsMapper checkItemsMapper;
    @Resource
    private CheckSetMealMapper checkSetMealMapper;
    @Resource
    private CheckGroupMapper checkGroupMapper;
    @Resource
    private UserMapper userMapper;

    @Autowired
    private AppointmentMapper appointmentMapper;

    @Override
    public Result<?> findCheckItemsPage(Integer pageNum, Integer pageSize, String search) {
        return null;
    }

    @Override
    public Result<?> addCheckItems(CheckItems checkItems) {
        return null;
    }

    @Override
    public Result<?> getItemsListByPre(Map map) {
        Integer mealId = (Integer) map.get("mealId");
//        LambdaQueryWrapper<CheckSetMeal> queryWrapper1=new LambdaQueryWrapper<>();
//        queryWrapper1.eq(CheckSetMeal::getIsDel,0).eq(CheckSetMeal::getId,mealId);
        // 获取到检查套餐,该预约的检查套餐
        CheckSetMeal checkSetMeal = checkSetMealMapper.selectById(mealId);
        //LambdaQueryWrapper<CheckGroup> queryWrapper=new LambdaQueryWrapper<>();

        QueryWrapper<CheckGroup> queryWrapper = new QueryWrapper<>();
        // 如果是自定义套餐，那么检查组信息在预约信息中
        String groupIds = checkSetMeal.getGroupIds();
        if(mealId == 0){
            groupIds = (String) map.get("groupIds");
        }
        // 用来存放所有的检查组id
        List<String> groupIdList = new ArrayList<>();
        if (groupIds != null) {
            String[] typeStr = groupIds.split(",");
            for (int i = 0; i < typeStr.length; i++) {
                groupIdList.add(typeStr[i]);
            }
        }
        queryWrapper.in("id", groupIdList);
        Integer dutyDoctorId = (Integer) map.get("dutyDoctorId");
        queryWrapper.eq("duty_doctor_id", dutyDoctorId);
        // 用来盛放所有的检查项结果
        List<Map> dataListItems = new ArrayList<>();
        // 用来存放所有的检查组
        List<CheckGroup> dataList = checkGroupMapper.selectList(queryWrapper);

        for (CheckGroup checkGroup : dataList) {
//            遍历此套餐的所有检查组
            String itemsIds = checkGroup.getItemsIds();
            List<String> itemsIdList = new ArrayList<>();
            if (itemsIds != null) {
                String[] itemsIdStr = itemsIds.split(",");
                for (int i = 0; i < itemsIdStr.length; i++) {
                    itemsIdList.add(itemsIdStr[i]);
                }
            }
            QueryWrapper<CheckItems> queryWrapper3 = new QueryWrapper<>();
            queryWrapper3.in("id", itemsIdList);
            List<CheckItems> checkItemsList = checkItemsMapper.selectList(queryWrapper3);
            List<Map> newDataMapList = new ArrayList<>();
            for (CheckItems checkItems : checkItemsList) {
                Map mapEntity = new HashMap();

                //根据预约信息，项目id查询是否保存过信息
                QueryWrapper<CheckItemsData> queryWrapper2 = new QueryWrapper<>();
                queryWrapper2.eq("appointment_id", map.get("appointmentId"));
                queryWrapper2.eq("item_id", checkItems.getId());
                CheckItemsData checkItemsExistData = checkItemsDataMapper.selectOne(queryWrapper2);
                if (checkItemsExistData != null) {
                    //将实体类转换为map
                    mapEntity = JSON.parseObject(JSON.toJSONString(checkItemsExistData), Map.class);
                } else {
                    mapEntity = JSON.parseObject(JSON.toJSONString(checkItems), Map.class);
                    mapEntity.put("itemId", checkItems.getId());
                    mapEntity.put("itemName", checkItems.getName());
                    mapEntity.put("groupId", checkGroup.getId());
                    mapEntity.put("groupName", checkGroup.getName());
                    mapEntity.put("mealId", mealId);
                    mapEntity.put("mealName", map.get("mealName"));
                    mapEntity.put("appointmentId", map.get("appointmentId"));
                    mapEntity.put("remark", null);
                }
                newDataMapList.add(mapEntity);
            }
            dataListItems.addAll(newDataMapList);
        }
        return Result.success(dataListItems);
    }


    @Override
    public Result<?> batchSaveCheckItemsData(Map map) {
        if (map.get("checkItemsListData") == null) {
            return Result.error("-1", "参数错误");
        }
        List<Map> list = (List<Map>) map.get("checkItemsListData");
        //String nowTime= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        int saveSize = 0;
        for (Map mapEntity : list) {
            CheckItemsData checkItemsData = JSON.parseObject(JSON.toJSONString(mapEntity), CheckItemsData.class);
            //根据预约ID、检查项ID查看该条信息是否已经录入过
            QueryWrapper<CheckItemsData> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.eq("appointment_id", checkItemsData.getAppointmentId());
            queryWrapper2.eq("item_id", checkItemsData.getItemId());
            CheckItemsData checkItemsExistData = checkItemsDataMapper.selectOne(queryWrapper2);
            checkItemsData.setCreatePeople((String) map.get("createPeople"));
            checkItemsData.setUserName((String) map.get("appointmentPeople"));
            checkItemsData.setUserId((Integer) map.get("appointmentPeopleId"));
            checkItemsData.setCheckTime(new Date());
            if (checkItemsExistData == null) {
                checkItemsData.setId(null);
                saveSize += checkItemsDataMapper.insert(checkItemsData);
            } else {
                checkItemsData.setId(checkItemsExistData.getId());
                saveSize += checkItemsDataMapper.updateById(checkItemsData);
            }
        }
        return Result.success(saveSize);
    }

    @Override
    public Report getCheckReportByUser(Appointment appointment) {
        //通过用户id查询用户基本信息
        Integer userId = appointment.getAppointmentPeopleId();
        User user = userMapper.selectById(userId);
        Report report = new Report();
        // 用户信息
        report.setUser(user);

        // 所有的检查组的名称以及负责的医生
        List<Map<String, String>> map = checkItemsDataMapper.getGroupAndDocter(userId, appointment.getId());
        log.debug("该套餐所有的检查组名称已经负责医生为{}", map);
        List<Map> res = new ArrayList<>();

        // 遍历，找出对应的检查项的值
        map.forEach(new Consumer<Map<String, String>>() {
            @Override
            public void accept(Map<String, String> item) {
                HashMap<Object, Object> resMap = new HashMap<>();
                resMap.put("docterName", item.get("create_people"));
                resMap.put("groupName", item.get("group_name"));
                // 获取该检查组的所有检查项的数据
                QueryWrapper<CheckItemsData> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("appointment_id", appointment.getId());
                queryWrapper.eq("user_id", userId);
                queryWrapper.eq("group_name", item.get("group_name"));
                // 此检查组的所有检查项的值
                List<CheckItemsData> itemsDataList = checkItemsDataMapper.selectList(queryWrapper);
                resMap.put("itemsData", itemsDataList);
                res.add(resMap);
            }
        });
        // 检查组数据
        report.setResMap(res);
        return report;
    }

    @Override
    public void export(Integer appointmentId, HttpServletResponse response) {
        log.debug("导出用户体检报告");
        Appointment appointment = appointmentMapper.selectById(appointmentId);
        log.debug("用户预约信息是{}", appointment);
        PDFUtils pdfUtils = new PDFUtils();
        Report report = this.getCheckReportByUser(appointment);
        log.debug("用户体检报告为{}", report);
        User user = userMapper.selectById(appointment.getAppointmentPeopleId());
        XEasyPdfTemplateDocument document = pdfUtils.document(appointment, user, report);

        response.setContentType("application/pdf;charset=utf-8");
        String fileName = null;
        try {
            fileName = URLEncoder.encode("体检报告", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            log.warn("文件名称编码异常");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".pdf");

        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
        } catch (IOException e) {
            log.warn("获取输出流失败");
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        document.transform(out);
        IoUtil.close(System.out);
    }
}
