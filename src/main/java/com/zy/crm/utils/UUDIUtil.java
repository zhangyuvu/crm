package com.zy.crm.utils;

import java.util.UUID;

/**
 * @author zy
 */
// 得到32位唯一值
public class UUDIUtil {

    public static String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }

}
