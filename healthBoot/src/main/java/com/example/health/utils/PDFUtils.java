package com.example.health.utils;

import cn.hutool.core.date.DateUtil;
import com.example.health.entity.Appointment;
import com.example.health.entity.CheckItemsData;
import com.example.health.entity.Report;
import com.example.health.entity.User;
import lombok.extern.slf4j.Slf4j;
import wiki.xsx.core.pdf.template.doc.XEasyPdfTemplateDocument;
import wiki.xsx.core.pdf.template.doc.component.table.XEasyPdfTemplateTable;
import wiki.xsx.core.pdf.template.doc.component.table.XEasyPdfTemplateTableRow;
import wiki.xsx.core.pdf.template.doc.component.text.XEasyPdfTemplateText;
import wiki.xsx.core.pdf.template.doc.component.text.XEasyPdfTemplateTextExtend;
import wiki.xsx.core.pdf.template.doc.page.XEasyPdfTemplatePage;
import wiki.xsx.core.pdf.template.handler.XEasyPdfTemplateHandler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
public class PDFUtils {

    public XEasyPdfTemplateDocument document(Appointment appointment, User user, Report report) {
        // 定义输出路径
//        String outputPath = "F:\\template-demo.pdf";
        // 创建标题
        XEasyPdfTemplateText title = XEasyPdfTemplateHandler.Text.build()
                // 设置id
                .setId("title")
                // 设置文本
                .setText("体检报告")
                // 设置字体大小
                .setFontSize("20pt")
                // 设置水平居中
                .setHorizontalStyle("center");
        // 创建扩展文本
        XEasyPdfTemplateTextExtend extendText = XEasyPdfTemplateHandler.TextExtend.build()
                // 设置字体大小
                .setFontSize("12pt")
                // 设置段前空白
                .setSpaceBefore("12pt")
                // 设置段前缩进
                .setStartIndent("60pt")
                // 设置文本间隔
                .setTextSpacing("80pt")
                // 设置文本
                .addText(
                        XEasyPdfTemplateHandler.Text.build().setText("打印时间：" + DateUtil.today()),
                        XEasyPdfTemplateHandler.Text.build().setText("负责单位：荣成市健康管理平台")
                );

        // 创建表头
        XEasyPdfTemplateTable table = XEasyPdfTemplateHandler.Table.build().setHeader(
                null
        ).setBody(
                // 设置表格主体
                XEasyPdfTemplateHandler.Table.Body.build().addRow(
                        this.createPersonHeader(user),
                        this.createMetal(appointment)
                ).addRow(this.creatBodyList(report))
        ).setMinRowHeight("30pt").setVerticalStyle("center");

        // 创建页面
        XEasyPdfTemplatePage page = XEasyPdfTemplateHandler.Page.build()
                // 设置页面id
                .setId("pageId")
                // 设置字体
                .setFontFamily("微软雅黑")
                // 设置字体大小
                .setFontSize("15pt")
                // 设置边距（上下左右）
                .setMargin("20pt")
                // 设置主体内容
                .addBodyComponent(title, extendText, table)
                // 设置页脚高度
                .setFooterHeight("20pt")
                // 设置页脚内容
                .addFooterComponent(
                        // 创建块容器并添加内容
                        XEasyPdfTemplateHandler.BlockContainer.build().addComponent(
                                // 创建文本
                                XEasyPdfTemplateHandler.Text.build().setText("第 "),
                                // 创建当前页码
                                XEasyPdfTemplateHandler.CurrentPageNumber.build(),
                                XEasyPdfTemplateHandler.Text.build().setText(" 页，共 "),
                                // 创建总页码并设置页面id
                                XEasyPdfTemplateHandler.TotalPageNumber.build().setPageId("pageId"),
                                XEasyPdfTemplateHandler.Text.build().setText(" 页")
                        ).setHorizontalStyle("center")
                );

        // 添加页面并转换
//        XEasyPdfTemplateHandler.Document.build().addPage(page).transform(outputPath);
        XEasyPdfTemplateDocument document = XEasyPdfTemplateHandler.Document.build().addPage(page);

        return document;
    }


