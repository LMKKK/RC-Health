package com.lyp;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

public class downLoadPDF {


    public static void main(String[] args) {
        String fileName = "test.pdf";
        String path = "D:pdf/";

        try {
            //创建文档，设置页面大小、左右上下边距
            Document document = new Document();

            //处理中文显示问题，使用资源字体
            BaseFont bfChinese = BaseFont.createFont("C:\\Windows\\Fonts\\simsun.ttc",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

            Font dateTitle = new Font(bfChinese,7,Font.NORMAL);
            Font title = new Font(bfChinese,12,Font.BOLD);//文字加粗
            Font textFont = new Font(bfChinese,7,Font.NORMAL);//文字正常

            //给出输出路径
            PdfWriter.getInstance(document, new FileOutputStream(path+fileName));

            //打开文档
            document.open();

            //标题
            PdfPTable tableTitle = new PdfPTable(3);

            PdfPTable codeTitle = new PdfPTable(1);
            //生成一个7列的表格
            PdfPTable table = new PdfPTable(7);

            //定义每个单元格的宽度
            float[] widthsHeaderTitle = {1f,1f,1f};
            float[] widthsCodeTitle = {1f};
            float[] widthsHeader = {1f,1f,1f,1f,1f,1f,2f};

            float lineHeight = (float)20.0;

            //设置表格每一格的宽度
            tableTitle.setWidths(widthsHeaderTitle);
            codeTitle.setWidths(widthsCodeTitle);
            table.setWidths(widthsHeader);

            //设置表格总体宽度
            tableTitle.setWidthPercentage(100);
            codeTitle.setWidthPercentage(100);
            table.setWidthPercentage(100);

            int colSpan = 1;

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date(System.currentTimeMillis());
            //添加标题
            createTableCellLeft("导出人：行如火", textFont, tableTitle, lineHeight, colSpan);
            createTableCellCenter("确认出差记录表", title, tableTitle, lineHeight, colSpan);
            createTableCellRight(formatter.format(date), dateTitle, tableTitle, lineHeight, colSpan);

            document.add(tableTitle);
            createTableCellRight("功能码： XXXXXXXXX",textFont, codeTitle, lineHeight, colSpan);
            document.add(codeTitle);
            document.add(new Paragraph("\n"));

            String[] array = {"报表生成日期 ","状态 ", "经办人员 ", "提交时间 ","复核人员 ", "复核时间 ", "情况补充 "};
            for (String s : array) {
                createTableCell(s, textFont, table, lineHeight, colSpan);
            }
            List<Map<String, Object>> dataResult = getResult();

            for (Map<String, Object> map : dataResult) {
                String dataTime = map.get("dateTime") != null?map.get("dateTime").toString():"0";
                String status = "0";
                if (null != map.get("status")) {
                    if ("0".equals(map.get("status"))) {
                        status = "待确认";
                    }
                    if ("1".equals(map.get("status"))) {
                        status = "待复核";
                    }
                    if ("2".equals(map.get("status"))) {
                        status = "已复核";
                    }
                }
                String creator = map.get("creator") != null?map.get("creator").toString():"0";
                String createTime = map.get("createTime") != null?map.get("createTime").toString():"0";
                String updator = map.get("updator") != null?map.get("updator").toString():"0";
                String updateTime = map.get("updateTime") != null?map.get("updateTime").toString():"0";
                String description = map.get("description") != null?map.get("description").toString():"0";

                createTableCell(dataTime, textFont, table, lineHeight, colSpan);
                createTableCell(status, textFont, table, lineHeight, colSpan);
                createTableCell(creator, textFont, table, lineHeight, colSpan);
                createTableCell(createTime, textFont, table, lineHeight, colSpan);
                createTableCell(updator, textFont, table, lineHeight, colSpan);
                createTableCell(updateTime, textFont, table, lineHeight, colSpan);
                createTableCell(description, textFont, table, lineHeight, colSpan);
            }
            document.add(table);


            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        File file = new File(fileName);
        System.out.println(file);
    }

    private static void createTableCell(String text, Font font, PdfPTable table, float lineHeight, int colSapn) {
        PdfPCell cell;
        cell = new PdfPCell(new Paragraph(text,font));
        //合并单元格列
        cell.setColspan(colSapn);
        //设置水平居中
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        //设置垂直居中
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setFixedHeight(lineHeight);
        //将单元格内容添加到表格中
        table.addCell(cell);
    }

    private static void createTableCellLeft(String text, Font font, PdfPTable table, float lineHeight ,int colSapn) {
        PdfPCell cell;
        cell = new PdfPCell(new Paragraph(text,font));
        //合并单元格列
        cell.setColspan(colSapn);
        //设置水平
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        //设置垂直
        cell.setVerticalAlignment(Element.ALIGN_BOTTOM);
        cell.setFixedHeight(lineHeight);
        cell.setBorderWidthRight(0);
        cell.setBorderWidthBottom(0);
        cell.setBorderWidthLeft(0);
        cell.setBorderWidthTop(0);
        //将单元格内容添加到表格中
        table.addCell(cell);
    }

    private static void createTableCellCenter(String text, Font font, PdfPTable table, float lineHeight ,int colSapn) {
        PdfPCell cell;
        cell = new PdfPCell(new Paragraph(text,font));
        //合并单元格列
        cell.setColspan(colSapn);
        //设置水平居中
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        //设置垂直居中
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setFixedHeight(lineHeight);
        cell.setBorderWidthLeft(0);
        cell.setBorderWidthRight(0);
        cell.setBorderWidthBottom(0);
        cell.setBorderWidthTop(0);

        //将单元格内容添加到表格中
        table.addCell(cell);

    }

    private static void createTableCellRight(String text, Font font, PdfPTable table, float lineHeight , int colSapn) {
        PdfPCell cell;
        cell = new PdfPCell(new Paragraph(text,font));
        //合并单元格列
        cell.setColspan(colSapn);
        //设置水平
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        //设置垂直
        cell.setVerticalAlignment(Element.ALIGN_TOP);
        cell.setFixedHeight(lineHeight);
        //将单元格内容添加到表格中
        //去除边框
        cell.setBorderWidthLeft(0);
        cell.setBorderWidthBottom(0);
        cell.setBorderWidthRight(0);
        cell.setBorderWidthTop(0);
        table.addCell(cell);
    }

    private static List<Map<String, Object>> getResult() {
        List<Map<String, Object>> result = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            Map<String, Object> map = new HashMap<>();
            map.put("dateTime", "2022/10/11");
            map.put("creator", "行如火");
            map.put("createTime", "2022/10/10");
            map.put("updator", "疾如风");
            map.put("updateTime", "2022/10/11");
            if(i == 0) {
                map.put("status", "0");
                map.put("description", "测试导出PDF");
            } else if (i < 4){
                map.put("status", "1");
                map.put("description", "测试导出PDF"+i);
            } else {
                map.put("status", "2");
                map.put("description", "测试导出PDF"+i);
            }
            result.add(map);
        }
        System.out.println(result);
        return result;
    }
}

