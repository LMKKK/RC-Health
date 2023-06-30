package com.example.health.utils;

/**
 * 数字格式转换类
 */
public class NumberFormatUtils {

    /**
     * description: 使用 String.format 格式化数字，实现左侧补 0
     * @param num  需要格式化的数字
     * @param digit 生成字符串长度（保留数字位数）
     * @return String
     * @version v1.0
     * @author w
     */
    public String fillString(int num , int digit) {
        /**
         * 0：表示前面补0
         * digit：表示保留数字位数
         * d：表示参数为正数类型
         */
        return String.format("%0"+digit+"d", num);
    }

}
