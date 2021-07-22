package com.zy.crm.exception;

/**
 * @author zy
 */
// 登录异常
public class LoginFailException extends GenericException {


    public LoginFailException() {
    }

    public LoginFailException(String message) {
        super(message);
    }


}
