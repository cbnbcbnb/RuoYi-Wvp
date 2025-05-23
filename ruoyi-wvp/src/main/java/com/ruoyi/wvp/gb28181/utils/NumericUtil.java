package com.ruoyi.wvp.gb28181.utils;

/**
 * 数值格式判断和处理
 * @author lawrencehj
 * @date 2021年1月27日
 */
public class NumericUtil {
    /**
     * 判断是否Double格式
     * @param str
     * @return true/false
     */
    public static boolean isDouble(String str) {
        try {
            Double num2 = Double.valueOf(str);
//            logger.debug(num2 + " is a valid numeric string!");
            return true;
        } catch (Exception e) {
//            logger.debug(str + " is an invalid numeric string!");
            return false;
        }
    }

    /**
     * 判断是否Double格式
     * @param str
     * @return true/false
     */
    public static boolean isInteger(String str) {
        try {
            int num2 = Integer.valueOf(str);
//            logger.debug(num2 + " is an integer!");
            return true;
        } catch (Exception e) {
//            logger.debug(str + " is not an integer!");
            return false;
        }
    }
}
