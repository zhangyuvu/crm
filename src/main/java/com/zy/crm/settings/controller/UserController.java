package com.zy.crm.settings.controller;

import com.zy.crm.settings.domain.User;
import com.zy.crm.exception.LoginFailException;
import com.zy.crm.settings.service.UserService;
import com.zy.crm.vo.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zy
 */

@Controller   // controller层只负责调用业务层处理逻辑  和返回结果
public class UserController {

    // 引用类型自动注入 由于springMVC容器是spring的子容器 所以可以从spring容器中拿出userService
    @Resource
    private UserService userService;

    // 验证用户登录的方法
    @RequestMapping("/settings/user/login.do" )
    @ResponseBody
    public Object userLogin(String loginAct, String loginPwd, HttpServletRequest request) throws LoginFailException {

        // 创建返回消息的map
        Message msg = new Message();

        // 拿到访问主机的ip地址
        String ip = request.getLocalAddr();

        User user = userService.queryUserLogin(loginAct,loginPwd,ip);

        // 如果service层代码没有抛出异常的话 将用户对象放入会话作用域对象 并完成提交
        //  抛出了异常会被exceptionHandler捕捉 帮助完成异常信息的回传
        request.getSession().setAttribute("user",user);

        msg.setSuccess(true);
        return msg;
    }


    //   获取自己的所有员工


    /**
     * @description 依据领导id获取员工信息
     * @param  directorId 领导id
     * @return  所有员工
     */
    @RequestMapping("/getEmpList")
    @ResponseBody
    public List<User> getEmp(String directorId){
        return userService.getEmp(directorId);
    }
}
