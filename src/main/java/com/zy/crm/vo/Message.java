package com.zy.crm.vo;

import org.springframework.stereotype.Component;

/**
 * @author zy
 */
//保存登录返回所需要的信息 用来做json格式转换的类
public class Message {

    private boolean success;
    // 返回的信息
    private String msg;

    public boolean getSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }

    public Message() {
    }
}
