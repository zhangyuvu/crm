package com.zy.crm.settings.dao;


import com.zy.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

// userDAO接口
public interface UserDao {

    // 登录查询 传入一个User 根据要求查询user信息
    User selectUserLogin(User user);

    // 查询所有user姓名
    List<User> selectAllUser();

    // 根据id差user
    User selectUserById(String id);

    // 根据领导id获取员工信息
    List<User> getEmp(String directorId);
}