    /**
     * 设置套餐数据
     * @param appointment
     * @return
     */
    private XEasyPdfTemplateTableRow createMetal(Appointment appointment) {
        XEasyPdfTemplateTableRow row = XEasyPdfTemplateHandler.Table.Row.build();

        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText("检查时间")
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build()
                                        .setText(DateUtil.format(appointment.getAppointmentTime(), "yyyy-MM-dd"))

                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("所选套餐")
                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")

        );

        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(appointment.getMealName())
                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")
                        .setColumnSpan(2)
        );

        return row;

    }


    /**
     * 生成表格主体全部数据： 检查组头 + 检查项数据
     * @param report
     * @return
     */
    private List<XEasyPdfTemplateTableRow> creatBodyList(Report report) {
        if (report == null) {
            return null;
        }

        ArrayList<XEasyPdfTemplateTableRow> list = new ArrayList<>();
        List resMapList = report.getResMap();

        if (resMapList == null) {
            return null;
        }

        log.error("所有的检查组{}",resMapList);

        // 遍历循环数据
        for (int i = 0; i < resMapList.size(); i++) {
            Map resMap = (Map) resMapList.get(i);
            log.error("每个检查组的所有信息{}",resMap);
            // 添加检查组数据信息:检查组名称、负责医生
            list.add(this.createGroupHeaderInfo(resMap));
            // 设置检查组头部
            list.add(this.createGroupHeader());

            log.error("该检查组:{},所有检查数据{}",resMap.get("groupName"),resMap.get("itemsData"));
            // 添加检查项数据
            List<CheckItemsData> itemsDataList = (List<CheckItemsData>) resMap.get("itemsData");
            log.debug("该检查组的检查项数目:{}",itemsDataList.size());
            for (int j = 0; j < itemsDataList.size(); j++) {
                list.add(this.createItem(itemsDataList.get(j), j + 1));
            }
        }
        return list;
    }

    /**
     * 添加检查组表头 ， 序号、检查项、检查结果 这个表头
     *
     * @return
     */
    private XEasyPdfTemplateTableRow createGroupHeader() {
        XEasyPdfTemplateTableRow row = XEasyPdfTemplateHandler.Table.Row.build();
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("序号")
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("检查项")
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("检查结果")
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        return row;
    }

    /**
     * 创建检查项数据行
     *
     * @param checkItemsData
     * @param index
     * @return
     */
    private XEasyPdfTemplateTableRow createItem(CheckItemsData checkItemsData, Integer index) {
        XEasyPdfTemplateTableRow row = XEasyPdfTemplateHandler.Table.Row.build();

        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(index.toString())
                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(checkItemsData.getItemName())
                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(checkItemsData.getItemValue())
                        ).setBorderStyle("solid")
                        .setBackgroundColor(null)
                        .setHorizontalStyle("center")
                        .setColumnSpan(2)
        );

        return row;
    }

    /**
     * 添加检查组行数据
     *
     * @param resMap
     * @return
     */
    private XEasyPdfTemplateTableRow createGroupHeaderInfo(Map resMap) {
        log.debug("检查组表头{}",resMap);
        XEasyPdfTemplateTableRow row = XEasyPdfTemplateHandler.Table.Row.build();
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("检查组名称")
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(1)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(resMap.get("groupName").toString())
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(2)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText("负责医生")
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(1)
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                                XEasyPdfTemplateHandler.Text.build().setText(resMap.get("docterName").toString())
                        ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
                        .setColumnSpan(2)
        );

        return row;
    }

    /**
     * 设置表头 用户信息行数据
     *
     * @param user
     * @return
     */
    private XEasyPdfTemplateTableRow createPersonHeader(User user) {
        XEasyPdfTemplateTableRow row = XEasyPdfTemplateHandler.Table.Row.build();
        // 设置姓名
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText("姓名")
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText(user.getUsername())
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
//        设置年龄
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText("年龄")
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText(user.getAge().toString())
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );

//        设置性别
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText("性别")
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
        row.addCell(
                XEasyPdfTemplateHandler.Table.Cell.build().addComponent(
                        XEasyPdfTemplateHandler.Text.build().setText(user.getSex())
                ).setBorderStyle("solid").setBackgroundColor(null).setHorizontalStyle("center")
        );
        return row;
    }

}
