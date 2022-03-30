package com.zy.crm.settings.service;


import com.zy.crm.settings.domain.User;
import com.zy.crm.exception.LoginFailException;

import java.util.List;
import java.util.Map;

// userService接口 定义service方法
public interface UserService {

    // 查询登录信息
    User queryUserLogin(String loginAct, String loginPwd, String ip) throws LoginFailException;

    // 查询所有用户的信息
    List<User> getUserList();

    // 根据acId查询用户（owner
    User getUserById(String id);

    // 依据领导id获取员工信息
    List<User> getEmp(String directorId);
}
