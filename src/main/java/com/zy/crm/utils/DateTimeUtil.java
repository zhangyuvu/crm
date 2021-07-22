package com.zy.crm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zy
 */

// 拿到系统时间的工具类
public class DateTimeUtil {

    public static String getSysTime(){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(new Date());
    }

}
