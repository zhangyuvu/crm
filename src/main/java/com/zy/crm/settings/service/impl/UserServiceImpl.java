package com.zy.crm.settings.service.impl;

import com.zy.crm.settings.dao.UserDao;
import com.zy.crm.settings.domain.User;
import com.zy.crm.exception.LoginFailException;
import com.zy.crm.settings.service.UserService;
import com.zy.crm.utils.DateTimeUtil;
import com.zy.crm.utils.MD5Util;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.*;

/**
 * @author zy
 */


// User类的service层 业务层用来处理业务
@Service
public class UserServiceImpl implements UserService {

    // UserDao层对象 通过Resource byName赋值
    @Resource
    private UserDao userDao ;

    // 查询登录信息
    @Override
    public User queryUserLogin(String loginAct, String loginPwd, String ip) throws LoginFailException {
        User user  = new User();

        // 设值登录账号和登录密码
        user.setLoginAct(loginAct);
        // 登录密码通过MD5加密
        user.setLoginPwd(MD5Util.getMD5(loginPwd));

        user = userDao.selectUserLogin(user);

        if (user == null){
             // 验证用户信息是否符合要求
            throw new LoginFailException("账号或密码错误！");

            // 验证失效时间 当前系统时间大于失效时间
        }else if(DateTimeUtil.getSysTime().compareTo(user.getExpireTime()) > 0){
            throw new LoginFailException("账号已经失效！");

            // 验证账号是否锁定
        }else if("0".equals(user.getLockState())){
            throw  new LoginFailException("此账号已锁定！");

            // 验证ip地址是否正确
        }else if(!user.getAllowIps().contains(ip)){
            throw new LoginFailException("访问主机无权限，以阻止访问！");
        }

        // 全部通过则返回uer
        return user;
    }

    // 查询所有用户姓名
    @Override
    public List<User> getUserList() {
        List<User> users = userDao.selectAllUser();

        return users;
    }

    @Override
    public User getUserById(String id) {

        User user = userDao.selectUserById(id);
        return user;
    }

    /**
     * @description 给定领导 id 获取员工信息
     */
    @Override
    public List<User> getEmp(String directorId) {
        // 检查
        if(directorId == null) return new ArrayList<>();

        // 队列
        Queue<User> qu = new LinkedList<>();
        List<User> list = userDao.getEmp(directorId);

        list.forEach(user -> qu.offer(user)); // 填充到qu中


        while(!qu.isEmpty()){
            User cur = qu.poll();       // 得到每一个user
            String dId = cur.getId();   // 获取员工id
            List<User> tmp = userDao.getEmp(dId);    // 利用该员工id获取他的员工
            tmp.forEach(user -> {
                if(!list.contains(user)){   // equals
                    qu.offer(user);
                    list.add(user);
                }
            }); // 再把所有的员工
        }

        return list;    // 返回所有员工
    }
}
